import 'package:ESGVida/pkg/ext.dart';
import 'package:ESGVida/pkg/language.dart';

import 'package:ESGVida/pkg/style_color.dart';
import 'package:ESGVida/screens/shopping/product/add/screen.dart';
import 'package:ESGVida/screens/shopping/product/list/screen.dart';
import 'package:ESGVida/screens/shopping/product/id/screen.dart';
import 'package:ESGVida/screens/shopping/shop/list/screen.dart';
import 'package:ESGVida/screens/shopping/shop/id/screen.dart';
import 'package:ESGVida/widgets/no_data_found.dart';
import 'package:ESGVida/widgets/shimmer/grid_shimmer.dart';
import 'package:ESGVida/widgets/shimmer/list_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import './widgets/product_widget.dart';
import 'controller.dart';
import 'widgets/shop_widget.dart';

class ShoppingScreen extends StatelessWidget {
  const ShoppingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.sizeOf(context).width;
    var height = MediaQuery.sizeOf(context).height;
    return GetX<ShoppingController>(
        init: ShoppingController(),
        initState: (state) {
          state.controller!.fetchHotShop();
          state.controller!.fetchHotProduct();
        },
        builder: (controller) {
          return Scaffold(
            appBar: buildAppBar(),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 15, top: 10),
                      child: Text(
                        LanguageGlobalVar.Merchant.tr,
                        style: CommonStyle.black18Medium,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Get.to(() => const ShopListScreen());
                      },
                      child: Container(
                        margin: const EdgeInsets.only(right: 15),
                        child: Text(
                          LanguageGlobalVar.More.tr,
                          style: CommonStyle.primary15600,
                        ),
                      ),
                    ),
                  ],
                ),
                8.height,
                controller.isHotShopLoading.isTrue
                    ? HomePageHoriShimmer(context)
                    : controller.hotShopList.isEmpty
                        ? const SizedBox()
                        : Padding(
                            padding: const EdgeInsets.only(
                              bottom: 0,
                              left: 10,
                              right: 10,
                            ),
                            child: SingleChildScrollView(
                              physics: const ScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              padding: EdgeInsets.zero,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: controller.hotShopList
                                    .mapIndexed((shop, i) {
                                  return Container(
                                    width: width * 0.36,
                                    height: height * 0.15,
                                    margin: const EdgeInsets.only(
                                        left: 3, right: 8),
                                    padding: const EdgeInsets.all(7),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                            color: Colors.grey.shade400,
                                            width: 0.5)),
                                    child: InkWell(
                                      onTap: () {
                                        Get.to(() => ShopScreen(
                                              id: shop.id!,
                                            ));
                                      },
                                      child: ShopPreviewWidget(data: shop),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 5,
                      ),
                      child: Text(
                        LanguageGlobalVar.ShopProductList.tr,
                        style: CommonStyle.black18Medium,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Get.to(() => const ProductListScreen());
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 10,
                        ),
                        child: Text(
                          LanguageGlobalVar.More.tr,
                          style: CommonStyle.primary15600,
                        ),
                      ),
                    ),
                  ],
                ),
                controller.isHotProductLoading.isTrue
                    ? Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: HomePageGridShimmer(context),
                        ),
                      )
                    : controller.hotProductList.isEmpty
                        ? Center(
                            child: NoDataFound(
                              height: height * 0.2,
                              width: width * 0.5,
                            ),
                          )
                        : Expanded(
                            child: GridView.builder(
                              padding: const EdgeInsets.only(
                                left: 10,
                                right: 10,
                                bottom: 10,
                              ),
                              physics: const ScrollPhysics(),
                              itemCount: controller.hotProductList.length,
                              shrinkWrap: true,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 2 / 2.25,
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 10,
                              ),
                              itemBuilder: (context, index) {
                                final product =
                                    controller.hotProductList[index];
                                return InkWell(
                                  onTap: () {
                                    Get.to(
                                      () => ProductScreen(
                                        id: product.id!,
                                      ),
                                    );
                                  },
                                  child: ProductPreviewWidget(
                                    data: product,
                                  ),
                                );
                              },
                            ),
                          ),
              ],
            ),
          );
        });
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: CommonColor.primaryColor,
      automaticallyImplyLeading: false,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            "assets/images/appbarlogowhite.png",
            height: 60,
          ),
          Text(
            LanguageGlobalVar.Market.tr,
            style: CommonStyle.white22Medium,
          ),
          InkWell(
            onTap: () async {
              Get.to(() => const ProductAddScreen());
            },
            child: Container(
              margin: const EdgeInsets.all(10),
              child: const Icon(
                Icons.add_box_rounded,
                color: Colors.white,
                size: 30,
              ),
            ),
          ),
        ],
      ),
      centerTitle: true,
    );
  }
}
