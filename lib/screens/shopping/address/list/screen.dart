import 'package:ESGVida/pkg/language.dart';
import 'package:ESGVida/pkg/style_color.dart';
import 'package:ESGVida/screens/shopping/address/list/controller.dart';
import 'package:ESGVida/widgets/loadings.dart';
import 'package:ESGVida/widgets/no_data_found.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../form/screen.dart';
import 'widgets/address_preview.dart';

class AddressListScreen extends StatelessWidget {
  const AddressListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return GetBuilder<AddressListController>(
        init: AddressListController(),
        builder: (controller) {
          return Obx(() {
            if (controller.isListLoading.value) {
              return loadingWidget();
            }
            if (controller.addressList.isEmpty) {
              return NoDataFound(
                width: size.width,
                height: size.height,
              );
            }
            return Scaffold(
              appBar: AppBar(
                backgroundColor: const Color(0xFFFF0000),
                leading: IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
                title: Text(
                  LanguageGlobalVar.ADDRESS.tr,
                  style: const TextStyle(color: Colors.white),
                ),
                centerTitle: true,
              ),
              body: ListView.builder(
                itemCount: controller.addressList
                    .length, // Replace with actual address list length
                itemBuilder: (context, index) {
                  return AddressPreview(
                    data: controller.addressList[index],
                  );
                },
              ),
              bottomNavigationBar: Padding(
                padding: const EdgeInsets.all(16),
                child: ElevatedButton(
                  onPressed: () {
                    Get.to(const AddressFormScreen())?.then((value) {
                      if (value == true) {
                        controller.fetchAll();
                      }
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF0000),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    LanguageGlobalVar.ADD_ADDRESS.tr,
                    style: CommonStyle.white12Bold,
                  ),
                ),
              ),
            );
          });
        });
  }
}
