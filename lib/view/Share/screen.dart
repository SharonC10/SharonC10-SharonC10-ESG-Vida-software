import 'package:ESGVida/pkg/constants/common.dart';
import 'package:ESGVida/pkg/toast.dart';
import 'package:ESGVida/pkg/utils/file.dart';
import 'package:ESGVida/screens/post/camera_post/screen.dart';
import 'package:ESGVida/screens/post/video_record_post/screen.dart';
import 'package:ESGVida/pkg/language.dart';

import 'package:ESGVida/pkg/ext.dart';
import 'package:ESGVida/pkg/style_color.dart';
import 'package:ESGVida/screens/post/add/screen.dart';
import 'package:ESGVida/pkg/utils/location.dart';
import 'package:ESGVida/widgets/album_media_picker.dart';
import 'package:ESGVida/widgets/loadings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShareAndPostScreen extends StatelessWidget {
  const ShareAndPostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          children: [
            10.height,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: 110,
                  padding: const EdgeInsets.only(
                    left: 8,
                    right: 8,
                    top: 5,
                    bottom: 5,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(
                        5,
                      ),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: CommonColor.primaryColor.withOpacity(0.12),
                        spreadRadius: 0.8,
                        blurRadius: 1,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      IconButton(
                        onPressed: () async {
                          loadLocationIfHasNotLoad();
                          Get.to(
                            () => const CameraPostScreen(),
                          );
                        },
                        icon: const Icon(
                          Icons.camera_alt,
                          size: 50,
                          color: Colors.black87,
                        ),
                      ),
                      Text(
                        LanguageGlobalVar.Photo_Taking.tr,
                        style: CommonStyle.black18Medium,
                      )
                    ],
                  ),
                ),
                InkWell(
                  onTap: () async {
                    loadLocationIfHasNotLoad();

                    Get.to(
                      () => const VideoRecordPostScreen(),
                    );
                  },
                  child: Container(
                    height: 110,
                    // width: width*0.45,
                    margin: const EdgeInsets.only(left: 10),
                    padding: const EdgeInsets.only(
                      left: 8,
                      right: 8,
                      top: 5,
                      bottom: 5,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(5),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: CommonColor.primaryColor.withOpacity(0.12),
                          spreadRadius: 0.8,
                          blurRadius: 1,
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        const Icon(
                          Icons.video_call,
                          size: 65,
                          color: Colors.black87,
                        ),
                        Text(
                          LanguageGlobalVar.Video_Taking.tr,
                          style: CommonStyle.black18Medium,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            10.height,
            Expanded(
              child: AlbumMediaPicker(
                onSelectOne: (selectedMedia) {
                  if (selectedMedia.file == null) {
                    print("esgvida: selectedMedia.file is null");
                    return false;
                  }
                  if (CommonConstant.SUPPORT_EXT_LIST.contains(
                      FileUtils.filext(selectedMedia.file!.path)
                          .toLowerCase())) {
                    return true;
                  }
                  showToast("Only ${CommonConstant.SUPPORT_EXT_LIST}");
                  return false;
                },
                onPicked: (List<Media> selectedMediaList) {
                  if (selectedMediaList.isEmpty) {
                    showToast("Please select media file");
                    return;
                  }
                  final mediaPathList = selectedMediaList
                      .map((e) => e.file!.path.toString())
                      .toList();
                  Get.to(() => PostAddScreen(
                        mediaPathList: mediaPathList,
                      ));
                },
                decoration: AlbumPickerDecoration(
                  headerLogoBuilder: (ctx) {
                    return Container(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Text(
                        LanguageGlobalVar.Media.tr,
                        style: CommonStyle.black18Medium,
                      ),
                    );
                  },
                  albumTextStyle: CommonStyle.black12Medium,
                  completeText: LanguageGlobalVar.COMPLETE.tr,
                  completeTextStyle: CommonStyle.white12Bold,
                  completeButtonStyle: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.green,
                    disabledBackgroundColor: Colors.grey,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    padding: EdgeInsets.zero,
                    minimumSize: const Size(80, 24),
                  ),
                  selectedBadgeBackgroundColor: Colors.green,
                  loadingWidgetBuilder: (ctx) {
                    return loadingWidget();
                  },
                ),
              ),
            ),
            10.height,
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  LanguageGlobalVar.Max_10picsChoose.tr,
                  style: CommonStyle.black16Medium,
                )
              ],
            ),
            10.height,
          ],
        ),
      ),
    );
  }
}
