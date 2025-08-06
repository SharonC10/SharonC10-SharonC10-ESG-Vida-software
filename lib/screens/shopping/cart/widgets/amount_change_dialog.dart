import 'package:ESGVida/pkg/language.dart';
import 'package:ESGVida/pkg/ext.dart';
import 'package:ESGVida/pkg/style_color.dart';
import 'package:ESGVida/screens/shopping/cart/controller.dart';
import 'package:ESGVida/widgets/loadings.dart';
import 'package:ESGVida/widgets/number_input.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AmountChangeDialog extends StatelessWidget {
  final TextEditingController amountTec = TextEditingController();
  final int cartItemId;
  AmountChangeDialog({
    super.key,
    int amount = 0,
    required this.cartItemId,
  }) {
    amountTec.text = "$amount";
  }
  @override
  Widget build(BuildContext context) {
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
              LanguageGlobalVar.MODIFY_PURCHASE_AMOUNT.tr,
              style: CommonStyle.black14Medium,
              textAlign: TextAlign.center,
            ),
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
              Flexible(
                flex: 1,
                child: InkWell(
                  onTap: () {
                    if (isChangeAmounting.value) {
                      return;
                    }
                    Get.back();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color: Colors.black,
                        width: 1,
                      ),
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 5,
                        ),
                        child: Text(
                          LanguageGlobalVar.CANCEL.tr,
                          style: CommonStyle.black16Medium,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              10.width,
              Flexible(
                flex: 1,
                child: Obx(
                  () {
                    if (isChangeAmounting.value) {
                      return loadingButtonWidget(
                        bgColor: Colors.redAccent,
                      );
                    }
                    return InkWell(
                      onTap: () {
                        _handleChangeAmount(int.parse(amountTec.text));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.redAccent,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 5,
                            ),
                            child: Text(
                              LanguageGlobalVar.CONFIRM.tr,
                              style: CommonStyle.white16Medium,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  final isChangeAmounting = false.obs;

  void _handleChangeAmount(int value) async {
    final controller = Get.find<ShoppingCartController>();
    isChangeAmounting.value = true;
    await controller
        .changeAmount(
      cartItemId,
      value,
    )
        .whenComplete(() {
      isChangeAmounting.value = true;
    });
    Get.back();
  }
}
