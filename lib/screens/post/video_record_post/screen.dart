import 'package:ESGVida/pkg/ext.dart';
import 'package:ESGVida/pkg/toast.dart';

import 'package:ESGVida/pkg/style_color.dart';
import 'package:ESGVida/screens/post/add/screen.dart';
import 'package:ESGVida/widgets/loadings.dart';
import 'package:ESGVida/widgets/video_player_widget.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

import 'controller.dart';

class VideoRecordPostScreen extends StatelessWidget {
  const VideoRecordPostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GetX<VideoRecordPostController>(
      init: VideoRecordPostController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.black,
            actions: [
              if (controller.currentCameraLensDirection.value ==
                  CameraLensDirection.back)
                Container(
                  height: 60,
                  alignment: Alignment.centerLeft,
                  width: size.width,
                  color: Colors.black,
                  child: IconButton(
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
                            .setFlashMode(FlashMode.torch);
                      } else {
                        controller.cameraController.value!
                            .setFlashMode(FlashMode.off);
                      }
                    },
                  ),
                ),
            ],
          ),
          body: controller.isCameraLoading.value
              ? loadingWidget()
              : Stack(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Container(
                            color: Colors.black,
                          ),
                        ),
                        controller.state.value == RECORD_OVER
                            ? Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                width: size.width,
                                height: size.height,
                                child: controller.outputPath.isEmpty
                                    ? const Center(
                                        child: Text("video path is empty"),
                                      )
                                    : CustomVideoPlayer(
                                        thumbnailLink: "",
                                        videoLink: controller.outputPath,
                                      ),
                              )
                            : SizedBox(
                                width: size.width,
                                child: CameraPreview(
                                  controller.cameraController.value!,
                                ),
                              ),
                        Expanded(
                          child: Container(
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                      bottom: 0.0,
                      left: 0.0,
                      right: 0.0,
                      child: controller.state.value == RECORDING
                          ? Container(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Column(
                                children: [
                                  StreamBuilder<int>(
                                    stream: controller.stopWatchTimer.rawTime,
                                    initialData: 0,
                                    builder: (context, snapshot) {
                                      return Container(
                                        alignment: Alignment.center,
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 18,
                                          horizontal: 20,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.black26,
                                          borderRadius: BorderRadius.circular(
                                            15,
                                          ),
                                        ),
                                        child: Text(
                                          StopWatchTimer.getDisplayTime(
                                            snapshot.data ?? 0,
                                          ),
                                          style: CommonStyle.white14Regular,
                                        ),
                                      );
                                    },
                                  ),
                                  35.height,
                                  InkWell(
                                    onTap: () async {
                                      controller.onStopRecord();
                                    },
                                    child: CircleAvatar(
                                      backgroundColor: Colors.white,
                                      radius: 35,
                                      child: Container(
                                        height: 15,
                                        width: 15,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            2,
                                          ),
                                          color: Colors.red,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : Container(
                              color: Colors.black,
                              padding: const EdgeInsets.only(
                                top: 10,
                                bottom: 10,
                              ),
                              width: size.width,
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  // 取消录视频
                                  InkWell(
                                    onTap: () {
                                      Get.back();
                                    },
                                    child: const Text(
                                      "Cancel",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                  //开始 或者 重新 录制视频
                                  InkWell(
                                    onTap: () async {
                                      controller.onState();
                                    },
                                    child: CircleAvatar(
                                      backgroundColor: Colors.white,
                                      radius: 35,
                                      child:
                                          controller.state.value == RECORD_OVER
                                              ? const CircleAvatar(
                                                  backgroundColor: Colors.white,
                                                  radius: 35,
                                                  child: Icon(
                                                    Icons.autorenew_outlined,
                                                    color: Colors.black87,
                                                    size: 30,
                                                  ),
                                                )
                                              : const CircleAvatar(
                                                  radius: 8,
                                                  backgroundColor:
                                                      CommonColor.primaryColor,
                                                ),
                                    ),
                                  ),
                                  if (controller.state.value == RECORD_OVER)
                                    InkWell(
                                      onTap: () {
                                        if (controller.outputPath.isEmpty) {
                                          showToast("video path is empty");
                                          return;
                                        }
                                        Get.to(
                                          () => PostAddScreen(
                                            mediaPathList: [
                                              controller.outputPath
                                            ],
                                          ),
                                        );
                                      },
                                      child: const SizedBox(
                                        height: 50,
                                        width: 50,
                                        child: Center(
                                          child: Text(
                                            "OK",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  if (controller.state.value != RECORD_OVER)
                                    //反转摄像头 或者 结束录制视频且退出
                                    Container(
                                      padding: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: Colors.white,
                                          width: 0.5,
                                        ),
                                      ),
                                      child: IconButton(
                                        icon: Transform.rotate(
                                          angle: controller.transform.value,
                                          child: const Icon(
                                            Icons.flip_camera_ios,
                                            color: Colors.white,
                                            size: 25,
                                          ),
                                        ),
                                        onPressed: () {
                                          controller.toggleLensDirection();
                                        },
                                      ),
                                    )
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
