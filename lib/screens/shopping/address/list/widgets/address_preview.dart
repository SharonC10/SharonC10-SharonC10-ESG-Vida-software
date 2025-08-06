import 'package:ESGVida/model/shopping.dart';
import 'package:ESGVida/pkg/ext.dart';
import 'package:ESGVida/pkg/language.dart';
import 'package:ESGVida/pkg/style_color.dart';
import 'package:ESGVida/screens/shopping/address/list/controller.dart';
import 'package:ESGVida/widgets/loadings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../form/screen.dart';

class AddressPreview extends StatelessWidget {
  final AddressModel data;
  final isRemoving = false.obs;
  final isUpdatingDefault = false.obs;
  AddressPreview({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AddressListController>();
    return Card(
      elevation: 0,
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  data.name!,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 16),
                Text(data.phone!),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              "${data.area!} ${data.areaDetail!}",
              maxLines: 3,
              style: CommonStyle.black12Bold,
            ),
            8.height,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Obx(
                  () => isUpdatingDefault.value
                      ? loadingButtonWidget(bgColor: Colors.black)
                      : Row(
                          children: [
                            Checkbox(
                              value:
                                  controller.defaultAddressId.value == data.id,
                              onChanged: (value) {
                                if (value != null) {
                                  isUpdatingDefault.value = true;
                                  controller
                                      .updateDefault(data.id!, value)
                                      .whenComplete(() {
                                    isUpdatingDefault.value = false;
                                  });
                                }
                              },
                              activeColor: const Color(0xFFFF0000),
                            ),
                            if (controller.defaultAddressId.value == data.id)
                              Text(
                                LanguageGlobalVar.DEFAULT.tr,
                                style: CommonStyle.grey10Medium,
                              ),
                          ],
                        ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Obx(() {
                      if (isRemoving.value) {
                        return loadingButtonWidget(bgColor: Colors.black);
                      }
                      return TextButton(
                        onPressed: () {
                          controller.remove(data.id!).whenComplete(() {
                            isRemoving.value = false;
                          });
                        },
                        child: Text(
                          LanguageGlobalVar.DELETE.tr,
                          style: CommonStyle.grey14Bold,
                        ),
                      );
                    }),
                    TextButton(
                      onPressed: () {
                        if (isRemoving.value) {
                          return;
                        }
                        Get.to(AddressFormScreen(
                          address: data,
                        ))?.then((value) {
                          if (value == true) {
                            controller.fetchAll();
                          }
                        });
                      },
                      child: Text(
                        LanguageGlobalVar.EDIT.tr,
                        style: CommonStyle.redBold.copyWith(fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
