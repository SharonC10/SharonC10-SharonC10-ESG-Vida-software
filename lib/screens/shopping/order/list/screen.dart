import 'package:ESGVida/model/shopping.dart';

import 'package:ESGVida/screens/shopping/order/list/controller.dart';
import 'package:ESGVida/screens/shopping/order/list/widgets/order_preview.dart';
import 'package:ESGVida/widgets/common_appbar.dart';
import 'package:ESGVida/widgets/loadings.dart';
import 'package:ESGVida/widgets/no_data_found.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductOrderScreen extends StatelessWidget {
  final ProductOrderStatus status;
  const ProductOrderScreen({
    super.key,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return GetX<ProductOrderController>(
      init: ProductOrderController(status: status),
      initState: (state) {
        state.controller!.search();
      },
      builder: (controller) {
        return Scaffold(
          backgroundColor: const Color(0xFFF5F7FA),
          appBar: CommonAppbarInside(
            bgColor: const Color(0xFFCF1333),
            context,
            title:
                "${ProductOrderStatus.stringOf(status.name)}(${controller.pageData.length})",
          ),
          body: controller.isPageDataFirstLoading.isTrue
              ? Center(
                  child: loadingWidget(),
                )
              : controller.pageData.isEmpty
                  ? Center(
                      child: NoDataFound(
                        height: size.height * 0.5,
                        width: size.width * 0.5,
                      ),
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
                          if (data.product!.imageUrls == null ||
                              data.product!.imageUrls!.isEmpty) {
                            throw Exception("productId=${data.product!.id}");
                          }
                          return ProductOrderPreview(data: data);
                        },
                      ),
                    ),
        );
      },
    );
  }

  void _onScrollEnd(
      ScrollNotification notification, ProductOrderController controller) {
    if (notification.metrics.pixels == notification.metrics.maxScrollExtent &&
        controller.hasNext &&
        controller.isMorePageDataLoading.isFalse) {
      controller.fetchMorePageData();
    }
  }
}
