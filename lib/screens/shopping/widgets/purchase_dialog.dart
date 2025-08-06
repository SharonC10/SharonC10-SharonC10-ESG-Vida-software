import 'package:ESGVida/pkg/language.dart';
import 'package:ESGVida/pkg/ext.dart';
import 'package:ESGVida/pkg/style_color.dart';
import 'package:ESGVida/pkg/toast.dart';
import 'package:ESGVida/widgets/number_input.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PurchaseDialog extends StatelessWidget {
  final double productPrice;
  final String productCurrencyCode;
  final TextEditingController amountTec = TextEditingController(text: "1");
  PurchaseDialog({
    super.key,
    required this.productPrice,
    required this.productCurrencyCode,
  });
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
              LanguageGlobalVar.TIP_ADD_TO_SHOPPING_CART.tr,
              style: CommonStyle.black14Medium,
              textAlign: TextAlign.center,
            ),
          ),
          ValueListenableBuilder(
            valueListenable: amountTec,
            builder: (ctx, value, child) {
              double actualPayment = productPrice * int.parse(value.text);
              return Column(
                children: [
                  Text(
                    "$productCurrencyCode $productPrice"
                    " X ${value.text}",
                    style: CommonStyle.red22Bold,
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    "$productCurrencyCode ${actualPayment.toPrecision(2)}",
                    style: CommonStyle.red22Bold,
                    textAlign: TextAlign.center,
                  ),
                ],
              );
            },
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
              InkWell(
                onTap: () {
                  showToast("Does support now !!!");
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.redAccent,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Center(
                    child: Text(
                      LanguageGlobalVar.PAY.tr,
                      style: CommonStyle.white16Medium,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
