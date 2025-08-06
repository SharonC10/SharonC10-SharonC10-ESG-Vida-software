import 'dart:io';

import 'package:ESGVida/pkg/inmemory_data.dart';
import 'package:ESGVida/pkg/toast.dart';
import 'package:ESGVida/pkg/utils/file.dart';
import 'package:ESGVida/provider/shopping/product.dart';
import 'package:ESGVida/pkg/language.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProductAddController extends GetxController {
  final _provider = Get.find<ProductProvider>();

  final picker = ImagePicker();
  final RxList<File> selectedImages = <File>[].obs;
  final selectedCoverPath = "".obs;
  final scrollbarController = ScrollController().obs;

  final isAddProductLoading = false.obs;
  final selectedPrice = "".obs;
  final productNameController = TextEditingController();
  final productDescriptionController = TextEditingController();
  final productPriceController = TextEditingController();
  final productListingFormKey = GlobalKey<FormState>();
  final priceList = [
    "CNY",
    "EUR",
    "GBP",
    "HKD",
    "IDR",
    "INR",
    "JPY",
    "KFW",
    "MYR",
    "THB",
    "USD"
  ];

  Future<void> addProduct() async {
    if (selectedImages.isEmpty) {
      showToast(LanguageGlobalVar.NEED_SELECT_MEDIA.tr);
      return;
    }
    if (selectedCoverPath.value.isEmpty) {
      showToast(LanguageGlobalVar.NEED_SELECT_COVER_BY_ADD_MEDIA.tr);
      return;
    }
    if (!productListingFormKey.currentState!.validate()) {
      return;
    }

    try {
      final (longitude, latitude, address) =
          await GlobalInMemoryData.I.getGEO();
      isAddProductLoading.value = true;
      final Map<String, dynamic> data = {};
      data['cover'] = MultipartFile(
        selectedCoverPath.value,
        filename: FileUtils.basename(selectedCoverPath.value),
      );
      data['name'] = productNameController.text;
      data['description'] = productDescriptionController.text;
      data['currency_code'] = selectedPrice.value;
      data['price'] = productPriceController.text;
      data['lat'] = latitude;
      data['lng'] = longitude;
      data['address'] = address;
      data["medias"] = selectedImages
          .map((file) => MultipartFile(
                file.path,
                filename: FileUtils.basename(file.path),
              ))
          .toList();
      await _provider.add(formData: FormData(data)).then((value) {
        if (value.isFail) {
          return;
        }
        Get.back();
      });
    } finally {
      isAddProductLoading.value = false;
    }
  }
}
