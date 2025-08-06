import 'package:ESGVida/pkg/style_color.dart';
import 'package:ESGVida/widgets/video_player_widget.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:get/get.dart';

import 'model.dart';

// to view image in full screen
class GalleryImageViewWrapper extends StatefulWidget {
  final LoadingBuilder? loadingBuilder;
  final BoxDecoration? backgroundDecoration;
  final int? initialIndex;
  final PageController pageController;
  final List<GalleryItemModel> galleryItems;
  final Axis scrollDirection;
  final String? titleGallery;

  GalleryImageViewWrapper({
    Key? key,
    this.loadingBuilder,
    this.titleGallery,
    this.backgroundDecoration,
    this.initialIndex,
    required this.galleryItems,
    this.scrollDirection = Axis.horizontal,
  })  : pageController = PageController(initialPage: initialIndex ?? 0),
        super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _GalleryImageViewWrapperState();
  }
}

class _GalleryImageViewWrapperState extends State<GalleryImageViewWrapper> {
  final minScale = PhotoViewComputedScale.contained * 0.8;
  final maxScale = PhotoViewComputedScale.covered * 8;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CommonColor.bgColor,
      appBar: AppBar(
        elevation: 2,
        shadowColor: Colors.grey,
        titleSpacing: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        toolbarHeight: 40,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              width: 20,
            ),
            GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                  size: 21,
                )),
            const SizedBox(
              width: 5,
            ),
            Text(
              widget.titleGallery ?? "Gallery",
              style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 16),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
      body: Container(
        decoration: widget.backgroundDecoration,
        constraints: BoxConstraints.expand(
          height: MediaQuery.of(context).size.height,
        ),
        child: PhotoViewGallery.builder(
          scrollPhysics: const BouncingScrollPhysics(),
          builder: _buildImage,
          itemCount: widget.galleryItems.length,
          loadingBuilder: widget.loadingBuilder,
          backgroundDecoration: widget.backgroundDecoration,
          pageController: widget.pageController,
          scrollDirection: widget.scrollDirection,
        ),
      ),
    );
  }

// build image with zooming
  PhotoViewGalleryPageOptions _buildImage(BuildContext context, int index) {
    final GalleryItemModel item = widget.galleryItems[index];
    return PhotoViewGalleryPageOptions.customChild(
      child: item.imageUrl.split(".").last == "mp4"
          ? SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.5,
              width: MediaQuery.sizeOf(context).width,
              child: CustomVideoPlayer(
                thumbnailLink: "",
                videoLink: item.imageUrl,
              ))
          : CachedNetworkImage(
              cacheManager: Get.find<CacheManager>(),
              imageUrl: item.imageUrl,
              placeholder: (context, url) =>
                  const Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
      initialScale: PhotoViewComputedScale.contained,
      minScale: minScale,
      maxScale: maxScale,
      heroAttributes: PhotoViewHeroAttributes(tag: item.id),
    );
  }
}
