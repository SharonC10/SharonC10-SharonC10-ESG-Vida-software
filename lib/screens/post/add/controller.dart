import 'package:ESGVida/pkg/constants/common.dart';
import 'package:ESGVida/pkg/ext.dart';
import 'package:ESGVida/pkg/inmemory_data.dart';
import 'package:ESGVida/pkg/toast.dart';
import 'package:ESGVida/pkg/utils/file.dart';
import 'package:ESGVida/provider/post.dart';
import 'package:ESGVida/view/main/bottom_nav_screen.dart';
import 'package:ESGVida/pkg/language.dart';

import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class PostAddController extends GetxController {
  final postProvider = Get.find<PostProvider>();
  final selectedMediaIndex = 0.obs;
  final mediaPathList = <String>[].obs;
  final selectedCoverIndex = (-1).obs;
  String selectedCoverPath = "";

  final headingController = TextEditingController().obs;
  final descriptionController = TextEditingController().obs;

  final addUserPosIsLoading = false.obs;

  FlickManager? flickManager;

  String currentMediaPath() {
    return mediaPathList[selectedMediaIndex.value];
  }

  bool isSelectedCover() {
    return selectedMediaIndex.value == selectedCoverIndex.value;
  }

  Future<void> addUserPost() async {
    if (selectedCoverIndex.value == -1) {
      showToast("${LanguageGlobalVar.SELECT_VIDEO_THUMBNAIL.tr} ??");
      return;
    }
    addUserPosIsLoading.value = true;
    final heading = headingController.value.text;
    final description = descriptionController.value.text;
    if (heading.isEmpty) {
      showToast("Please enter heading");
      return;
    } else if (heading.isEmpty) {
      showToast("Please enter description");
      return;
    }
    final (longitude, latitude, address) = await GlobalInMemoryData.I.getGEO();
    postProvider
        .add(
            formData: FormData({
      "heading": heading,
      "description": description,
      "lat": latitude,
      "lng": longitude,
      "address": address,
      "cover": MultipartFile(selectedCoverPath,
          filename: selectedCoverPath.filename(),
          contentType:
              "image/${FileUtils.filext(selectedCoverPath).substring(1)}"),
      "medias": mediaPathList
          .map((path) => MultipartFile(path,
              filename: path.filename(),
              contentType:
                  "${FileUtils.isSupport(CommonConstant.SUPPORTED_VIDEO, path) ? "video" : "image"}"
                  "/${FileUtils.filext(path).substring(1)}"))
          .toList()
    }))
        .then((value) {
      if (value.isFail) {
        return;
      }
      Get.offAll(
        () => DashBordScreen(
          selectedIndex: 0,
        ),
      );
    }).whenComplete(() {
      addUserPosIsLoading.value = false;
    });
  }
}
