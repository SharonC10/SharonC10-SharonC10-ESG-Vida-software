import 'package:ESGVida/pkg/ext.dart';
import 'package:ESGVida/pkg/language.dart';

import 'package:ESGVida/pkg/style_color.dart';
import 'package:ESGVida/screens/shopping/product/id/screen.dart';
import 'package:ESGVida/screens/shopping/shop/id/controller.dart';
import 'package:ESGVida/widgets/cacheable_image.dart';
import 'package:ESGVida/widgets/loadings.dart';
import 'package:ESGVida/widgets/no_data_found.dart';
import 'package:ESGVida/widgets/shimmer/grid_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

import 'widgets/product_widget.dart';

class ShopScreen extends StatelessWidget {
  final int id;
  const ShopScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.sizeOf(context).width;
    var height = MediaQuery.sizeOf(context).height;
    return GetX<ShopController>(
      init: ShopController(detailId: id),
      initState: (stateV) {
        stateV.controller!.fetchDetail();
        stateV.controller!.fetchMorePageData();
      },
      builder: (controller) {
        return Scaffold(
          backgroundColor: CommonColor.bgColor,
          appBar: AppBar(
            backgroundColor: CommonColor.primaryColor,
            centerTitle: true,
            automaticallyImplyLeading: true,
            iconTheme: const IconThemeData(color: Colors.white, size: 28),
            title: Text(
              "${LanguageGlobalVar.shop.tr} ${LanguageGlobalVar.Details.tr}",
              style: CommonStyle.white22Medium,
            ),
            actions: [
              10.width,
            ],
            scrolledUnderElevation: 0,
            elevation: 0,
          ),
          // body: controller.isShopLoading.value ? loadingWidget() : ShopPage()
          body: controller.isDetailLoading.value
              ? loadingWidget()
              : NotificationListener<ScrollNotification>(
                  onNotification: (ScrollNotification notification) {
                    _onScrollEnd(notification, controller); // 监听滚动事件
                    return true;
                  },
                  child: ListView(
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    physics: const ScrollPhysics(),
                    children: [
                      10.height,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: width * 0.69,
                            child: Text(
                              controller.detail!.name!.capitalizeFirst!,
                              style: CommonStyle.black22Medium,
                            ),
                          ),
                          10.width,
                          Text(
                            "${controller.detail!.rating}",
                            style: CommonStyle.black14Medium,
                          ),
                          Expanded(
                            child: RatingBarIndicator(
                              rating: double.parse(controller.detail!.rating!),
                              itemBuilder: (context, index) => const Icon(
                                Icons.star,
                                color: Colors.orange,
                              ),
                              itemCount: 5,
                              itemSize: 12.0,
                              direction: Axis.horizontal,
                            ),
                          ),
                        ],
                      ),
                      10.height,
                      Row(
                        children: [
                          Icon(
                            Icons.location_on_sharp,
                            color: Colors.grey.shade600,
                            size: 22,
                          ),
                          3.width,
                          Flexible(
                            child: Text(
                              "${controller.detail!.location}",
                              style: CommonStyle.black12Medium,
                            ),
                          ),
                          20.width,
                          Icon(
                            Icons.store,
                            color: Colors.grey.shade600,
                            size: 22,
                          ),
                          3.width,
                          Text(
                            "${controller.detail!.yearsOfExperience} ${LanguageGlobalVar.years.tr}",
                            style: CommonStyle.black12Medium,
                          ),
                        ],
                      ),
                      10.height,
                      Text(
                        LanguageGlobalVar.Introduction.tr,
                        style: CommonStyle.black18Medium,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                            child: Text('${controller.detail!.description}',
                                style: CommonStyle.grey12Medium),
                          ),
                          5.width,
                          CommonChacheImage(
                            imgHeight: 90,
                            imgWidth: width * 0.3,
                            url: controller.detail!.cover ?? "",
                          )
                        ],
                      ),
                      15.height,
                      const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 50, vertical: 5),
                        child: Divider(
                          height: 3,
                          thickness: 3,
                          color: CommonColor.secondaryColor,
                        ),
                      ),
                      15.height,
                      Text(
                        LanguageGlobalVar.Products.tr,
                        style: CommonStyle.black18Medium,
                      ),
                      5.height,
                      controller.pageData.isEmpty ? 50.height : 0.height,
                      controller.isPageDataFirstLoading.value
                          ? Padding(
                              padding: const EdgeInsets.all(2),
                              child: HomePageGridShimmer(context),
                            )
                          : controller.pageData.isEmpty
                              ? Center(
                                  child: NoDataFound(
                                    height: height * 0.2,
                                    width: width * 0.5,
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
                                        Get.to(
                                            () => ProductScreen(id: data.id!));
                                      },
                                      child: ProductPreviewWidget(
                                        data: data,
                                      ),
                                    );
                                  },
                                ),
                      if (controller.isMorePageDataLoading.isTrue)
                        loadingWidget(),
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
      ScrollNotification notification, ShopController controller) {
    if (notification.metrics.pixels == notification.metrics.maxScrollExtent &&
        controller.hasNext &&
        controller.isMorePageDataLoading.isFalse) {
      controller.fetchMorePageData();
    }
  }
}
