import 'package:ESGVida/model/wishlist.dart';
import 'package:ESGVida/pkg/ext.dart';
import 'package:ESGVida/screens/shopping/wishlist/controller.dart';

import 'package:ESGVida/pkg/style_color.dart';
import 'package:ESGVida/widgets/cacheable_image.dart';
import 'package:ESGVida/widgets/loadings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WishlistItemPreview extends StatelessWidget {
  final WishListModel data;
  const WishlistItemPreview({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<WishListController>();
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.only(bottom: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: CommonColor.whiteColor,
            boxShadow: [
              BoxShadow(
                color: CommonColor.greyColor.withOpacity(0.5),
                blurRadius: 3,
              )
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: CommonChacheImage(
                  imgHeight: 70,
                  imgWidth: 70,
                  url: data.productCover!,
                  borderRadius: 5,
                ),
              ),
              Flexible(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          child: Text(
                            '${data.productName!.capitalizeFirst}',
                            style: CommonStyle.black14Medium,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                            child: Text(
                          '${data.shopName!.capitalizeFirst}',
                          style: CommonStyle.black14Medium,
                        )),
                        5.width,
                        Container(
                          alignment: Alignment.centerRight,
                          child: Text(
                            '${data.productPrice} ${data.productCurrencyCode}',
                            style: const TextStyle(
                              color: Colors.red,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          '${data.createAt?.toFriendlyDatetimeStr()}',
                          style: CommonStyle.grey12Regular,
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: controller.isDeleting.value
              ? loadingWidget()
              : InkWell(
                  onTap: () {
                    controller.remove(data.id!);
                  },
                  child: const Icon(
                    Icons.remove_circle,
                    color: Colors.red,
                    size: 24,
                  ),
                ),
        ),
      ],
    );
  }
}
