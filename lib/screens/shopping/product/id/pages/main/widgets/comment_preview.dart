import 'package:ESGVida/model/shopping.dart';
import 'package:ESGVida/pkg/ext.dart';
import 'package:ESGVida/pkg/inmemory_data.dart';
import 'package:ESGVida/pkg/language.dart';
import 'package:ESGVida/pkg/toast.dart';

import 'package:ESGVida/pkg/style_color.dart';
import 'package:ESGVida/screens/shopping/comment/add_or_update/screen.dart';
import 'package:ESGVida/widgets/loadings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:readmore/readmore.dart';

import '../../../controller.dart';

class CommentPreview extends StatelessWidget {
  final Rxn<ProductCommentModel> detail = Rxn();
  final isDeleteLoading = false.obs;
  final Future<void> Function(ProductCommentModel comment) onDelete;
  CommentPreview(
    ProductCommentModel detail, {
    super.key,
    required this.onDelete,
  }) {
    this.detail.value = detail;
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
        dense: true,
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  detail.value!.user!.fullName,
                  style: CommonStyle.primary14Bold,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                const Spacer(),
                // 自己的评论可编辑
                detail.value!.user!.id == GlobalInMemoryData.I.userId
                    ? InkWell(
                        onTap: () {
                          Get.to(() => AddOrUpdateCommentScreen(
                                productId: detail.value!.productId!,
                                data: detail.value!,
                              ))?.then((value) {
                            if (value != null) {
                              //不更新pageData里的数据
                              detail.value = value;
                            }
                          });
                        },
                        child: const Icon(
                          Icons.edit,
                        ),
                      )
                    : const SizedBox(),
                10.width,
                detail.value!.user!.id! == GlobalInMemoryData.I.userId
                    ? InkWell(
                        onTap: () async {
                          _handleDeleteComment(context);
                        },
                        child: const Icon(Icons.delete),
                      )
                    : const SizedBox()
                //  Text("3 Days ago",style: CommonStyle.primary8Medium,overflow: TextOverflow.ellipsis,maxLines: 1),
              ],
            ),
            RatingBarIndicator(
              rating: double.parse(detail.value!.rating!),
              itemBuilder: (context, index) => const Icon(
                Icons.star,
                color: Colors.amber,
              ),
              itemCount: 5,
              itemSize: 12.0,
              direction: Axis.horizontal,
            ),
            ReadMoreText(
              '${detail.value!.content}',
              trimLines: 2,
              colorClickableText: Colors.blue,
              trimMode: TrimMode.Line,
              trimCollapsedText: LanguageGlobalVar.EXPAND.tr,
              trimExpandedText: LanguageGlobalVar.SHRINK.tr,
              style: CommonStyle.black14Medium,
              moreStyle: CommonStyle.primary12Bold,
              lessStyle: CommonStyle.primary12Bold,
            ),
          ],
        ),
      ),
    );
  }

  void _handleDeleteComment(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text(
            LanguageGlobalVar.ASK_WANT_TO_DELETE_COMMENT.tr,
            style: CommonStyle.black16Medium,
          ),
          actions: [
            InkWell(
              onTap: () {
                Get.back();
              },
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(LanguageGlobalVar.CANCEL.tr),
                ),
              ),
            ),
            Obx(
              () {
                if (isDeleteLoading.value) {
                  return loadingButtonWidget();
                }
                return InkWell(
                  onTap: () {
                    final controller = Get.find<ProductController>();
                    isDeleteLoading.value = true;
                    controller.deleteComment(detail.value!.id!).then((_) {
                      showToast(LanguageGlobalVar.DELETE_SUCCESSFULLY.tr);
                      Get.back();
                      return onDelete(detail.value!);
                    }).whenComplete(() {
                      isDeleteLoading.value = false;
                    });
                  },
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        LanguageGlobalVar.DELETE.tr,
                      ),
                    ),
                  ),
                );
              },
            )
          ],
        );
      },
    );
  }
}
