import 'package:ESGVida/model/shopping.dart';
import 'package:ESGVida/pkg/ext.dart';
import 'package:ESGVida/pkg/language.dart';
import 'package:ESGVida/pkg/style_color.dart';
import 'package:ESGVida/screens/shopping/order/list/screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller.dart';

class OrderNavBar extends StatelessWidget {
  const OrderNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX<ProfileController>(
      initState: (state) {
        state.controller!.fetchOrderStatus();
      },
      builder: (controller) {
        return Column(
          children: [
            InkWell(
              onTap: () {
                Get.to(() =>
                    const ProductOrderScreen(status: ProductOrderStatus.ALL));
              },
              child: Container(
                padding: const EdgeInsets.all(15),
                alignment: Alignment.centerLeft,
                height: 60,
                width: MediaQuery.of(context).size.width,
                // color: const Color.fromRGBO(207, 19, 51, 1),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      LanguageGlobalVar.OrderList.tr,
                      style: CommonStyle.black18Bold,
                    ),
                    Row(
                      children: [
                        Text(
                          LanguageGlobalVar.ALL.tr,
                          style: CommonStyle.black18Bold,
                        ),
                        const Icon(
                          Icons.navigate_next,
                          color: Colors.black,
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: ProductOrderNavItem.getItems().mapIndexed((item, i) {
                  final icon = ImageIcon(
                    Image.asset(item.icon).image,
                    color: Colors.black,
                  );
                  Widget navIcon;
                  if (controller.isOrderStatusLoading.value) {
                    navIcon = Badge(
                      label: const SizedBox(
                        width: 5,
                        height: 5,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      ),
                      offset: const Offset(8, -5),
                      backgroundColor: Colors.red,
                      child: icon,
                    );
                  } else if (controller.orderStatus.isEmpty ||
                      controller.orderStatus[item.key] == null ||
                      controller.orderStatus[item.key] == 0) {
                    navIcon = icon;
                  } else {
                    navIcon = Badge(
                      label: Text("${controller.orderStatus[item.key]}"),
                      offset: const Offset(8, -5),
                      backgroundColor: Colors.red,
                      child: icon,
                    );
                  }
                  final itemWidget = InkWell(
                    onTap: () {
                      Get.to(() => ProductOrderScreen(status: item.key));
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        navIcon,
                        Text(
                          item.title,
                          style: CommonStyle.blackBold.copyWith(fontSize: 10),
                        ),
                      ],
                    ),
                  );
                  // return itemWidget;
                  return Flexible(
                    flex: i == 3 ? 3 : 2,
                    child: itemWidget,
                  );
                }).toList(),
              ),
            ),
          ],
        );
      },
    );
  }
}

class ProductOrderNavItem {
  final String title;
  final ProductOrderStatus key;
  final String icon;

  ProductOrderNavItem({
    required this.title,
    required this.key,
    required this.icon,
  });

  static List<ProductOrderNavItem> getItems() {
    const root = "assets/images/shopping/";
    return [
      ProductOrderNavItem(
        title: ProductOrderStatus.TO_PAY.string(),
        key: ProductOrderStatus.TO_PAY,
        icon: "${root}to_pay.png",
      ),
      ProductOrderNavItem(
        title: ProductOrderStatus.TO_SHIP.string(),
        key: ProductOrderStatus.TO_SHIP,
        icon: "${root}to_ship.png",
      ),
      ProductOrderNavItem(
        title: ProductOrderStatus.TO_RECEIVE.string(),
        key: ProductOrderStatus.TO_RECEIVE,
        icon: "${root}to_receive.png",
      ),
      ProductOrderNavItem(
        title: ProductOrderStatus.TO_COMMENT.string(),
        key: ProductOrderStatus.TO_COMMENT,
        icon: "${root}to_comment.png",
      ),
      ProductOrderNavItem(
        title: ProductOrderStatus.REFUNDS_SALES.string(),
        key: ProductOrderStatus.REFUNDS_SALES,
        icon: "${root}refunds.png",
      ),
    ];
  }
}
