import 'package:ESGVida/model/shopping.dart';
import 'package:ESGVida/pkg/ext.dart';

import 'package:ESGVida/pkg/style_color.dart';
import 'package:ESGVida/widgets/cacheable_image.dart';
import 'package:flutter/material.dart';
import 'package:get/utils.dart';

class ShopPreviewWidget extends StatelessWidget {
  final ShopModel data;
  const ShopPreviewWidget({super.key, required this.data});
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Column(
      children: [
        Expanded(
          child: CommonChacheImage(
            imgHeight: size.height,
            imgWidth: size.width,
            url: data.cover!,
          ),
        ),
        10.height,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: size.width * 0.2,
              child: Text(
                '${data.name!.toString().capitalizeFirst}',
                style: CommonStyle.black14Medium,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "${data.rating}",
                  style: const TextStyle(color: Colors.red, fontSize: 12),
                ),
                const Icon(
                  Icons.star,
                  size: 15,
                  color: Colors.red,
                )
              ],
            )
          ],
        ),
      ],
    );
  }
}
