import 'package:ESGVida/model/shopping.dart';
import 'package:ESGVida/pkg/ext.dart';

import 'package:ESGVida/pkg/style_color.dart';
import 'package:ESGVida/widgets/cacheable_image.dart';
import 'package:flutter/material.dart';
import 'package:get/utils.dart';

class ProductPreviewWidget extends StatelessWidget {
  final ProductModel data;
  const ProductPreviewWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 1,
        horizontal: 1,
      ),
      width: size.width * 0.40,
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: CommonColor.secondaryColor.withOpacity(0.2),
            spreadRadius: 0.5,
            blurRadius: 2,
          ),
        ],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: CommonChacheImage(
              imgHeight: size.height,
              imgWidth: size.width,
              url: data.cover!,
            ),
          ),
          3.height,
          Text(
            data.name!.capitalizeFirst!,
            style: CommonStyle.black16Medium,
            overflow: TextOverflow.ellipsis,
          ),
          3.height,
          Text(
            data.description!.capitalizeFirst!,
            style: CommonStyle.grey12Medium,
            overflow: TextOverflow.ellipsis,
          ),
          // 5.height,
          Row(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Icon(
                    Icons.star,
                    size: 15,
                    color: Colors.red,
                  ),
                  Text(
                    "${data.rating}",
                    style: CommonStyle.black14Medium,
                  ),
                ],
              ),
              Flexible(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      data.currencyCode!,
                      style: const TextStyle(color: Colors.red, fontSize: 12),
                    ),
                    Text(
                      data.price!,
                      style: const TextStyle(color: Colors.red, fontSize: 12),
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
