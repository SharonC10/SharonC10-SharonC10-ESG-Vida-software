import 'package:ESGVida/model/post/feed.dart';
import 'package:ESGVida/provider/post.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PostFeedListController extends GetxController {
  final _postProvider = Get.find<PostProvider>();

  final isPageDataFirstLoading = false.obs;
  final isMorePageDataLoading = false.obs;
  final pageData = <PostFeedModel>[].obs;
  int _page = 1;
  bool hasNext = true;
  bool hasPrevious = false;

  void onScrollEnd(ScrollNotification notification) {
    if (notification.metrics.pixels == notification.metrics.maxScrollExtent &&
        hasNext &&
        isMorePageDataLoading.isFalse) {
      fetchMorePageData();
    }
  }

  Future<void> fetchMorePageData() async {
    if (_page == 1) {
      isPageDataFirstLoading.value = true;
    } else {
      isMorePageDataLoading.value = true;
    }
    return _postProvider
        .feedList(
      page: _page,
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
}
