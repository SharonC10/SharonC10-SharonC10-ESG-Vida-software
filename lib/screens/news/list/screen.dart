import 'package:ESGVida/screens/news/list/controller.dart';
import 'package:ESGVida/pkg/language.dart';

import 'package:ESGVida/widgets/common_appbar.dart';
import 'package:ESGVida/widgets/loadings.dart';
import 'package:ESGVida/widgets/no_data_found.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../id/screen.dart';
import '../widgets/news_feed_preview.dart';

class NewsListScreen extends StatelessWidget {
  const NewsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return GetX<NewsListController>(
      init: NewsListController(),
      initState: (stateV) {
        stateV.controller!.fetchMorePageData();
      },
      builder: (controller) {
        return Scaffold(
          appBar: CommonAppbarInside(
            context,
            title: LanguageGlobalVar.News.tr,
          ),
          body: NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification notification) {
              _onScrollEnd(notification, controller); // 监听滚动事件
              return true;
            },
            child: ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              physics: const ScrollPhysics(),
              children: [
                if (controller.isPageDataFirstLoading.isTrue)
                  loadingWidget()
                else if (controller.pageData.isEmpty)
                  Center(
                    child: NoDataFound(
                      height: size.height * 0.5,
                      width: size.width * 0.5,
                    ),
                  )
                else
                  ...controller.pageData
                      .map((data) => InkWell(
                            onTap: () {
                              Get.to(() => NewsScreen(id: data.id!));
                            },
                            child: NewsFeedPreview(
                              data: data,
                            ),
                          ))
                      .toList(),
                if (controller.isMorePageDataLoading.isTrue) loadingWidget(),
                if (!controller.hasNext)
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Center(
                      child: Text(LanguageGlobalVar.NO_MORE.tr),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _onScrollEnd(
      ScrollNotification notification, NewsListController controller) {
    if (notification.metrics.pixels == notification.metrics.maxScrollExtent &&
        controller.hasNext &&
        controller.isMorePageDataLoading.isFalse) {
      controller.fetchMorePageData();
    }
  }
}
