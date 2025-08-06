import 'dart:io';

import 'package:ESGVida/pkg/constants/common.dart';
import 'package:ESGVida/pkg/utils/file.dart';
import 'package:ESGVida/screens/video_thumbnail_picker/screen.dart';
import 'package:ESGVida/pkg/language.dart';

import 'package:ESGVida/pkg/ext.dart';
import 'package:ESGVida/pkg/style_color.dart';
import 'package:ESGVida/screens/post/add/controller.dart';
import 'package:ESGVida/widgets/loadings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_editor_plus/image_editor_plus.dart';
// import 'package:image_editor_plus/utils.dart';
import 'package:path_provider/path_provider.dart';

import 'widgets/media_display.dart';

class PostAddScreen extends StatelessWidget {
  const PostAddScreen({Key? key, required this.mediaPathList})
      : super(key: key);
  final List<String> mediaPathList;

  @override
  Widget build(BuildContext context) {
    return GetX<PostAddController>(
      init: PostAddController(),
      initState: (v) {
        v.controller!.mediaPathList.value = mediaPathList;
      },
      builder: (controller) {
        final size = MediaQuery.sizeOf(context);
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            surfaceTintColor: Colors.white,
            scrolledUnderElevation: 0,
            foregroundColor: Colors.white,
            backgroundColor: Colors.white,
            elevation: 0,
            leading: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: InkWell(
                onTap: () {
                  Get.back();
                },
                child: const Icon(
                  Icons.close,
                  color: Colors.black,
                  size: 28,
                ),
              ),
            ),
            titleSpacing: 0,
            title: Text(
              LanguageGlobalVar.EDIT.tr,
              style: CommonStyle.black18Medium,
            ),
            actions: controller.mediaPathList.isNotEmpty
                ? []
                : _buildActions(context, controller),
          ),
          body: SingleChildScrollView(
            physics: const ScrollPhysics(),
            child: controller.mediaPathList.isEmpty
                ? const Center(child: Text("No Select Image Or Video"))
                : Column(
                    children: [
                      const MediaDisplay(),
                      Align(
                        alignment: Alignment.centerRight,
                        child: ElevatedButton(
                          onPressed: () {
                            final meidaPath = controller.currentMediaPath();
                            final ext =
                                FileUtils.filext(meidaPath).toLowerCase();
                            if (CommonConstant.SUPPORTED_IMAGE.contains(ext)) {
                              controller.selectedCoverPath = meidaPath;
                              controller.selectedCoverIndex.value =
                                  controller.selectedMediaIndex.value;
                              return;
                            } else if (CommonConstant.SUPPORTED_VIDEO
                                .contains(ext)) {
                              controller.flickManager?.flickVideoManager
                                  ?.videoPlayerController
                                  ?.pause();
                              Get.to(VideoThumbnailPickerScreen(
                                videoPath: meidaPath,
                                onSelect: (String thumbnailPath) {
                                  controller.selectedCoverPath = thumbnailPath;
                                  controller.selectedCoverIndex.value =
                                      controller.selectedMediaIndex.value;
                                },
                              ));
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: CommonColor.secondaryColor,
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text(
                            LanguageGlobalVar.CHOOSE_AS_COVER.tr,
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      20.height,
                      if (controller.selectedCoverIndex.value != -1)
                        SizedBox(
                          height: size.height * 0.3,
                          child: Image.file(
                            File(controller.selectedCoverPath),
                          ),
                        ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              LanguageGlobalVar.Heading.tr,
                              style: CommonStyle.black18Medium,
                            )
                          ],
                        ),
                      ),
                      5.height,
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: TextFormField(
                          controller: controller.headingController.value,
                          maxLength: 60,
                          maxLines: 2,
                          decoration: InputDecoration(
                            filled: true,
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 12,
                              horizontal: 10,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                color: Colors.grey,
                                width: 1,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                color: Colors.grey,
                                width: 1,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                color: Colors.grey,
                                width: 1,
                              ),
                            ),
                            fillColor: CommonColor.whiteColor,
                            hintText: LanguageGlobalVar.ENTER_TITLE.tr,
                            hintStyle: CommonStyle.grey14Medium,
                          ),
                        ),
                      ),
                      10.height,
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              LanguageGlobalVar.Description.tr,
                              style: CommonStyle.black18Medium,
                            )
                          ],
                        ),
                      ),
                      5.height,
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: TextFormField(
                          controller: controller.descriptionController.value,
                          maxLines: 5,
                          decoration: InputDecoration(
                            filled: true,
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 12,
                              horizontal: 10,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                color: Colors.grey,
                                width: 1,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                color: Colors.grey,
                                width: 1,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                color: Colors.grey,
                                width: 1,
                              ),
                            ),
                            fillColor: CommonColor.whiteColor,
                            hintText: LanguageGlobalVar.ENTER_DESCRIPTION.tr,
                            hintStyle: CommonStyle.grey14Medium,
                          ),
                        ),
                      ),
                      80.height
                    ],
                  ),
          ),
          bottomSheet: Container(
            height: 75,
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 15,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: CommonColor.secondaryColor.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 1),
              ],
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            width: MediaQuery.of(context).size.width,
            child: ElevatedButton(
              onPressed: () {
                controller.addUserPost();
              },
              style: ElevatedButton.styleFrom(
                fixedSize: Size(
                  MediaQuery.of(context).size.width,
                  40,
                ),
                backgroundColor: CommonColor.secondaryColor,
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: controller.addUserPosIsLoading.value
                  ? loadingButtonWidget()
                  : Text(
                      LanguageGlobalVar.SEND.tr,
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
            ),
          ),
        );
      },
    );
  }

  List<Widget> _buildActions(BuildContext ctx, PostAddController controller) {
    final selectedIndex = controller.selectedMediaIndex.value;
    if (controller.mediaPathList[selectedIndex].endsWith(".mp4")) {
      return [];
    }

    final imageEditorWidget = GetBuilder<PostAddController>(
      builder: (control) {
        return Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: InkWell(
            onTap: () async {
              _onEditeImage(ctx, control);
            },
            child: Image.asset(
              "assets/images/edit-image.png",
              height: 24,
            ),
          ),
        );
      },
    );

    return [imageEditorWidget];
  }

  Future<void> _onEditeImage(
      BuildContext ctx, PostAddController controller) async {
    final selectedIndex = controller.selectedMediaIndex.value;
    File imageFile = File(controller.mediaPathList[selectedIndex]);
    if (!imageFile.existsSync()) {
      throw Exception('File not found');
    }
    List<int> imageBytes = imageFile.readAsBytesSync();
    var editedImage = await Navigator.push(
      ctx,
      MaterialPageRoute(
        builder: (context) => ImageEditor(
          image: Uint8List.fromList(imageBytes),
          // features: const ImageEditorFeatures(
          //   flip: true,
          //   crop: true,
          //   blur: true,
          //   brush: true,
          //   emoji: true,
          //   filters: true,
          //   rotate: true,
          //   text: true,
          // ),
        ),
      ),
    );
    if (editedImage == null || editedImage.isEmpty) {
      return;
    }
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/editImage${DateTime.now()}');
    await file.writeAsBytes(editedImage);
    controller.mediaPathList[selectedIndex] = file.path;
    controller.update();
  }
}
