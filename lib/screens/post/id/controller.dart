import 'package:ESGVida/model/post/detail.dart';
import 'package:ESGVida/pkg/toast.dart';
import 'package:ESGVida/provider/post.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PostController extends GetxController {
  final int detailId;
  PostController({required this.detailId});
  final _provider = Get.find<PostProvider>();

  final currentMediaIndex = 0.obs;

  final isDetailLoading = false.obs;
  late PostDetailModel detail;
  Future<void> fetchDetail() async {
    isDetailLoading.value = true;
    return _provider.getById(detailId).then((value) {
      if (value.isFail) {
        return;
      }
      detail = value.data!;
    }).whenComplete(() {
      isDetailLoading.value = false;
    });
  }

  Future<void> updateAfterCommentModal() async {
    return _provider.getById(detailId).then((value) {
      if (value.isFail) {
        return;
      }
      detail = value.data!;
    }).whenComplete(() {
      update(["commentCount"]);
    });
  }

  final isLikingLoading = false.obs;
  Future<bool?> likePost() {
    isLikingLoading.value = true;
    return _provider.like2(postId: detailId).then((value) {
      if (value.isFail) {
        return null;
      }
      final isLiked = value.data!;
      detail = detail.copyWith(
          isLiked: isLiked,
          likeCount: (isLiked ? 1 : -1) + detail.likeCount!.toInt());
      update(["LIKE"]);
    }).whenComplete(() {
      isLikingLoading.value = false;
    });
  }

  final commentContentController = TextEditingController().obs;
  final isAddCommentLoading = false.obs;
  Future<void> addCommentOnUserPost(int postId) async {
    final commentText = commentContentController.value.text;
    if (commentText.isEmpty) {
      showToast("comment content is empty");
      return;
    }

    isAddCommentLoading.value = true;
    await _provider
        .addComment(postId: postId, commentText: commentText)
        .then((_) {
      commentContentController.value.clear();
      detail = detail.copyWith(commentCount: detail.commentCount! + 1);
    }).whenComplete(() {
      isAddCommentLoading.value = false;
    });
  }
}
