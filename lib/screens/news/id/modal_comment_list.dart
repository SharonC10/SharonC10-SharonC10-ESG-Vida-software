import 'package:ESGVida/pkg/inmemory_data.dart';
import 'package:ESGVida/screens/news/id/widgets/comment_editor.dart';
import 'package:ESGVida/pkg/language.dart';

import 'package:ESGVida/pkg/ext.dart';
import 'package:ESGVida/pkg/style_color.dart';
import 'package:ESGVida/widgets/loadings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller.dart';

class ModelCommentList extends StatelessWidget {
  final int newsId;

  const ModelCommentList({super.key, required this.newsId});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return GetX<NewsCommentController>(
      init: NewsCommentController(newsId: newsId),
      initState: (v) {
        v.controller?.fetchCommentList();
      },
      builder: (controller) {
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
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 3.5,
                  margin: const EdgeInsets.only(top: 13),
                  width: 38,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
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
                Expanded(
                  child: _commentListBuilder(context, controller),
                ),
              ],
            ),
            //编辑自己的评论
            bottomSheet: Obx(
              () => controller.isEditingSelfComment.value
                  ? CommentEditor(
                      text: controller.editingCommentContent,
                      onUpload: (content) async {
                        return controller.updateComment(content);
                      },
                    )
                  : const SizedBox(),
            ),
          ),
        );
      },
    );
  }

  Widget _commentListBuilder(
      BuildContext context, NewsCommentController controller) {
    if (controller.isCommentListLoading.value) {
      return Padding(
        padding:
            EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.25),
        child: loadingWidget(),
      );
    }
    if (controller.newsCommentList.isEmpty) {
      return Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.3),
        child: Text(
          LanguageGlobalVar.NoCommentFound.tr,
          style: CommonStyle.grey14Regular,
        ),
      );
    }
    return ListView.builder(
      // controller: controller.scrollCommentsController,
      itemCount: controller.newsCommentList.length,
      padding: const EdgeInsets.only(bottom: 100),
      itemBuilder: (context, i) {
        var comment = controller.newsCommentList[i];
        final isSelfComment = comment.user?.id == GlobalInMemoryData.I.userId;
        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //用户头像
            Container(
              margin: const EdgeInsets.only(left: 15, right: 0, top: 5),
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: (comment.user?.profileImage?.isNil() ?? false)
                    ? const DecorationImage(
                        image: AssetImage("assets/images/profileImage.png"),
                        fit: BoxFit.cover,
                      )
                    : DecorationImage(
                        image: NetworkImage("${comment.user?.profileImage}"),
                        fit: BoxFit.cover,
                      ),
              ),
            ),
            Flexible(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7),
                  // color: Colors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        //用户名
                        Text(
                          "${comment.user?.firstName.toString()}",
                          style: CommonStyle.black15400,
                          overflow: TextOverflow.ellipsis,
                        ),
                        10.width,
                        //日期
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${comment.created?.toFriendlyDatetimeStr()}",
                              style: CommonStyle.grey12Regular,
                            ),
                            if (comment.updated != comment.created)
                              Row(
                                children: [
                                  Text(
                                    "${comment.updated?.toFriendlyDatetimeStr()}",
                                    style: CommonStyle.grey12Regular,
                                  ),
                                  const Icon(
                                    Icons.update,
                                    size: 10,
                                    color: Colors.blueAccent,
                                  ),
                                ],
                              ),
                          ],
                        ),
                        const Spacer(),
                        //编辑按钮
                        isSelfComment
                            ? InkWell(
                                onTap: () {
                                  controller.handlerEditSelfComment(i);
                                },
                                child: Icon(
                                  Icons.edit,
                                  size: 20,
                                  color: Colors.grey.shade500,
                                ),
                              )
                            : const SizedBox(),
                        10.width,
                        //删除按钮
                        isSelfComment
                            ? InkWell(
                                onTap: () {
                                  handlerDeleteSelfComment(context, i);
                                },
                                child: Icon(
                                  Icons.delete,
                                  size: 20,
                                  color: Colors.grey.shade500,
                                ),
                              )
                            : const SizedBox()
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 0.0),
                      child: Text(
                        '''${comment.content}''',
                        style: CommonStyle.black13400,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void handlerDeleteSelfComment(BuildContext context, int i) {
    showDialog(
      context: context,
      builder: (context) {
        return GetX<NewsCommentController>(
          builder: (controller) {
            return CupertinoAlertDialog(
              title: const Text(
                "Are you sure do you want to delete this comment ? ",
                style: CommonStyle.black16Medium,
              ),
              actions: [
                controller.isDeleteLoading.value
                    ? Center(
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          child: const CircularProgressIndicator(),
                        ),
                      )
                    : InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: const Center(
                          child: Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Text("Cancel"),
                          ),
                        ),
                      ),
                controller.isDeleteLoading.value
                    ? Center(
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          child: const CircularProgressIndicator(),
                        ),
                      )
                    : InkWell(
                        onTap: () async {
                          controller.deleteComment(i);
                        },
                        child: const Center(
                          child: Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Text("Delete"),
                          ),
                        ),
                      ),
              ],
            );
          },
        );
      },
    );
  }
}
