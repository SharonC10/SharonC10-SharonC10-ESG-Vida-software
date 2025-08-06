import 'package:ESGVida/screens/post/camera_post/controller.dart';

import 'package:ESGVida/widgets/loadings.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CameraPostScreen extends StatelessWidget {
  const CameraPostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GetX<CameraPostController>(
      init: CameraPostController(),
      builder: (controller) {
        return Scaffold(
          body: controller.isCameraLoading.value
              ? loadingWidget()
              : Stack(
                  children: [
                    Column(
                      children: [
                        Expanded(
                          child: Container(
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          width: size.width,
                          child: CameraPreview(
                            controller.cameraController.value!,
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                      bottom: 0.0,
                      child: Container(
                        color: Colors.black,
                        padding: const EdgeInsets.only(
                          top: 5,
                          bottom: 5,
                        ),
                        width: size.width,
                        child: Column(
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                // 闪光灯
                                Obx(
                                  () => controller.currentCameraLensDirection
                                              .value ==
                                          CameraLensDirection.front
                                      ? const SizedBox.shrink()
                                      : IconButton(
                                          icon: Icon(
                                            controller.needFlash.value
                                                ? Icons.flash_on
                                                : Icons.flash_off,
                                            color: Colors.white,
                                            size: 28,
                                          ),
                                          onPressed: () {
                                            controller.needFlash.toggle();
                                            if (controller.needFlash.value) {
                                              controller.cameraController.value!
                                                  .setFlashMode(
                                                      FlashMode.torch);
                                            } else {
                                              controller.cameraController.value!
                                                  .setFlashMode(FlashMode.off);
                                            }
                                          },
                                        ),
                                ),
                                // 拍照按钮
                                GestureDetector(
                                  onTap: () {
                                    controller.takePhoto();
                                  },
                                  child: const Icon(
                                    Icons.panorama_fish_eye,
                                    color: Colors.white,
                                    size: 70,
                                  ),
                                ),
                                // 反转摄像头按钮
                                Obx(
                                  () => IconButton(
                                    icon: Transform.rotate(
                                      angle: controller.transform.value,
                                      child: const Icon(
                                        Icons.flip_camera_ios,
                                        color: Colors.white,
                                        size: 28,
                                      ),
                                    ),
                                    onPressed: () {
                                      controller.toggleLensDirection();
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
        );
      },
    );
  }
}
