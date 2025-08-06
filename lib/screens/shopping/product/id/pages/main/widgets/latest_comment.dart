import 'package:ESGVida/pkg/language.dart';
import 'package:ESGVida/pkg/style_color.dart';
import 'package:ESGVida/pkg/toast.dart';
import 'package:ESGVida/screens/shopping/product/id/controller.dart';
import 'package:ESGVida/screens/shopping/product/id/pages/page_enum.dart';
import 'package:ESGVida/screens/shopping/product/id/pages/main/widgets/comment_preview.dart';
import 'package:ESGVida/widgets/loadings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LatestComment extends StatelessWidget {
  const LatestComment({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX<ProductController>(
      builder: (controller) {
        if (controller.isLatestCommentListLoading.isTrue) {
          return loadingWidget();
        }
        if (controller.latestCommentList.isEmpty) {
          return Center(child: Text(LanguageGlobalVar.NO_COMMENT_YET.tr));
        }
        final size = MediaQuery.sizeOf(context);
        return Container(
          color: CommonColor.whiteColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: size.width,
                margin: const EdgeInsets.only(bottom: 5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "${LanguageGlobalVar.PRODUCT_COMMENT.tr}(${controller.detail.value!.commentCount})",
                      style: CommonStyle.black16Bold,
                    ),
                    InkWell(
                      onTap: () {
                        if (controller.detail.value!.commentCount! >
                            ProductController.MAX_LATEST_COMMENT_SIZE) {
                          controller.currentPage.value =
                              ProductPageEnum.COMMENT;
                        } else {
                          showToast(LanguageGlobalVar.NO_MORE_COMMENT_YET.tr);
                        }
                        //debug
                        // controller.toCommentPage();
                      },
                      child: Row(
                        children: [
                          Text(LanguageGlobalVar.VIEW_ALL.tr),
                          const Icon(
                            Icons.arrow_right,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                itemCount: controller.latestCommentList.length,
                itemBuilder: (context, index) {
                  final data = controller.latestCommentList[index];
                  return CommentPreview(
                    data,
                    onDelete: (comment) async {
                      //最新comment，删除一条评论后直接重新拉取
                      await controller.fetchLatestComments();
                    },
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
