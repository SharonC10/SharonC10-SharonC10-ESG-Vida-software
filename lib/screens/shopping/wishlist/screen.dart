import 'package:ESGVida/pkg/language.dart';
import 'package:ESGVida/screens/shopping/product/id/screen.dart';

import 'package:ESGVida/widgets/common_appbar.dart';
import 'package:ESGVida/widgets/loadings.dart';
import 'package:ESGVida/widgets/no_data_found.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller.dart';
import 'widgets/wishitem_preview.dart';

class WishListScreen extends StatelessWidget {
  const WishListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final controller = Get.put(WishListController());
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: CommonAppbarInside(
        bgColor: Colors.blue,
        context,
        title: LanguageGlobalVar.WISHLIST.tr,
      ),
      body: Obx(
        () => controller.isPageDataFirstLoading.value
            ? Center(
                child: loadingWidget(),
              )
            : controller.pageData.isEmpty
                ? Center(
                    child: NoDataFound(
                        height: size.height * 0.5, width: size.width * 0.5),
                  )
                : NotificationListener<ScrollNotification>(
                    onNotification: (ScrollNotification notification) {
                      _onScrollEnd(notification, controller); // 监听滚动事件
                      return true;
                    },
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 10,
                      ),
                      itemCount: controller.pageData.length,
                      itemBuilder: (context, index) {
                        final data = controller.pageData[index];
                        return InkWell(
                          onTap: () {
                            Get.to(ProductScreen(id: data.productId!));
                          },
                          child: WishlistItemPreview(data: data),
                        );
                      },
                    ),
                  ),
      ),
    );
  }

  void _onScrollEnd(
      ScrollNotification notification, WishListController controller) {
    if (notification.metrics.pixels == notification.metrics.maxScrollExtent &&
        controller.hasNext &&
        controller.isMorePageDataLoading.isFalse) {
      controller.fetchMorePageData();
    }
  }
}
