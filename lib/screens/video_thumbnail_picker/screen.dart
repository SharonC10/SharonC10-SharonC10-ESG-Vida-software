import 'dart:io';

import 'package:ESGVida/pkg/toast.dart';
import 'package:ESGVida/pkg/language.dart';

import 'package:ESGVida/widgets/fields/number_range_field.dart';
import 'package:ESGVida/widgets/loadings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flick_video_player/flick_video_player.dart';

import 'controller.dart';

class VideoThumbnailPickerScreen extends StatelessWidget {
  final String videoPath;
  final void Function(String thumbnailPath) onSelect;
  const VideoThumbnailPickerScreen({
    Key? key,
    required this.videoPath,
    required this.onSelect,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return GetX<VideoThumbnailController>(
      init: VideoThumbnailController(videoPath),
      assignId: true,
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: Text(LanguageGlobalVar.SELECT_VIDEO_THUMBNAIL.tr),
            actions: [
              IconButton.outlined(
                onPressed: () {
                  final thumbnailPath = controller.thumbnailPath.value;
                  if (thumbnailPath == null || thumbnailPath.isEmpty) {
                    showToast(
                        "${LanguageGlobalVar.SELECT_VIDEO_THUMBNAIL.tr} ?");
                    return;
                  }
                  onSelect(thumbnailPath);
                  Get.back();
                },
                icon: const Icon(
                  Icons.check,
                  color: Colors.green,
                ),
              ),
            ],
          ),
          body: controller.isVideoPlayerLoading.value
              ? loadingWidget()
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      Obx(
                        () => SizedBox(
                          height: controller.aspectRatio.value > 1
                              ? null
                              : size.height * 0.5,
                          width: controller.aspectRatio.value > 1
                              ? size.width
                              : null,
                          child: AspectRatio(
                            aspectRatio: controller.aspectRatio.value,
                            child: FlickVideoPlayer(
                              flickManager: controller.flickManager,
                              flickVideoWithControls:
                                  const FlickVideoWithControls(
                                controls: FlickPortraitControls(),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Obx(
                        () => controller.maxLoading.value
                            ? loadingWidget()
                            : Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    controller.maxHours != 0
                                        ? _buildTimeInput(
                                            controller.hoursTC,
                                            controller.maxHours,
                                            'H',
                                          )
                                        : const SizedBox.shrink(),
                                    controller.maxMinutes != 0
                                        ? _buildTimeInput(
                                            controller.minutesTC,
                                            controller.maxMinutes,
                                            'M',
                                          )
                                        : const SizedBox.shrink(),
                                    controller.maxSeconds != 0
                                        ? _buildTimeInput(
                                            controller.secondsTC,
                                            controller.maxSeconds,
                                            'S',
                                          )
                                        : const SizedBox.shrink(),
                                    const SizedBox(width: 16),
                                    controller.isGeneratingThumbnail.value
                                        ? loadingWidget()
                                        : ElevatedButton(
                                            onPressed: controller.seekToTime,
                                            child: Text(
                                                LanguageGlobalVar.SKIP_TO.tr),
                                          ),
                                  ],
                                ),
                              ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Obx(
                              () => controller.isGeneratingThumbnail.value
                                  ? loadingWidget()
                                  : ElevatedButton(
                                      onPressed:
                                          controller.isGeneratingThumbnail.value
                                              ? null
                                              : controller.randomThumbnail,
                                      child: Text(LanguageGlobalVar.RANDOM.tr),
                                    ),
                            ),
                            Obx(
                              () => controller.isGeneratingThumbnail.value
                                  ? loadingWidget()
                                  : ElevatedButton(
                                      onPressed:
                                          controller.isGeneratingThumbnail.value
                                              ? null
                                              : controller.generateThumbnail,
                                      child:
                                          Text(LanguageGlobalVar.GENERATE.tr),
                                    ),
                            ),
                          ],
                        ),
                      ),
                      Obx(
                        () => controller.thumbnailPath.value == null
                            ? const SizedBox.shrink()
                            : SizedBox(
                                height: size.height * 0.5,
                                child: AspectRatio(
                                  aspectRatio: controller.aspectRatio.value,
                                  child: Image.file(
                                    File(controller.thumbnailPath.value!),
                                    key: ValueKey(controller.generateAt.value),
                                  ),
                                  // child: Image(
                                  //   image: CacheControllableFileImage(
                                  //     File(controller.thumbnailPath.value!),
                                  //     cacheKey:
                                  //         controller.generateAt.value.toString(),
                                  //   ),
                                  // ),
                                ),
                              ),
                      ),
                    ],
                  ),
                ),
        );
      },
    );
  }

  Widget _buildTimeInput(
      TextEditingController tec, int maxValue, String label) {
    return Container(
      width: 60,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      child: NumberField<int>(
        label: label,
        min: 0,
        max: maxValue,
        tec: tec,
      ),
    );
  }
}
