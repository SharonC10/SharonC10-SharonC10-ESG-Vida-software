import 'dart:io';
import 'dart:math';

import 'package:ESGVida/pkg/toast.dart';

import 'package:ESGVida/screens/post/add/screen.dart';
import 'package:camera/camera.dart';
import 'package:get/get.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

const RECORD_PREPARE = 1;
const RECORDING = 2;
const RECORD_OVER = 3;

class VideoRecordPostController extends GetxController {
  Future<void>? cameraValue;
  String outputPath = "";
  final stopWatchTimer = StopWatchTimer();
  late List<CameraDescription> cameraDescriptionList;
  final cameraController = Rxn<CameraController?>();
  final isCameraLoading = true.obs;
  final needFlash = false.obs;
  final currentCameraLensDirection = (CameraLensDirection.front).obs;
  final transform = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    init();
  }

  @override
  void onClose() {
    cameraController.value?.dispose();
    super.onClose();
  }

  void init() async {
    try {
      isCameraLoading.value = true;
      cameraDescriptionList = await availableCameras();

      late CameraLensDirection defaultLensDirection = CameraLensDirection.back;
      CameraDescription? defaultCameraDescription =
          cameraDescriptionList.firstWhereOrNull(
        (e) => e.lensDirection == defaultLensDirection,
      );
      if (defaultCameraDescription == null) {
        defaultLensDirection = CameraLensDirection.front;
        defaultCameraDescription = cameraDescriptionList.firstWhereOrNull(
          (e) => e.lensDirection == defaultLensDirection,
        );
      }
      if (defaultCameraDescription == null) {
        showToast(
            "can't find back or front camera, here are $cameraDescriptionList");
        return;
      }
      final cameraControllerVal = CameraController(
        defaultCameraDescription,
        ResolutionPreset.medium,
      );
      await cameraControllerVal.initialize();
      changeLensDirectionIcon(defaultLensDirection);
      currentCameraLensDirection.value = defaultLensDirection;
      cameraController.value = cameraControllerVal;
    } finally {
      isCameraLoading.value = false;
    }
  }

  final state = RECORD_PREPARE.obs;

  Future<void> onState() async {
    if (state.value == RECORD_PREPARE) {
      await onStartRecord();
    }
  }

  Future<void> onStartRecord() async {
    outputPath = "";
    await cameraController.value!.startVideoRecording();
    stopWatchTimer.onStartTimer();
    state.value = RECORDING;
  }

  Future<void> onStopRecord() async {
    final file = await cameraController.value!.stopVideoRecording();
    stopWatchTimer.onStopTimer();
    state.value = RECORD_OVER;
    outputPath = File(file.path).path;
  }

  void onReStartRecord() {}

  Future<void> takePhoto() async {
    XFile file = await cameraController.value!.takePicture();
    Get.off(
      () => PostAddScreen(
        mediaPathList: [file.path.toString()],
      ),
    );
  }

  void toggleLensDirection() async {
    try {
      isCameraLoading.value = true;
      final current = currentCameraLensDirection.value;
      late CameraLensDirection target;
      if (cameraDescriptionList.isEmpty ||
          current == CameraLensDirection.external) {
        return;
      }
      if (current == CameraLensDirection.front) {
        target = CameraLensDirection.back;
      } else {
        target = CameraLensDirection.front;
      }

      final targetCameraDescription = cameraDescriptionList.firstWhereOrNull(
        (e) => e.lensDirection == target,
      );
      if (targetCameraDescription == null) {
        showToast("can't find the ${target.name} camera");
        return;
      }
      cameraController.value = CameraController(
        targetCameraDescription,
        ResolutionPreset.medium,
      );
      await cameraController.value!.initialize();
      changeLensDirectionIcon(current);
      currentCameraLensDirection.value = target;
    } finally {
      isCameraLoading.value = false;
    }
  }

  void changeLensDirectionIcon(CameraLensDirection current) {
    transform.value = current == CameraLensDirection.front ? pi : 0;
  }
}
