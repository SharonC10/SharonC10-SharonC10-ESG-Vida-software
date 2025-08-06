import 'package:ESGVida/pkg/language.dart';
import 'package:ESGVida/pkg/ext.dart';
import 'package:ESGVida/pkg/style_color.dart';
import 'package:ESGVida/screens/shopping/product/id/controller.dart';
import 'package:ESGVida/widgets/loadings.dart';
import 'package:ESGVida/widgets/number_input.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddToCartDialog extends StatelessWidget {
  final TextEditingController amountTec = TextEditingController(text: "1");
  AddToCartDialog({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductController>(
      builder: (controller) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          elevation: 0,
          backgroundColor: Colors.white,
          child: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 10,
            ),
            children: [
              InkWell(
                onTap: () {
                  Get.back();
                },
                child: const Align(
                  alignment: Alignment.topRight,
                  child: Icon(
                    Icons.cancel_outlined,
                    size: 30,
                    color: Colors.red,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: CommonColor.primaryColor,
                    width: 2,
                  ),
                ),
                child: const Icon(
                  Icons.question_mark,
                  size: 30,
                  color: CommonColor.primaryColor,
                ),
              ),
              10.height,
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Text(
                  LanguageGlobalVar.TIP_ADD_TO_SHOPPING_CART.tr,
                  style: CommonStyle.black14Medium,
                  textAlign: TextAlign.center,
                ),
              ),
              Text(
                "${controller.detail.value!.currencyCode} ${controller.detail.value!.price}",
                style: CommonStyle.red22Bold,
                textAlign: TextAlign.center,
              ),
              10.height,
              //const Color.fromARGB(255, 232, 225, 225)
              NumberInputer(
                controller: amountTec,
                color: const Color.fromARGB(255, 232, 225, 225),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Obx(
                    () => controller.isAddToShoppingCartLoading.value
                        ? loadingButtonWidget()
                        : InkWell(
                            onTap: () {
                              controller
                                  .addToShoppingCart(int.parse(amountTec.text))
                                  .then((value) {
                                Get.back();
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: CommonColor.primaryColor,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Center(
                                child: Text(
                                  LanguageGlobalVar.ADD_TO_SHOPPING_CART.tr,
                                  style: CommonStyle.white16Medium,
                                ),
                              ),
                            ),
                          ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
