import 'package:ESGVida/view/Home/widgets/post_feed.dart';
import 'package:ESGVida/pkg/language.dart';

import 'package:ESGVida/screens/post/id/screen.dart';
import 'package:ESGVida/widgets/loadings.dart';
import 'package:ESGVida/widgets/no_data_found.dart';
import 'package:ESGVida/widgets/shimmer/grid_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller.dart';

class PostFeedList extends StatelessWidget {
  const PostFeedList({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX<PostFeedListController>(
      initState: (state) {
        state.controller!.fetchMorePageData();
      },
      builder: (controller) {
        final size = MediaQuery.sizeOf(context);
        return ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          physics: const NeverScrollableScrollPhysics(),
          children: [
            controller.isPageDataFirstLoading.isTrue
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: HomePageGridShimmer(context),
                  )
                : controller.pageData.isEmpty
                    ? Center(
                        child: NoDataFound(
                          height: size.height * 0.3,
                          width: size.width * 0.4,
                        ),
                      )
                    : GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: controller.pageData.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 2 / 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
                        itemBuilder: (context, index) {
                          final data = controller.pageData[index];
                          return InkWell(
                            onTap: () {
                              Get.to(PostScreen(id: data.id!));
                            },
                            child: PostFeedView(
                              data: data,
                            ),
                          );
                        },
                      ),
            if (controller.isMorePageDataLoading.isTrue) loadingWidget(),
            if (!controller.hasNext)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(
                  child: Text(LanguageGlobalVar.NO_MORE.tr),
                ),
              ),
          ],
        );
      },
    );
  }
}
