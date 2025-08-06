import 'package:ESGVida/model/post/comment/feed.dart';
import 'package:ESGVida/pkg/toast.dart';
import 'package:ESGVida/provider/post.dart';
import 'package:ESGVida/pkg/language.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PostCommentController extends GetxController {
  final int postId;

  PostCommentController({required this.postId});
  final _provider = Get.find<PostProvider>();

  @override
  void onInit() {
    fetchMorePageData();
    super.onInit();
  }

  final isPageDataFirstLoading = true.obs;
  final isMorePageDataLoading = false.obs;
  final pageData = <PostCommentFeedModel>[].obs;
  int _page = 1;
  bool hasNext = true;
  bool hasPrevious = false;

  Future<void> fetchMorePageData() async {
    if (_page == 1) {
      isPageDataFirstLoading.value = true;
    } else {
      isMorePageDataLoading.value = true;
    }
    return _provider
        .listCommentFeed(
      postId: postId,
    )
        .then((value) {
      if (value.isFail) {
        return;
      }
      hasPrevious = value.data!.hasPrevious;
      hasNext = value.data!.hasNext;
      if (hasNext) {
        _page++;
      }
      if (value.data!.results.isNotEmpty) {
        pageData.addAll(value.data!.results);
      }
    }).whenComplete(() {
      if (isPageDataFirstLoading.value) {
        isPageDataFirstLoading.value = false;
      } else {
        isMorePageDataLoading.value = false;
      }
    });
  }

  final commentContentController = TextEditingController();
  final isAddCommentLoading = false.obs;
  addCommentOnUserPost(int postId) {
    final commentText = commentContentController.value.text;
    if (commentText.isEmpty) {
      showToast("comment content is empty");
      return;
    }

    isAddCommentLoading.value = true;
    _provider.addComment(postId: postId, commentText: commentText).then((_) {
      commentContentController.clear();
    }).whenComplete(() {
      isAddCommentLoading.value = false;
    });
  }

  final editCommentOnUserPostIsLoading = false.obs;
  final isViewEditComment = false.obs;
  int editingCommentIndex = -1;

  Future<void> editCommentOnUserPost() async {
    final content = commentContentController.value.text;
    if (content.isEmpty) {
      showToast(LanguageGlobalVar.EMPTY_CONTENT.tr);
      return;
    }
    final commentId = pageData[editingCommentIndex].id!;
    editCommentOnUserPostIsLoading.value = true;
    _provider
        .updateComment(commentId: commentId, content: content)
        .then((value) {
      if (value.isFail) {
        return;
      }
      pageData[editingCommentIndex] =
          pageData[editingCommentIndex].copyWith(text: content);

      commentContentController.clear();
      isViewEditComment.value = false;
    }).whenComplete(() => editCommentOnUserPostIsLoading.value = false);
  }

  Future<void> deletePostComment({required int commentId}) async {
    _provider.deleteComment(commentId: commentId).then((value) {
      pageData.removeWhere((e) => e.id == commentId);
      Get.back();
    });
  }
}
