import 'dart:core';

import 'package:ESGVida/pkg/ext.dart';
import 'package:ESGVida/pkg/utils/common.dart';
import 'package:ESGVida/pkg/language.dart';

import 'package:ESGVida/pkg/style_color.dart';
import 'package:ESGVida/widgets/favority.dart';
import 'package:ESGVida/screens/gallery/model.dart';
import 'package:ESGVida/screens/gallery/screen.dart';
import 'package:ESGVida/widgets/adaptive_image.dart';
import 'package:ESGVida/widgets/loadings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import 'controller.dart';
import 'modal_comment_list.dart';
import 'widgets/comment_editor.dart';

class NewsScreen extends StatelessWidget {
  final int id;

  const NewsScreen({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    Get.put(NewsDetailsController());
    return GetBuilder<NewsDetailsController>(
      initState: (state) {
        Get.find<NewsDetailsController>().fetchNews(newsId: id);
      },
      builder: (controller) {
        if (controller.isNewsLoading.value) {
          return Scaffold(
            backgroundColor: const Color(0xFFF5F7FA),
            appBar: AppBar(),
            body: Center(
              child: loadingWidget(),
            ),
          );
        }
        final size = MediaQuery.sizeOf(context);
        return Scaffold(
          backgroundColor: const Color(0xFFF5F7FA),
          appBar: AppBar(
            elevation: 2,
            actions: [
              InkWell(
                onTap: () {
                  launchUrl(Uri.parse(controller.news.hyperlink.toString()));
                },
                child: const Icon(
                  Icons.link,
                  color: Colors.blue,
                  size: 30,
                ),
              ),
              20.width,
            ],
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
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  "${LanguageGlobalVar.News.tr} ${LanguageGlobalVar.Details.tr}",
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 16),
                  textAlign: TextAlign.center,
                )
              ],
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                10.height,
                Stack(
                  children: [
                    //image
                    InkWell(
                      onTap: () {
                        Get.to(
                          () => GalleryImageViewWrapper(
                            titleGallery: "Image View",
                            galleryItems: List.generate(
                              [controller.news.images].length,
                              (index) => GalleryItemModel(
                                id: "$index",
                                imageUrl: controller.news.images.toString(),
                              ),
                            ),
                            backgroundDecoration: const BoxDecoration(
                              color: Colors.black,
                            ),
                            loadingBuilder: (context, event) {
                              return Image.asset(
                                'assets/loading.gif',
                                fit: BoxFit.cover,
                              );
                            },
                            scrollDirection: Axis.horizontal,
                          ),
                        );
                      },
                      child: Container(
                        height: size.height * 0.35,
                        width: size.width,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                        ),
                        child: AdaptiveImage(
                          imageUrl: controller.news.images.toString(),
                        ),
                      ),
                    ),

                    //date
                    Positioned(
                      top: 0,
                      right: 0,
                      child: controller.news.date.toString() == "null"
                          ? const SizedBox()
                          : Container(
                              height: 25,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(2),
                                  color: Colors.black54),
                              child: Center(
                                child: Text(
                                  DateFormat("dd MMM yyyy").format(
                                      DateTime.parse(
                                          controller.news.date.toString())),
                                  style: CommonStyle.white12Medium,
                                ),
                              ),
                            ),
                    ),

                    //like
                    Positioned(
                      right: 10,
                      bottom: 110,
                      child: InkWell(
                          onTap: () {
                            controller.handlerLike();
                          },
                          child: GetBuilder<NewsDetailsController>(
                            id: "likeCount",
                            builder: (control) {
                              if (control.isLikeLoading.value) {
                                return const CircularProgressIndicator(
                                  color: Colors.red,
                                );
                              }
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5),
                                child: Column(
                                  children: [
                                    FavouriteButton(
                                      like: controller
                                              .news.userInteraction!.liked ??
                                          false,
                                    ),
                                    Text(
                                      FormatUtils.likeCount(
                                          controller.news.likeCount!),
                                      style: CommonStyle.grey12Medium,
                                    ),
                                  ],
                                ),
                              );
                            },
                          )),
                    ),

                    //comment list
                    Positioned(
                      right: 10,
                      bottom: 50,
                      child: InkWell(
                        onTap: () {
                          _onClickCommentListButton(context, controller);
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Column(
                            children: [
                              const Icon(
                                Icons.comment,
                                color: Colors.grey,
                                size: 35,
                              ),
                              GetBuilder<NewsDetailsController>(
                                id: "commentCount",
                                builder: (controller) {
                                  return Text(
                                    FormatUtils.likeCount(
                                        controller.news.commentCount ?? 0),
                                    style: CommonStyle.grey12Medium,
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                5.height,
                //content and commentEditor
                Container(
                  alignment: Alignment.center,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
                  child: Column(
                    children: [
                      Text(
                        "${controller.news.title}",
                        style: CommonStyle.blackBold.copyWith(fontSize: 24),
                      ),
                      Text(
                        '''${controller.news.description}''',
                        style: CommonStyle.grey14Medium,
                      ),
                      //comment editor
                      CommentEditor(
                        onUpload: (content) async {
                          return controller.newsAddComment(content);
                        },
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _onClickCommentListButton(
      BuildContext context, NewsDetailsController controller) {
    final size = MediaQuery.of(context).size;
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
        return ModelCommentList(newsId: controller.news.id!);
      },
    ).then((_) {
      controller.fetchNews(newsId: controller.news.id!);
    });
  }
}
