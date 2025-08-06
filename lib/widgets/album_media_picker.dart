import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:media_picker_widget/media_picker_widget.dart';
import 'package:photo_manager/photo_manager.dart';

class AlbumMediaPicker extends StatefulWidget {
  final Function(List<Media> selectedMediaList) onPicked;
  final bool Function(Media selectedMedia) onSelectOne;
  final bool allowLimitedPermission;
  final Widget Function(BuildContext ctx, Widget albumSelectorWidget)?
      headerBuilder;
  final List<Media> presetSelectedMediaList;

  const AlbumMediaPicker({
    super.key,
    required this.onPicked,
    this.decoration = const AlbumPickerDecoration(),
    this.allowLimitedPermission = true,
    this.headerBuilder,
    this.presetSelectedMediaList = const [],
    this.onSelectOne = _defaultOnSelectOne,
  });
  static bool _defaultOnSelectOne(_) => true;
  final AlbumPickerDecoration decoration;

  @override
  State<StatefulWidget> createState() => _AlbumMediaPickerState();
}

class _AlbumMediaPickerState extends State<AlbumMediaPicker> {
  late int _selectedAlbumIndex;
  late final CompleteBtnNotifier _isCompleteBtnNotifier;
  late final Future<List<AssetPathEntity>> _albums;
  late List<MediaViewModel> _selectedMediaList;

  @override
  void initState() {
    super.initState();
    _isCompleteBtnNotifier = CompleteBtnNotifier(enable: false);
    _albums = _fetchAlbums(MediaType.all, false);

    _selectedAlbumIndex = 0;
    _selectedMediaList =
        MediaUtils.toMediaViewList(widget.presetSelectedMediaList);
  }

  @override
  void didUpdateWidget(covariant AlbumMediaPicker oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget != widget) {
      _selectedAlbumIndex = 0;
      _selectedMediaList =
          MediaUtils.toMediaViewList(widget.presetSelectedMediaList);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _isCompleteBtnNotifier.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _albums,
      builder: (ctx, snapshot) {
        if (snapshot.hasError) {
          // return _ErrorWidget(error: snapshot.error);
          return _ErrorWidget(error: snapshot.error, message: '',);
        } else if (!snapshot.hasData) {
          return widget.decoration.loadingWidgetBuilder != null
              ? widget.decoration.loadingWidgetBuilder!(context)
              : _LoadingWidget();
        } else if (snapshot.hasData && snapshot.data?.isEmpty == true) {
          return NoMedia(text: widget.decoration.noMedia);
        }
        final albumList = snapshot.data!;
        final selectedAlbum = albumList[_selectedAlbumIndex];
        final albumSelectorWidget = _albumDropdownMenu(albumList);
        return Column(children: [
          if (widget.headerBuilder != null)
            widget.headerBuilder!.call(context, albumSelectorWidget)
          else
            _headerBuilder(albumSelectorWidget),
          Expanded(
              child: AlbumGridWidget(
            album: selectedAlbum,
            selectedMediaList: _selectedMediaList,
            onClickAlbumItem: _onClickAlbumItem,
            decoration: widget.decoration,
          )),
        ]);
      },
    );
  }

  Future<void> _onClickAlbumItem(
      bool isSelected, MediaViewModel clickItem) async {
    if (isSelected &&
        !_selectedMediaList.any((element) => element.id == clickItem.id) &&
        widget.onSelectOne(await MediaUtils.toMedia(clickItem, -1))) {
      _selectedMediaList.add(clickItem);
    } else if (!isSelected) {
      _selectedMediaList.removeWhere((media) => clickItem.id == media.id);
    }
    _isCompleteBtnNotifier.setEnable(_selectedMediaList.isEmpty);
  }

  Widget _headerBuilder(DropdownButton2<String> albumSelectorWidget) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if (widget.decoration.headerLogoBuilder != null)
          widget.decoration.headerLogoBuilder!(context)
        else
          const Text("Media"),
        albumSelectorWidget,
        Flexible(
          child: ListenableBuilder(
            listenable: _isCompleteBtnNotifier,
            builder: (ctx, child) {
              return ElevatedButton(
                onPressed: () {
                  _onCompletePick();
                },
                style: widget.decoration.completeButtonStyle?.copyWith(
                    backgroundColor: widget.decoration
                        .completeBtnColor(_isCompleteBtnNotifier.enable)),
                child: Text(
                  "${widget.decoration.completeText}${_selectedMediaList.isNotEmpty && widget.decoration.completeTextWithSelectCount ? "(${_selectedMediaList.length})" : ""}",
                  style: widget.decoration.completeTextStyle ??
                      const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12),
                ),
              );
            },
          ),
        )
      ],
    );
  }

  void _onCompletePick() {
    MediaUtils.toMediaList(_selectedMediaList)
        .then((value) => widget.onPicked(value));
  }

  Future<List<AssetPathEntity>> _fetchAlbums(
      final MediaType mediaType, final bool allowLimitedPermission) async {
    var type = RequestType.common;
    if (mediaType == MediaType.all) {
      type = RequestType.common;
    } else if (mediaType == MediaType.video) {
      type = RequestType.video;
    } else if (mediaType == MediaType.image) {
      type = RequestType.image;
    }

    final result = await PhotoManager.requestPermissionExtend();
    if (!allowLimitedPermission && result == PermissionState.limited) {
      PhotoManager.openSetting();
      return [];
    } else if (result == PermissionState.authorized ||
        (result == PermissionState.limited && widget.allowLimitedPermission)) {
      return await PhotoManager.getAssetPathList(type: type);
    } else {
      PhotoManager.openSetting();
      return [];
    }
  }

  DropdownButton2<String> _albumDropdownMenu(List<AssetPathEntity> albumList) {
    final itemTextStyle = widget.decoration.albumTextStyle ??
        const TextStyle(
            fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black);
    return DropdownButton2<String>(
      isExpanded: true,
      hint: Text("Select a Album", style: itemTextStyle),
      items: albumList
          .map((AssetPathEntity album) => DropdownMenuItem<String>(
                value: album.id,
                child: Text(
                  album.name,
                  style: itemTextStyle,
                ),
              ))
          .toList(),
      value: albumList[_selectedAlbumIndex].id,
      onChanged: (String? value) {
        if (value == null) {
          return;
        }
        for (final indexWithEl in albumList.indexed) {
          if (value == indexWithEl.$2.id) {
            setState(() {
              _selectedAlbumIndex = indexWithEl.$1;
            });
          }
        }
      },
      buttonStyleData: const ButtonStyleData(
        padding: EdgeInsets.symmetric(horizontal: 16),
        height: 40,
        width: 140,
      ),
      menuItemStyleData: const MenuItemStyleData(
        height: 40,
      ),
    );
  }
}

class CompleteBtnNotifier with ChangeNotifier {
  late bool _enable;

  CompleteBtnNotifier({required bool enable}) {
    _enable = enable;
  }

  get enable => _enable;

  void update({bool? enable}) {
    _enable = enable ?? _enable;
    notifyListeners();
  }

  void setEnable(bool isSelectedMediaListEmpty) {
    bool? enable;
    if (isSelectedMediaListEmpty && _enable) {
      enable = false;
    } else if (!isSelectedMediaListEmpty && !_enable) {
      enable = true;
    }
    update(enable: enable);
  }
}

class NoMedia extends StatelessWidget {
  final String? text;

  const NoMedia({
    Key? key,
    this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.4,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.image_not_supported_outlined,
              size: 50,
            ),
            const SizedBox(height: 20),
            Text(
              text ?? 'No Images Available',
              style: const TextStyle(
                  fontSize: 22, fontWeight: FontWeight.bold, color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}

class AlbumGridWidget extends StatefulWidget {
  final AssetPathEntity album;
  final List<MediaViewModel> selectedMediaList;
  final ScrollController? scrollController;
  final alwaysShowSelectedFirst = true;
  final Future<void> Function(bool isSelected, MediaViewModel clickedMedia)
      onClickAlbumItem;
  final AlbumPickerDecoration decoration;

  const AlbumGridWidget(
      {super.key,
      required this.album,
      this.selectedMediaList = const [],
      this.scrollController,
      required this.onClickAlbumItem,
      required this.decoration});

  @override
  State<StatefulWidget> createState() => _AlbumGridWidgetState();
}

class _AlbumGridWidgetState extends State<AlbumGridWidget> {
  ThumbnailSize thumbnailSize = const ThumbnailSize(200, 200);
  int _currentPage = 0;
  late var _lastPage = _currentPage;
  final List<MediaViewModel> _mediaList = [];

  @override
  void initState() {
    super.initState();
    _fetchNewMedia(refresh: true);
  }

  @override
  void didUpdateWidget(covariant AlbumGridWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget != widget) {
      _fetchNewMedia(refresh: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification scroll) {
        _handleScrollEvent(scroll);
        return true;
      },
      child: GridView.builder(
        controller: widget.scrollController,
        itemCount: _mediaList.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: widget.decoration.columnCount,
          mainAxisExtent: 80,
          mainAxisSpacing: 5,
          crossAxisSpacing: 5,
        ),
        itemBuilder: (_, index) {
          final media = _mediaList[index];
          bool isSelected = false;
          int? selectedIndex;
          for (final indexedVal in widget.selectedMediaList.indexed) {
            if (indexedVal.$2.id == media.id) {
              isSelected = true;
              selectedIndex = indexedVal.$1;
              break;
            }
          }
          return AlbumItemWidget(
            media: _mediaList[index],
            onThumbnailLoad: (thumbnail) {
              if (_mediaList[index].thumbnail == null) {
                _mediaList[index].thumbnail = thumbnail;
              }
            },
            selectedIndex: selectedIndex,
            isSelected: isSelected,
            onClickItem: (isSelected, clickItem) async {
              await widget.onClickAlbumItem(isSelected, clickItem);
              if (!mounted) {
                return;
              }
              setState(() {});
            },
            decoration: widget.decoration,
          );
        },
      ),
    );
  }

  void _handleScrollEvent(ScrollNotification scroll) {
    if (scroll.metrics.pixels / scroll.metrics.maxScrollExtent > 0.33) {
      if (_currentPage != _lastPage) {
        print(
            "load more ${scroll.metrics.pixels}, ${scroll.metrics.maxScrollExtent}");
        _fetchNewMedia(
          refresh: false,
        );
      }
    }
  }

  void _fetchNewMedia({required bool refresh}) async {
    if (refresh) {
      setState(() {
        _currentPage = 0;
        _mediaList.clear();
        _mediaList.addAll(widget.selectedMediaList);
      });
    }
    _lastPage = _currentPage;
    final result = await PhotoManager.requestPermissionExtend();
    if (result == PermissionState.authorized ||
        result == PermissionState.limited) {
      final newAssets = await widget.album.getAssetListPaged(
        page: _currentPage,
        size: widget.decoration.columnCount * 10,
      );
      if (newAssets.isEmpty) {
        return;
      }
      final selectedIdSet = widget.selectedMediaList.map((el) => el.id).toSet();
      List<MediaViewModel> newMedias = [];
      for (var asset in newAssets) {
        if (!selectedIdSet.contains(asset.id)) {
          var media = _toMediaViewModel(asset);
          newMedias.add(media);
        }
      }
      setState(() {
        _mediaList.addAll(newMedias);
        _currentPage++;
      });
    } else {
      PhotoManager.openSetting();
    }
  }

  MediaViewModel _toMediaViewModel(AssetEntity entity) {
    var mediaType = MediaType.all;
    if (entity.type == AssetType.video) mediaType = MediaType.video;
    if (entity.type == AssetType.image) mediaType = MediaType.image;
    return MediaViewModel(
      id: entity.id,
      thumbnailAsync: entity.thumbnailDataWithSize(thumbnailSize),
      type: mediaType,
      thumbnail: null,
      videoDuration:
          entity.type == AssetType.video ? entity.videoDuration : null,
    );
  }
}

class AlbumItemWidget extends StatelessWidget {
  final MediaViewModel media;
  final Function(dynamic thumb) onThumbnailLoad;
  final Function(bool isSelected, MediaViewModel media) onClickItem;
  final bool isSelected;

  final Duration _duration = const Duration(milliseconds: 2000);
  final int? selectedIndex;
  final AlbumPickerDecoration decoration;

  const AlbumItemWidget({
    super.key,
    required this.media,
    required this.onThumbnailLoad,
    required this.onClickItem,
    this.isSelected = false,
    this.selectedIndex,
    required this.decoration,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
        opacity: 1,
        curve: Curves.easeOut,
        duration: _duration,
        child: FutureBuilder<Uint8List?>(future: Future<Uint8List?>(() async {
          var thumb = await media.thumbnailAsync;
          onThumbnailLoad(thumb);
          return thumb;
        }), builder: (context, snapshot) {
          Widget cardItem;
          bool canClick = false;
          if (snapshot.hasError) {
            // cardItem = _ErrorWidget(error: snapshot.error);
            cardItem = _ErrorWidget(error: snapshot.error, message: '',);
          }
          if (!snapshot.hasData) {
            cardItem = decoration.loadingWidgetBuilder != null
                ? decoration.loadingWidgetBuilder!(context)
                : _LoadingWidget();
          } else {
            canClick = media.thumbnail != null;
            cardItem = Stack(
              children: [
                Positioned.fill(
                  child: media.thumbnail != null
                      ? Stack(
                          children: [
                            Positioned.fill(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: ImageFiltered(
                                  imageFilter: ImageFilter.blur(
                                    sigmaX: 0,
                                    sigmaY: 0,
                                  ),
                                  child: AnimatedScale(
                                    duration: _duration,
                                    scale: 1,
                                    child: Image.memory(
                                      media.thumbnail!,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            if (media.type == MediaType.video)
                              _videoDurationWidgetBuilder(context),
                          ],
                        )
                      : Center(
                          child: Icon(
                            Icons.error_outline,
                            color: Colors.grey.shade400,
                            size: 40,
                          ),
                        ),
                ),
                if (isSelected) _selectedBadgeBuilder(context)
              ],
            );
          }
          return GestureDetector(
              onTap: () {
                if (canClick) {
                  onClickItem(!isSelected, media);
                }
              },
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Colors.grey,
                      width: 1,
                    ),
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(2, 4), // 偏移量
                        blurRadius: 2,
                      )
                    ]),
                child: Padding(
                  padding: const EdgeInsets.all(2),
                  child: cardItem,
                ),
              ));
        }));
  }

  Widget _videoDurationWidgetBuilder(BuildContext ctx) {
    if (decoration.videoDurationBuilder != null) {
      return decoration.videoDurationBuilder!(ctx, media.videoDuration!);
    }
    return Align(
      alignment: Alignment.bottomRight,
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 1,
            ),
          ],
          borderRadius: BorderRadius.circular(5),
        ),
        padding: const EdgeInsets.all(6),
        child: Text(
          formatTime(media.videoDuration),
          style: const TextStyle(
              fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }

  String formatTime(Duration? duration) {
    if (duration == null) return "";
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    if (duration.inHours == 0) return "$twoDigitMinutes:$twoDigitSeconds";
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  Widget _selectedBadgeBuilder(BuildContext context) {
    if (decoration.selectedBadgeBuilder != null) {
      return decoration.selectedBadgeBuilder!(context, selectedIndex!);
    }
    return Align(
        alignment: Alignment.topRight,
        child: Container(
            decoration: BoxDecoration(
              color: decoration.selectedBadgeBackgroundColor ??
                  Theme.of(context).primaryColor,
              shape: BoxShape.circle,
            ),
            padding: const EdgeInsets.all(5),
            child: selectedIndex == null
                ? const Icon(
                    Icons.done,
                    size: 16,
                    color: Colors.white,
                  )
                : Text(
                    (selectedIndex! + 1).toString(),
                    style: TextStyle(
                      color: decoration.selectedBadgeForegroundColor ??
                          Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  )));
  }
}

class _ErrorWidget extends StatelessWidget {
  final dynamic error;
  final String message;

  // const _ErrorWidget({required this.error});
   const _ErrorWidget({required this.error, required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Text("$message [${error.toString()}]",
          style: const TextStyle(
              fontSize: 22, fontWeight: FontWeight.bold, color: Colors.red)),
    );
  }
}

class _LoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: const CircularProgressIndicator(),
    );
  }
}

class MediaViewModel {
  final String id;
  Uint8List? thumbnail;
  final Future<Uint8List?>? thumbnailAsync;
  final MediaType? type;
  final Duration? videoDuration;

  MediaViewModel({
    required this.id,
    this.thumbnail,
    this.thumbnailAsync,
    this.type,
    this.videoDuration,
  });
}

class AlbumPickerDecoration {
  final Widget Function(BuildContext ctx)? headerLogoBuilder;

  // final Widget? cancelIcon;
  // final double blurStrength;
  // final double scaleAmount;
  // final Color selectedColor;
  final int columnCount;

  // final ActionBarPosition actionBarPosition;
  // final TextStyle? albumTitleStyle;
  final TextStyle? albumTextStyle;

  // final TextStyle? albumCountTextStyle;
  final String completeText;
  final bool completeTextWithSelectCount;
  final TextStyle? completeTextStyle;
  final ButtonStyle? completeButtonStyle;

  final String? noMedia;
  final Widget Function(BuildContext context)? loadingWidgetBuilder;

  final Widget Function(BuildContext context, int? index)? selectedBadgeBuilder;
  final Color? selectedBadgeBackgroundColor;
  final Color? selectedBadgeForegroundColor;

  final Function(BuildContext context, Duration? duration)?
      videoDurationBuilder;

  const AlbumPickerDecoration({
    this.headerLogoBuilder,
    // this.actionBarPosition = ActionBarPosition.top,
    // this.cancelIcon,
    this.columnCount = 3,
    // this.blurStrength = 10,
    // this.scaleAmount = 1.2,
    // this.albumTitleStyle,
    this.completeText = 'Continue',
    this.completeTextWithSelectCount = true,
    this.completeTextStyle,
    this.completeButtonStyle,
    this.albumTextStyle,
    // this.albumCountTextStyle,
    this.loadingWidgetBuilder,
    this.noMedia,
    this.videoDurationBuilder,
    this.selectedBadgeBuilder,
    this.selectedBadgeBackgroundColor,
    this.selectedBadgeForegroundColor,
    // this.selectedColor = Colors.black26,
  });

  WidgetStateProperty<Color?>? completeBtnColor(bool isEnabled) {
    Color? color;
    if (isEnabled) {
      color = completeButtonStyle?.backgroundColor?.resolve({});
    } else {
      color = completeButtonStyle?.backgroundColor
          ?.resolve({WidgetState.disabled});
    }
    return WidgetStateProperty.all(color);
  }
}

class Media {
  ///File saved on local storage
  final File? file;

  ///Unique id to identify
  final String id;

  ///A low resolution image to show as preview
  final Uint8List? thumbnail;

  ///The image file in bytes format
  final Uint8List? mediaByte;

  ///Image Dimensions
  final Size? size;

  ///Creation time of the media file on local storage
  final DateTime? creationTime;

  ///Last modified time of the media file on local storage
  final DateTime? modifiedTime;

  ///media name or title
  final String? title;

  ///latitude of the media file
  final double? latitude;

  ///longitude of the media file
  final double? longitude;

  ///Type of the media, Image/Video
  final MediaType? mediaType;

  ///Duration of the video
  final Duration? videoDuration;

  ///Index of selected image
  final int? index;

  Media({
    required this.id,
    this.file,
    this.thumbnail,
    this.mediaByte,
    this.size,
    this.creationTime,
    this.title,
    this.mediaType,
    this.videoDuration,
    this.modifiedTime,
    this.latitude,
    this.longitude,
    this.index,
  });
}

abstract class MediaUtils {
  static bool isVideo(MediaType mediaType) {
    return mediaType == MediaType.video;
  }

  static Future<Media> toMedia(MediaViewModel data, int index) async {
    var asset = await AssetEntity.fromId(data.id);
    if (asset == null) throw Exception('Asset not found');
    var media = Media(
      id: data.id,
      index: index,
      title: asset.title,
      thumbnail: data.thumbnail,
      size: asset.size,
      creationTime: asset.createDateTime,
      modifiedTime: asset.modifiedDateTime,
      latitude: asset.latitude,
      longitude: asset.longitude,
      file: await asset.file,
      mediaByte: await asset.originBytes,
      mediaType: data.type,
      videoDuration: asset.videoDuration,
    );
    return media;
  }

  static Future<List<Media>> toMediaList(List<MediaViewModel> data) async {
    var conversionTasks = <Future<Media>>[];
    for (int i = 0; i < data.length; i++) {
      conversionTasks.add(toMedia(data[i], i));
    }
    var results = await Future.wait(conversionTasks);
    results.sort((a, b) => (a.index ?? 0).compareTo(b.index ?? 0));
    return results;
  }

  static MediaViewModel toMediaView(Media data) {
    var media = MediaViewModel(
      id: data.id,
      thumbnail: data.thumbnail,
      type: data.mediaType,
    );
    return media;
  }

  static List<MediaViewModel> toMediaViewList(List<Media> data) {
    return data.map((e) => toMediaView(e)).toList();
  }
}
