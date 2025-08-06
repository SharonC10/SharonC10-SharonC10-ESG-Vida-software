import "package:ESGVida/model/shopping.dart";
import "package:ESGVida/pkg/ext.dart";
import "package:ESGVida/pkg/language.dart";
import "package:ESGVida/pkg/style_color.dart";
import "package:ESGVida/screens/shopping/address/form/controller.dart";
import "package:ESGVida/widgets/loadings.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";

class AddressFormScreen extends StatelessWidget {
  final AddressModel? address;
  const AddressFormScreen({
    super.key,
    this.address,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return GetBuilder<AddressFormController>(
        init: AddressFormController(address),
        builder: (controller) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: const Color(0xFFFF0000),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
              title: Text(
                "${address == null ? LanguageGlobalVar.ADD.tr : LanguageGlobalVar.EDIT.tr} ${LanguageGlobalVar.ADDRESS.tr}",
                style: CommonStyle.white16Bold,
              ),
              centerTitle: true,
            ),
            body: Form(
              key: controller.formKey,
              child: SingleChildScrollView(
                child: Card(
                  elevation: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Column(
                      children: [
                        // Recipient Name Field
                        TextFormField(
                          controller: controller.nameTec,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.contacts),
                            label: Text(LanguageGlobalVar.CONSIGNEE.tr),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return LanguageGlobalVar.ENTER_CONSIGNEE_NAME.tr;
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: controller.phoneTec,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.phone_outlined),
                            label: Text(LanguageGlobalVar.PHONE_NUMBER.tr),
                            // hintText: "可以输入区号，如+86",
                            hintText: LanguageGlobalVar.TIP_PHONE_NUMBER.tr,
                          ),
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return LanguageGlobalVar.ENTER_PHONE_NUMBER.tr;
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: controller.areaTec,
                          maxLines: 2,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.location_city),
                            label: Text(LanguageGlobalVar.COUNTER_OR_AREA.tr),
                            border: InputBorder.none,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return LanguageGlobalVar.ENTER_COUNTER_OR_AREA.tr;
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: controller.areaDetailTec,
                          minLines: 1,
                          maxLines: 3,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.location_on),
                            label: Text(LanguageGlobalVar.ADDRESS.tr),
                            border: InputBorder.none,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return LanguageGlobalVar.ENTER_ADDRESS.tr;
                            }
                            return null;
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(LanguageGlobalVar.SET_TO_DEFAULT_ADDRESS.tr),
                              Obx(
                                () => Switch(
                                  value: controller.isDefault.value,
                                  onChanged: (value) {
                                    controller.isDefault.value = value;
                                  },
                                  activeColor: const Color(0xFFFF0000),
                                ),
                              )
                            ],
                          ),
                        ),
                        30.height,
                        SizedBox(
                          width: size.width * 0.7,
                          child: Obx(
                            () {
                              if (controller.isSubmitting.value) {
                                return loadingButtonWidget(
                                  bgColor: Colors.redAccent,
                                );
                              }
                              return ElevatedButton(
                                onPressed: () {
                                  controller.handleSubmit();
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFFFF0000),
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 16),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: Text(
                                  address == null
                                      ? LanguageGlobalVar.ADD.tr
                                      : LanguageGlobalVar.EDIT.tr,
                                  style: CommonStyle.white16Bold,
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}
