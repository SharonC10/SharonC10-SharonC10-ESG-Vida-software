import 'dart:io';

import 'package:ESGVida/pkg/constants/common.dart';
import 'package:ESGVida/pkg/toast.dart';
import 'package:ESGVida/pkg/utils/common.dart';
import 'package:ESGVida/pkg/utils/file.dart';
import 'package:ESGVida/pkg/ext.dart';
import 'package:ESGVida/screens/post/id/widgets/comment_list/controller.dart';
import 'package:ESGVida/pkg/language.dart';

import 'package:ESGVida/pkg/style_color.dart';
import 'package:ESGVida/screens/post/id/controller.dart';
import 'package:ESGVida/screens/gallery/model.dart';
import 'package:ESGVida/screens/gallery/screen.dart';
import 'package:ESGVida/widgets/adaptive_image.dart';
import 'package:ESGVida/widgets/adaptive_video_player.dart';
import 'package:ESGVida/widgets/cacheable_image.dart';
import 'package:ESGVida/widgets/loadings.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:readmore/readmore.dart';
import 'package:share_plus/share_plus.dart';
import 'package:http/http.dart' as http;

import 'widgets/comment_list/screen.dart';

class PostScreen extends StatelessWidget {
  final int id;
  const PostScreen({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return GetX<PostController>(
      init: PostController(detailId: id),
      initState: (state) {
        state.controller!.fetchDetail();
      },
      builder: (controller) {
        final size = MediaQuery.sizeOf(context);
        return Scaffold(
          backgroundColor: const Color(0xFFF5F7FA),
          appBar: AppBar(
            elevation: 2,
            scrolledUnderElevation: 0,
            shadowColor: CommonColor.primaryColor.withOpacity(0.2),
            titleSpacing: 0,
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            toolbarHeight: 40,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  width: 20,
                ),
                GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.black,
                      size: 21,
                    )),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  LanguageGlobalVar.POST_DETAIL.tr,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                )
              ],
            ),
          ),
          body: controller.isDetailLoading.value
              ? loadingWidget()
              : ListView(
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  children: [
                    10.height,
                    Stack(
                      children: [
                        CarouselSlider(
                            options: CarouselOptions(
                              viewportFraction: 1,
                              initialPage: 0,
                              autoPlay: false,
                              autoPlayInterval: const Duration(seconds: 5),
                              height: size.height * 0.5,
                              onPageChanged: (i, reason) {
                                controller.currentMediaIndex.value = i;
                              },
                            ),
                            items: controller.detail.medias.map((mediaUrl) {
                              final isVideo = FileUtils.isSupport(
                                  CommonConstant.SUPPORTED_VIDEO, mediaUrl);
                              return Builder(
                                builder: (BuildContext context) {
                                  return InkWell(
                                    onTap: () {
                                      Get.to(() => GalleryImageViewWrapper(
                                            titleGallery:
                                                LanguageGlobalVar.IMAGE_VIEW.tr,
                                            galleryItems: List.generate(
                                              controller.detail.medias.length,
                                              (index) => GalleryItemModel(
                                                id: "$index",
                                                imageUrl: controller
                                                    .detail.medias[index],
                                              ),
                                            ),
                                            backgroundDecoration:
                                                const BoxDecoration(
                                              color: Colors.black,
                                            ),
                                            scrollDirection: Axis.horizontal,
                                          ));
                                    },
                                    child: isVideo
                                        ? AdaptiveVideoPlayer(
                                            uri: mediaUrl,
                                            onInit: (flickManager) {},
                                            onDispose: () {},
                                            maxHightGetter:
                                                (size, aspectRatio) =>
                                                    aspectRatio > 1
                                                        ? null
                                                        : size.height * 0.5,
                                            maxWidthGetter:
                                                (size, aspectRatio) =>
                                                    aspectRatio > 1
                                                        ? size.width
                                                        : null,
                                          )
                                        : AdaptiveImage(
                                            imageUrl: mediaUrl,
                                          ),
                                  );
                                },
                              );
                            }).toList()),
                        Positioned(
                          bottom: 10,
                          left: 0,
                          right: 0,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: controller.detail.medias
                                  .mapIndexed((mediaUrl, index) {
                                final isDisplaying =
                                    controller.currentMediaIndex.value == index;
                                return Container(
                                  height: 6.0,
                                  width: isDisplaying ? 12.0 : 7.0,
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 2.0),
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(12),
                                    ),
                                    color: isDisplaying
                                        ? CommonColor.primaryColor
                                        : CommonColor.accentColor,
                                  ),
                                );
                              }).toList()),
                        ),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: InkWell(
                            onTap: () {},
                            child: Container(
                              height: 25,
                              decoration: const BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(5),
                                  bottomLeft: Radius.circular(5),
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  controller.detail.createAt!
                                      .toFriendlyDatetimeStr(),
                                  style: CommonStyle.white12Bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    5.height,
                    Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: CommonColor.primaryColor.withOpacity(0.03),
                            spreadRadius: 0.8,
                            blurRadius: 0.8,
                          ),
                        ],
                      ),
                      width: size.width,
                      child: ListView(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10),
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                children: [
                                  GetBuilder<PostController>(
                                    id: "LIKE",
                                    builder: (control) {
                                      return InkWell(
                                        onTap: () {
                                          control.likePost();
                                        },
                                        child: Stack(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(10),
                                              child: control.detail.isLiked!
                                                  ? const Icon(
                                                      Icons.favorite,
                                                      color: Colors.red,
                                                      size: 35,
                                                    )
                                                  : const Icon(
                                                      Icons.favorite_border,
                                                      color: Colors.red,
                                                      size: 35,
                                                    ),
                                            ),
                                            Positioned(
                                              right: 0,
                                              top: 0,
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(6),
                                                decoration: const BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: CommonColor.blueAccent,
                                                ),
                                                child:
                                                    //Text("${int.parse(controller.commentPostList.length.toString())<99?controller.commentPostList.length:"99+"}",style: CommonStyle.white12Medium,),
                                                    Text(
                                                  FormatUtils.likeCount(
                                                    control.detail.likeCount!,
                                                  ),
                                                  style:
                                                      CommonStyle.white12Medium,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                              InkWell(
                                onTap: () {
                                  _handlerClickComment(context, controller);
                                },
                                child: Stack(
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.all(10),
                                      child: Icon(
                                        Icons.comment,
                                        color: Colors.black,
                                        size: 35,
                                      ),
                                    ),
                                    Positioned(
                                      right: 0,
                                      top: 0,
                                      child: Container(
                                        padding: const EdgeInsets.all(6),
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: CommonColor.blueAccent,
                                        ),
                                        child: GetBuilder<PostController>(
                                            id: "commentCount",
                                            builder: (control) {
                                              return Text(
                                                FormatUtils.likeCount(
                                                  control.detail.commentCount!,
                                                ),
                                                style:
                                                    CommonStyle.white12Medium,
                                              );
                                            }),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              //  if(details.share!.isNotEmpty)
                              InkWell(
                                onTap: () {
                                  _sharePost(controller.detail.coverUrl);
                                },
                                child: const Icon(
                                  Icons.share,
                                  color: Colors.black,
                                  size: 35,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    5.height,
                    Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: CommonColor.primaryColor.withOpacity(0.03),
                              spreadRadius: 0.8,
                              blurRadius: 0.8,
                            ),
                          ],
                        ),
                        width: size.width,
                        child: ListView(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 10,
                          ),
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(40),
                                  ),
                                  child: CommonChacheImage(
                                    imgHeight: 60,
                                    imgWidth: 60,
                                    url: controller.detail.userProfileUrl!,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                10.width,
                                Flexible(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        controller.detail.username!,
                                        style: CommonStyle.black16Bold,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.center,
                                      ),
                                      // 5.height,
                                      Text(
                                        controller
                                            .detail.heading!.capitalizeFirst!,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        style: CommonStyle.black16Medium,
                                      ),
                                      5.height,
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            ReadMoreText(
                              controller.detail.description!,
                              trimMode: TrimMode.Line,
                              trimLines: 3,
                              colorClickableText: Colors.black,
                              trimCollapsedText: 'Expand',
                              trimExpandedText: 'Show less',
                              moreStyle: CommonStyle.blue14Regular,
                              lessStyle: CommonStyle.blue14Regular,
                            ),
                          ],
                        )),
                    5.height,
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Text(
                        LanguageGlobalVar.COMMENT.tr,
                        style: CommonStyle.black14Medium,
                      ),
                    ),
                    5.height,
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: TextFormField(
                        controller: controller.commentContentController.value,
                        decoration: InputDecoration(
                          filled: true,
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 10,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none,
                          ),
                          fillColor: CommonColor.whiteColor,
                          hintText: LanguageGlobalVar.ENTER_COMMENT.tr,
                          hintStyle: CommonStyle.grey14Medium,
                        ),
                      ),
                    ),
                    85.height,
                  ],
                ),
          bottomNavigationBar: Container(
            height: 75,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: CommonColor.primaryColor.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 1,
                ),
              ],
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            width: size.width,
            child: ElevatedButton(
              onPressed: () {
                controller.addCommentOnUserPost(id);
              },
              child: controller.isAddCommentLoading.value
                  ? loadingButtonWidget()
                  : Text(
                      LanguageGlobalVar.COMMENT.tr,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                fixedSize: Size(size.width, size.height),
                maximumSize: Size(size.width, size.height),
                minimumSize: Size(size.width, size.height),
                elevation: 1,
                backgroundColor: CommonColor.primaryColor,
              ),
            ),
          ),
        );
      },
    );
  }

  void _handlerClickComment(BuildContext context, PostController controller) {
    final size = MediaQuery.sizeOf(context);
    showModalBottomSheet(
      isScrollControlled: true,
      constraints: BoxConstraints(maxWidth: size.width),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      context: context,
      builder: (context) {
        return Container(
          height: size.height * 0.6,
          width: size.width,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
            color: Color(0x33DCF0DD),
          ),
          child: CommentList(postId: id),
        );
      },
    ).then((value) {
      controller.updateAfterCommentModal();
      Get.delete<PostCommentController>();
    });
  }

  Future<void> _sharePost(String? coverUrl) async {
    if (coverUrl == null) {
      return;
    }
    showToast("Please wait");
    final cacheManager = Get.find<CacheManager>();
    String filepath = "";
    bool isImage =
        FileUtils.isSupport(CommonConstant.SUPPORTED_IMAGE, coverUrl);
    if (isImage) {
      var fileInfo = await cacheManager.getFileFromCache(coverUrl);
      fileInfo ??= await cacheManager.downloadFile(coverUrl);
      filepath = fileInfo.file.path;
    } else {
      final response = await http.get(Uri.parse(coverUrl));
      final documentDirectory = await getApplicationDocumentsDirectory();
      final file = File(FileUtils.join([
        documentDirectory.path,
        '${FileUtils.basenameWithoutExt(coverUrl)}_${DateTime.now()}.${FileUtils.filext(coverUrl)}'
      ]));
      file.writeAsBytesSync(response.bodyBytes);
      filepath = file.path;
    }
    XFile file = XFile(filepath);
    await Share.shareXFiles(
      [file],
      subject: '*EsdVida*',
      text: "\nDownload the app from Play Store by clicking the below link"
          "\n${Platform.isAndroid ? "https://play.google.com/store/apps/details?id=com.esgvida.social.apps" : "https://apps.apple.com/us/app/esgvida/id6504095654"}",
    );
  }
}
