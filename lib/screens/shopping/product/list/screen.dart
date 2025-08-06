import 'package:ESGVida/pkg/language.dart';

import 'package:ESGVida/screens/shopping/product/id/screen.dart';
import 'package:ESGVida/screens/shopping/product/list/controller.dart';
import 'package:ESGVida/widgets/common_appbar.dart';
import 'package:ESGVida/widgets/loadings.dart';
import 'package:ESGVida/widgets/no_data_found.dart';
import 'package:ESGVida/widgets/shimmer/grid_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'widgets/product_widget.dart';

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return GetX<ProductListController>(
      init: ProductListController(),
      initState: (stateV) {
        stateV.controller!.search();
      },
      builder: (controller) {
        return Scaffold(
          appBar: CommonAppbarInside(
            context,
            title: LanguageGlobalVar.Products.tr,
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
                Container(
                  margin: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.zero,
                  child: TextField(
                    onChanged: (value) {
                      controller.search(key: value);
                    },
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.zero,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                        ),
                        fillColor: Colors.grey[200],
                        filled: true,
                        prefixIcon: const Icon(
                          Icons.search,
                          size: 30,
                          color: Colors.black,
                        ),
                        hintText: 'Search'),
                  ),
                ),
                controller.isPageDataFirstLoading.isTrue
                    ? Padding(
                        padding: const EdgeInsets.all(2),
                        child: HomePageGridShimmer(context),
                      )
                    : controller.pageData.isEmpty
                        ? Center(
                            child: NoDataFound(
                              height: size.height * 0.5,
                              width: size.width * 0.5,
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
                                  Get.to(() => ProductScreen(id: data.id!));
                                },
                                child: ProductPreviewWidget(
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
            ),
          ),
        );
      },
    );
  }

  void _onScrollEnd(
      ScrollNotification notification, ProductListController controller) {
    if (notification.metrics.pixels == notification.metrics.maxScrollExtent &&
        controller.hasNext &&
        controller.isMorePageDataLoading.isFalse) {
      controller.fetchMorePageData();
    }
  }
}
