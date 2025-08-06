import 'package:ESGVida/pkg/ext.dart';
import 'package:ESGVida/pkg/language.dart';

import 'package:ESGVida/pkg/style_color.dart';
import 'package:ESGVida/screens/post/id/widgets/comment_list/controller.dart';
import 'package:ESGVida/widgets/loadings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../comment_feed_preview.dart';

class CommentList extends StatelessWidget {
  final int postId;
  const CommentList({super.key, required this.postId});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PostCommentController(postId: postId));
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification notification) {
          _onScrollEnd(notification);
          return true;
        },
        child: SingleChildScrollView(
          child: SizedBox(
            height: size.height * 0.6,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 3.5,
                  margin: const EdgeInsets.only(
                    top: 13,
                  ),
                  width: 38,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      5,
                    ),
                    color: Colors.black54,
                  ),
                ),
                10.height,
                Text(
                  LanguageGlobalVar.Comments.tr,
                  style: CommonStyle.black15Medium,
                ),
                10.height,
                const Divider(
                  color: Colors.black,
                  height: 2.5,
                  thickness: 1.2,
                ),
                2.height,
                Obx(() {
                  if (controller.isPageDataFirstLoading.value) {
                    return Padding(
                      padding: EdgeInsets.only(
                        top: size.height * 0.25,
                      ),
                      child: loadingWidget(),
                    );
                  } else if (controller.pageData.isEmpty) {
                    return Padding(
                        padding: EdgeInsets.only(top: size.height * 0.3),
                        child: Text(
                          LanguageGlobalVar.NoCommentFound.tr,
                          style: CommonStyle.grey14Regular,
                        ));
                  } else {
                    return Column(
                        children: controller.pageData
                            .mapIndexed((e, i) => CommentFeedPreview(
                                  index: i,
                                  data: controller.pageData[i],
                                ))
                            .toList());
                  }
                }),
                Obx(() {
                  if (controller.isMorePageDataLoading.isTrue) {
                    return loadingWidget();
                  } else if (!controller.hasNext) {
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Center(
                        child: Text(LanguageGlobalVar.NO_MORE.tr),
                      ),
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                }),
              ],
            ),
          ),
        ),
      ),
      bottomSheet: Obx(
        () => controller.isViewEditComment.value
            ? Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
                child: Row(
                  children: [
                    Flexible(
                      child: TextFormField(
                        autofocus: true,
                        controller: controller.commentContentController,
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
                          hintText: "Enter comment",
                          hintStyle: CommonStyle.grey14Medium,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          controller.editCommentOnUserPost();
                        },
                        child: Obx(
                          () => controller.editCommentOnUserPostIsLoading.value
                              ? const SizedBox(
                                  height: 24,
                                  width: 24,
                                  child: CircularProgressIndicator(
                                    color: Colors.blue,
                                    strokeWidth: 2.2,
                                  ),
                                )
                              : const Icon(
                                  Icons.send,
                                  color: Colors.blue,
                                  size: 24,
                                ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            : const SizedBox(),
      ),
    );
  }

  void _onScrollEnd(ScrollNotification notification) {
    final controller = Get.find<PostCommentController>();
    if (notification.metrics.pixels == notification.metrics.maxScrollExtent &&
        controller.hasNext &&
        controller.isMorePageDataLoading.isFalse) {
      controller.fetchMorePageData();
    }
  }
}
