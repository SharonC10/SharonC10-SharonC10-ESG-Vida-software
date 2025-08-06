import 'package:ESGVida/model/shopping.dart';
import 'package:ESGVida/pkg/language.dart';
import 'package:ESGVida/pkg/toast.dart';
import 'package:ESGVida/provider/shopping/product.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddOrUpdateCommentController extends GetxController {
  final _provider = Get.find<ProductProvider>();

  final int productId;
  final ProductCommentModel? data;
  AddOrUpdateCommentController({
    required this.productId,
    this.data,
  });

  @override
  void onInit() {
    if (data != null) {
      content.text = data!.content!;
      rating.value = double.parse(data!.rating.toString());
    }
    super.onInit();
  }

  final content = TextEditingController();
  final rating = 1.0.obs;

  final isSubmitCommentLoading = false.obs;
  Future<void> submitComment() async {
    if (content.text.isEmpty) {
      showToast(LanguageGlobalVar.REQUIRE_COMMENT_CONTENT.tr);
      return;
    }
    try {
      isSubmitCommentLoading.value = true;
      if (data == null) {
        await _provider.addComment(
          productId: productId,
          rating: rating.value,
          content: content.text,
        );
      } else {
        await _provider.updateComment(
          commentId: data!.id!,
          rating: rating.value,
          content: content.text,
        );
      }
    } finally {
      isSubmitCommentLoading.value = false;
    }
  }
}
