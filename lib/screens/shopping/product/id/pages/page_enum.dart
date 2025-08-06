import 'package:ESGVida/pkg/language.dart';
import 'package:ESGVida/pkg/style_color.dart';
import 'package:ESGVida/screens/shopping/product/id/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'main/page.dart';
import 'comment_list/page.dart';

class ProductPageEnum {
  final AppBar Function()? appBar;
  final Widget Function() builder;

  const ProductPageEnum._({
    this.appBar,
    required this.builder,
  });

  static final MAIN = ProductPageEnum._(
    builder: () => const MainPage(),
  );
  static final COMMENT = ProductPageEnum._(
    appBar: () {
      final controller = Get.find<ProductController>();
      return AppBar(
        title: Obx(
          () => Text(
            "${LanguageGlobalVar.PRODUCT_COMMENT.tr}(${controller.detail.value!.commentCount})",
            style: CommonStyle.black16Bold,
          ),
        ),
      );
    },
    builder: () => const CommentListPage(),
  );
}
