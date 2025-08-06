import 'package:ESGVida/pkg/constants/common.dart';
import 'package:ESGVida/pkg/ext.dart';
import 'package:ESGVida/pkg/language.dart';
import 'package:ESGVida/pkg/style_color.dart';
import 'package:ESGVida/pkg/utils/file.dart';
import 'package:ESGVida/screens/gallery/model.dart';
import 'package:ESGVida/screens/gallery/screen.dart';
import 'package:ESGVida/screens/shopping/product/id/controller.dart';
import 'package:ESGVida/widgets/adaptive_image.dart';
import 'package:ESGVida/widgets/adaptive_video_player.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MediaSlider extends StatelessWidget {
  const MediaSlider({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final controller = Get.find<ProductController>();
    return Stack(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            viewportFraction: 1,
            enableInfiniteScroll:
                controller.detail.value!.getMediaList().length > 1,
            height: size.height * 0.5,
            onPageChanged: (i, reason) {
              controller.selectMediaIndex.value = i;
            },
          ),
          items: controller.detail.value!.getMediaList().map((slide) {
            return InkWell(
              onTap: () {
                Get.to(
                  () => GalleryImageViewWrapper(
                    titleGallery: LanguageGlobalVar.IMAGE_VIEW.tr,
                    galleryItems: List.generate(
                      controller.detail.value!.getMediaList().length,
                      (index) => GalleryItemModel(
                        id: "$index",
                        imageUrl:
                            controller.detail.value!.getMediaList()[index],
                      ),
                    ),
                    backgroundDecoration: const BoxDecoration(
                      color: Colors.black,
                    ),
                    initialIndex: controller.selectMediaIndex.value,
                    scrollDirection: Axis.horizontal,
                  ),
                );
              },
              child: FileUtils.isSupport(CommonConstant.SUPPORTED_VIDEO, slide)
                  ? SizedBox(
                      height: size.height * 0.5,
                      width: size.width,
                      child: AdaptiveVideoPlayer(
                        uri: slide,
                      ),
                    )
                  : ClipRRect(
                      child: Container(
                        height: size.height * 0.5,
                        width: size.width,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                        ),
                        child: AdaptiveImage(
                          imageUrl: slide,
                        ),
                      ),
                    ),
            );
          }).toList(),
        ),
        if (controller.detail.value!.getMediaList().length != 1)
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:
                  controller.detail.value!.getMediaList().mapIndexed((_, i) {
                return Obx(
                  () => Container(
                    height: 6.0,
                    width: controller.selectMediaIndex.value == i ? 12.0 : 7.0,
                    margin: const EdgeInsets.symmetric(horizontal: 2.0),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(12),
                      ),
                      color: controller.selectMediaIndex.value == i
                          ? CommonColor.primaryColor
                          : CommonColor.accentColor,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        Positioned(
          top: 0,
          left: 0,
          child: InkWell(
            onTap: () => Get.back(),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey.shade400,
              ),
              child: const Icon(
                Icons.close,
                color: CommonColor.whiteColor,
                size: 24,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
