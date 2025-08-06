import 'package:ESGVida/model/shopping.dart';
import 'package:ESGVida/pkg/utils/common.dart';
import 'package:ESGVida/provider/shopping/address.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddressFormController extends GetxController {
  final _provider = Get.find<AddressProvider>();
  final AddressModel? address;
  AddressFormController(this.address) {
    if (address != null) {
      nameTec.text = address!.name!;
      phoneTec.text = address!.phone!;
      areaTec.text = address!.area!;
      areaDetailTec.text = address!.areaDetail!;
      isDefault.value = address!.isDefault!;
    }
  }

  final formKey = GlobalKey<FormState>();
  final isDefault = true.obs;
  final nameTec = TextEditingController();
  final phoneTec = TextEditingController();
  final areaTec = TextEditingController();
  final areaDetailTec = TextEditingController();

  final isSubmitting = false.obs;

  Future<void> handleSubmit() async {
    if (formKey.currentState!.validate()) {
      try {
        isSubmitting.value = true;
        if (address == null) {
          await _provider.add(
            username: nameTec.text,
            phone: phoneTec.text,
            isDefault: isDefault.value,
            area: areaTec.text,
            areaDetail: areaDetailTec.text,
          );
        } else {
          await _provider.update(
            addressId: address!.id!,
            username: CommonUtils.defaultIfEq(address!.name!, nameTec.text),
            phone: CommonUtils.defaultIfEq(
              address!.phone!,
              phoneTec.text,
            ),
            isDefault: CommonUtils.defaultIfEq(
              address!.isDefault!,
              isDefault.value,
            ),
            area: CommonUtils.defaultIfEq(
              address!.area!,
              areaTec.text,
            ),
            areaDetail: CommonUtils.defaultIfEq(
              address!.areaDetail!,
              areaDetailTec.text,
            ),
          );
        }
        Get.back(result: true);
      } finally {
        isSubmitting.value = false;
      }
    }
  }
}
