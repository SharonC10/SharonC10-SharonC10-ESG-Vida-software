import "package:ESGVida/model/news_model.dart";
import "package:ESGVida/pkg/toast.dart";
import "package:ESGVida/provider/news.dart";

import "package:flutter/material.dart";
import "package:get/get.dart";

class NewsDetailsController extends GetxController {
  final newsProvider = Get.find<NewsProvider>();

  late NewsModel news;
  final newsCommentController = TextEditingController();
  final isNewsLoading = true.obs;

  final isLikeLoading = false.obs;
  final uploadCommentLoading = false.obs;

  void handlerLike() {
    final userLikedNewest = !news.userInteraction!.liked!;
    isLikeLoading.value = true;
    newsProvider.doLike(news.id!).then((value) {
      if (value.isFail) {
        return;
      }
      news = news.copyWith(
        userInteraction: news.userInteraction!.copyWith(liked: userLikedNewest),
        likeCount: news.likeCount! + (userLikedNewest ? 1 : -1),
      );
      isLikeLoading.value = false;
      update(["likeCount"]);
    });
  }

  Future<void> newsAddComment(String content) async {
    if (content.isNotEmpty) {
      uploadCommentLoading.value = true;
      newsProvider.addComment(news.id!, content).then((value) {
        if (value.isFail) {
          return;
        }
        news = news.copyWith(commentCount: (news.commentCount ?? 0) + 1);
        uploadCommentLoading.value = false;
        update(["commentCount"]);
      });
    } else {
      showToast("can' t post empty comment");
    }
  }

  Future<void> fetchNews({required int newsId}) {
    isNewsLoading.value = true;
    return newsProvider.getNews(newsId: newsId).then((value) {
      if (value.isFail) {
        return;
      }
      news = value.data!;
      isNewsLoading.value = false;
      update();
    });
  }
}

class NewsCommentController extends GetxController {
  final int newsId;
  NewsCommentController({required this.newsId});
  final newsProvider = Get.find<NewsProvider>();

  int commentListPage = 1;
  final isCommentListLoading = false.obs;
  final isMoreCommentListLoading = false.obs;
  var hasMore = true;
  final newsCommentList = <NewsCommentModel>[].obs;

  final isEditingSelfComment = false.obs;
  var editingSelfCommentIndex = -1;
  String get editingCommentContent =>
      newsCommentList[editingSelfCommentIndex].content!;
  int get editingCommentId => newsCommentList[editingSelfCommentIndex].id!;

  final isDeleteLoading = false.obs;

  void fetchCommentList() async {
    final isFirstPage = commentListPage == 1;
    if (isFirstPage) {
      isCommentListLoading.value = true;
    } else {
      isMoreCommentListLoading.value = true;
    }
    newsProvider
        .listComment(
      newsId,
      page: commentListPage,
    )
        .then((value) {
      if (value.isFail) {
        return;
      }
      // hasMore = value.data!.hasNext;
      if (value.data!.results.isNotEmpty) {
        newsCommentList.addAll(value.data!.results);
        commentListPage++;
      }
      if (isFirstPage) {
        isCommentListLoading.value = false;
      } else {
        isMoreCommentListLoading.value = false;
      }
    });
  }

  void updateComment(String content) {
    newsProvider.updateComment(editingCommentId, content).then((value) async {
      if (value.isFail) {
        return;
      }
      newsCommentList.setRange(
          editingSelfCommentIndex, editingSelfCommentIndex + 1, [value.data!]);
      isEditingSelfComment.value = false;
    });
  }

  void deleteComment(int index) {
    isDeleteLoading.value = true;
    newsProvider.deleteComment(newsCommentList[index].id!).then((value) {
      if (value.isFail) {
        return;
      }
      newsCommentList.removeAt(index);
      isDeleteLoading.value = false;
      update();
      Get.back();
    });
  }

  void handlerEditSelfComment(int i) {
    isEditingSelfComment.value = false;
    editingSelfCommentIndex = i;
    isEditingSelfComment.value = true;
  }
}
