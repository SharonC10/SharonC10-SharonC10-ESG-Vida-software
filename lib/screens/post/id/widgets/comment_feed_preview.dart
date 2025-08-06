import 'package:ESGVida/model/post/comment/feed.dart';
import 'package:ESGVida/pkg/ext.dart';
import 'package:ESGVida/pkg/inmemory_data.dart';
import 'package:ESGVida/screens/post/id/widgets/comment_list/controller.dart';
import 'package:ESGVida/pkg/language.dart';
import 'package:ESGVida/pkg/style_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommentFeedPreview extends StatelessWidget {
  final int index;
  final PostCommentFeedModel data;
  const CommentFeedPreview({
    super.key,
    required this.data,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PostCommentController>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(
            left: 15,
            right: 0,
            top: 5,
          ),
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: data.userProfileUrl == null
                ? const DecorationImage(
                    image: AssetImage(
                      "assets/images/profileImage.png",
                    ),
                    fit: BoxFit.cover,
                  )
                : DecorationImage(
                    image: NetworkImage("${data.userProfileUrl}"),
                    fit: BoxFit.cover,
                  ),
          ),
        ),
        Flexible(
          child: Container(
            padding: const EdgeInsets.symmetric(
              vertical: 5,
              horizontal: 5,
            ),
            margin: const EdgeInsets.symmetric(
              vertical: 5,
              horizontal: 10,
            ),
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
                    Text(
                      data.username!,
                      style: CommonStyle.black15400,
                      overflow: TextOverflow.ellipsis,
                    ),
                    10.width,
                    Text(
                      data.createAt!.toFriendlyDatetimeStr(),
                      style: CommonStyle.grey12Regular,
                    ),
                    const Spacer(),
                    data.userId == GlobalInMemoryData.I.userId
                        ? InkWell(
                            onTap: () {
                              controller.isViewEditComment.value = true;
                              controller.editingCommentIndex = index;
                              controller.commentContentController.text =
                                  data.text!;
                            },
                            child: Icon(
                              Icons.edit,
                              size: 20,
                              color: Colors.grey.shade500,
                            ),
                          )
                        : const SizedBox(),
                    10.width,
                    data.userId == GlobalInMemoryData.I.userId
                        ? InkWell(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return CupertinoAlertDialog(
                                    title: Text(
                                      LanguageGlobalVar
                                          .ASK_WANT_TO_DELETE_COMMENT.tr,
                                      style: CommonStyle.black16Medium,
                                    ),
                                    actions: [
                                      InkWell(
                                        onTap: () {
                                          Get.back();
                                        },
                                        child: Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(
                                              12.0,
                                            ),
                                            child: Text(
                                              LanguageGlobalVar.CANCEL.tr,
                                            ),
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          controller.deletePostComment(
                                            commentId: data.id!,
                                          );
                                        },
                                        child: Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(
                                              12.0,
                                            ),
                                            child: Text(
                                              LanguageGlobalVar.DELETE.tr,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              );
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
                    data.text!,
                    style: CommonStyle.black13400,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
