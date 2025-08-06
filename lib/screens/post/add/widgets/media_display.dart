import 'dart:io';

import 'package:ESGVida/pkg/constants/common.dart';
import 'package:ESGVida/pkg/utils/file.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller.dart';
import 'media_post_video_player.dart';

class MediaDisplay extends StatelessWidget {
  const MediaDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX<PostAddController>(
      builder: (controller) {
        final selectedIndex = controller.selectedMediaIndex.value;
        final selectedPath = controller.mediaPathList[selectedIndex];
        final isVideo = CommonConstant.SUPPORTED_VIDEO
            .contains(FileUtils.filext(selectedPath).toLowerCase());
        final size = MediaQuery.sizeOf(context);
        return Stack(
          children: [
            isVideo
                ? Container(
                    margin: const EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: MediaPostVideoPlayer(
                      path: selectedPath,
                      onInit: (flickManager) {
                        controller.flickManager = flickManager;
                      },
                      onDispose: () {
                        controller.flickManager = null;
                      },
                      maxHightGetter: (size, aspectRatio) =>
                          aspectRatio > 1 ? null : size.height * 0.5,
                      maxWidthGetter: (size, aspectRatio) =>
                          aspectRatio > 1 ? size.width : null,
                    ),
                  )
                : Container(
                    margin: const EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      image: DecorationImage(
                          image: FileImage(File(selectedPath)),
                          fit: BoxFit.contain),
                    ),
                    width: size.width,
                    height: size.height * 0.4,
                  ),
            controller.mediaPathList.length == 1
                ? const SizedBox.shrink()
                : Positioned(
                    left: 20,
                    top: 0,
                    bottom: 0,
                    child: CircleAvatar(
                      backgroundColor: Colors.black26,
                      radius: 15,
                      child: InkWell(
                        onTap: () {
                          if (controller.selectedMediaIndex.value > 0) {
                            controller.selectedMediaIndex.value--;
                          }
                        },
                        child: const Icon(
                          Icons.arrow_back_ios_sharp,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                    ),
                  ),
            controller.mediaPathList.length == 1
                ? const SizedBox.shrink()
                : Positioned(
                    right: 20,
                    top: 0,
                    bottom: 0,
                    child: CircleAvatar(
                      backgroundColor: Colors.black26,
                      radius: 15,
                      child: InkWell(
                        onTap: () {
                          if (controller.selectedMediaIndex.value <
                              controller.mediaPathList.length - 1) {
                            controller.selectedMediaIndex.value++;
                          }
                        },
                        child: const Icon(
                          Icons.arrow_forward_ios_sharp,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                    ),
                  )
          ],
        );
      },
    );
  }
}
