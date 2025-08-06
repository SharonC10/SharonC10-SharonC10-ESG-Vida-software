import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get/get.dart';

class AdaptiveImage extends StatefulWidget {
  final String imageUrl;
  final void Function(double aspectRatio) onInit;
  final void Function() onDispose;
  final double? Function(Size size, double aspectRatio) maxHightGetter;
  final double? Function(Size size, double aspectRatio) maxWidthGetter;

  const AdaptiveImage({
    super.key,
    required this.imageUrl,
    this.onInit = _defaultOnInit,
    this.onDispose = _defaultOnDispose,
    this.maxHightGetter = _defaultMaxHightGetter,
    this.maxWidthGetter = _defaultMaxWidthGetter,
  });

  @override
  State<AdaptiveImage> createState() => _AdaptiveImageState();

  static void _defaultOnInit(double aspectRatio) {}
  static void _defaultOnDispose() {}
  static double? _defaultMaxHightGetter(Size size, double aspectRatio) {
    return aspectRatio > 1 ? null : size.height * 0.5;
  }

  static double? _defaultMaxWidthGetter(Size size, double aspectRatio) {
    return aspectRatio > 1 ? size.width : null;
  }
}

class _AdaptiveImageState extends State<AdaptiveImage> {
  bool isLoading = true;
  double? aspectRatio;

  @override
  void initState() {
    super.initState();
    _loadImage();
  }

  @override
  void didUpdateWidget(AdaptiveImage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.imageUrl != widget.imageUrl) {
      _loadImage();
    }
  }

  @override
  void dispose() {
    widget.onDispose();
    super.dispose();
  }

  void _loadImage() async {
    isLoading = true;
    final cacheManager = Get.find<CacheManager>();
    final fileInfo = await cacheManager.getFileFromCache(widget.imageUrl);

    if (fileInfo == null) {
      // 如果缓存中没有，先下载
      await cacheManager.downloadFile(widget.imageUrl);
    }

    final imageProvider = CachedNetworkImageProvider(
      widget.imageUrl,
      cacheManager: cacheManager,
    );

    imageProvider.resolve(ImageConfiguration.empty).addListener(
      ImageStreamListener((ImageInfo info, bool _) {
        if (!mounted) return;
        setState(() {
          aspectRatio = info.image.width / info.image.height;
          isLoading = false;
          widget.onInit(aspectRatio!);
        });
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading || aspectRatio == null) {
      return Image.asset(
        'assets/loading.gif',
        fit: BoxFit.cover,
      );
    }

    final size = MediaQuery.sizeOf(context);

    return Center(
      child: SizedBox(
        height: widget.maxHightGetter(size, aspectRatio!),
        width: widget.maxWidthGetter(size, aspectRatio!),
        child: AspectRatio(
          aspectRatio: aspectRatio!,
          child: CachedNetworkImage(
            cacheManager: Get.find<CacheManager>(),
            imageUrl: widget.imageUrl,
            fit: BoxFit.cover,
            placeholder: (context, url) => Image.asset(
              'assets/loading.gif',
              fit: BoxFit.cover,
            ),
            errorWidget: (context, url, error) => Image.asset(
              'assets/loading.gif',
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
