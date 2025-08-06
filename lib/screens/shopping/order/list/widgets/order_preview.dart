import 'package:ESGVida/model/shopping.dart';
import 'package:ESGVida/pkg/ext.dart';
import 'package:ESGVida/pkg/language.dart';

import 'package:ESGVida/pkg/style_color.dart';
import 'package:ESGVida/screens/shopping/shop/id/screen.dart';
import 'package:ESGVida/widgets/cacheable_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductOrderPreview extends StatelessWidget {
  final ProductOrderModel data;

  const ProductOrderPreview({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(
        bottom: 5,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: CommonColor.whiteColor,
        boxShadow: [
          BoxShadow(
            color: CommonColor.greyColor.withOpacity(0.5),
            blurRadius: 3,
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  Get.to(ShopScreen(id: data.shop!.id!));
                },
                child: Row(
                  children: [
                    Text(
                      '${data.shop!.name.toString().capitalizeFirst}',
                      style: CommonStyle.black14Bold,
                    ),
                    const Icon(
                      Icons.keyboard_arrow_right_outlined,
                      color: Colors.grey,
                    ),
                  ],
                ),
              ),
              _buildStatus(data.status!),
            ],
          ),
          5.height,
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: CommonChacheImage(
                  imgHeight: 70,
                  imgWidth: 70,
                  url: data.product!.imageUrls!.first.toString(),
                  borderRadius: 5,
                ),
              ),
              Flexible(
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              data.product!.name!.capitalizeFirst!,
                              style: CommonStyle.black14Bold,
                              overflow: TextOverflow.clip,
                              maxLines: 2,
                            ),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${data.price} ${data.currencyCode}',
                              style: const TextStyle(
                                  color: Colors.red, fontSize: 16),
                            ),
                            Text(
                              'x${data.amount}',
                              style: const TextStyle(
                                  color: Colors.red, fontSize: 16),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            alignment: Alignment.bottomRight,
            child: Text(
              '${LanguageGlobalVar.ACTUAL_PAID.tr} ${data.actualPayment} ${data.currencyCode}',
              style: const TextStyle(color: Colors.red, fontSize: 16),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 5, top: 5),
            alignment: Alignment.bottomLeft,
            child: Text(
              '${data.createAt?.toFriendlyDatetimeStr()}',
              style: CommonStyle.grey12Regular,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildStatus(String status) {
    return Text(
      ProductOrderStatus.stringOf(status),
      style: const TextStyle(
        color: Colors.red,
        fontSize: 16,
      ),
    );
  }
}
