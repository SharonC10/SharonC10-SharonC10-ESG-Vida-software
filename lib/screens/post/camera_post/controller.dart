import 'dart:math';

import 'package:ESGVida/pkg/toast.dart';

import 'package:ESGVida/screens/post/add/screen.dart';
import 'package:camera/camera.dart';
import 'package:get/get.dart';

class CameraPostController extends GetxController {
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

  Future<void> init() async {
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
        ResolutionPreset.ultraHigh,
      );
      await cameraControllerVal.initialize();
      changeLensDirectionIcon(defaultLensDirection);
      currentCameraLensDirection.value = defaultLensDirection;
      cameraController.value = cameraControllerVal;
    } finally {
      isCameraLoading.value = false;
    }
  }

  Future<void> takePhoto() async {
    XFile file = await cameraController.value!.takePicture();
    Get.off(
      () => PostAddScreen(
        mediaPathList: [file.path.toString()],
      ),
    );
  }

  Future<void> toggleLensDirection() async {
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
        ResolutionPreset.ultraHigh,
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
