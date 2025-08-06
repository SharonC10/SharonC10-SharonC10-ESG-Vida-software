import 'package:ESGVida/model/shopping.dart';
import 'package:ESGVida/pkg/ext.dart';
import 'package:ESGVida/screens/shopping/cart/controller.dart';
import 'package:ESGVida/pkg/language.dart';
import "package:ESGVida/pkg/toast.dart";
import 'package:ESGVida/pkg/style_color.dart';
import 'package:ESGVida/widgets/cacheable_image.dart';
import 'package:ESGVida/widgets/loadings.dart';
import 'package:ESGVida/widgets/number_input.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'amount_change_dialog.dart';

class CartItemPreview extends StatelessWidget {
  final ShoppingCartItemModel data;
  final TextEditingController amountTec;
  final void Function(int cartItemId, bool isSelected) onSelect;
  CartItemPreview({
    super.key,
    required this.data,
    required this.onSelect,
  }) : amountTec = TextEditingController(text: data.amount?.toString() ?? "0");

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.only(
            left: 10,
            right: 10,
            bottom: 10,
            top: 25,
          ),
          margin: const EdgeInsets.only(bottom: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: CommonColor.whiteColor,
            boxShadow: [
              BoxShadow(
                color: CommonColor.greyColor.withOpacity(0.5),
                blurRadius: 3,
              )
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: CommonChacheImage(
                  imgHeight: 70,
                  imgWidth: 70,
                  url: data.product!.cover!,
                  borderRadius: 5,
                ),
              ),
              Flexible(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          child: Text(
                            '${data.product!.name.toString().capitalizeFirst}',
                            style: CommonStyle.black14Medium,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                            child: Text(
                          '${data.shop!.name?.capitalizeFirst}',
                          style: CommonStyle.black14Medium,
                        )),
                        5.width,
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'x${data.amount}',
                              style: const TextStyle(
                                color: Colors.red,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              '${data.amount! * double.parse(data.product!.price ?? "0")} ${data.product!.currencyCode}',
                              style: const TextStyle(
                                color: Colors.red,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    Text(
                      '${data.createAt?.toFriendlyDatetimeStr()}',
                      style: CommonStyle.grey12Regular,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Obx(
                          () => isChangeAmounting.value
                              ? loadingWidget()
                              : NumberInputer(
                                  controller: amountTec,
                                  height: 25,
                                  width: 40,
                                  onChange: (value) {
                                    _handleChangeAmount(value);
                                  },
                                  editable: false,
                                  onClickText: () async {
                                    _showAmountInputDialog(context);
                                  },
                                ),
                        ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Obx(
                        () => isRemoving.value
                            ? loadingWidget()
                            : ElevatedButton.icon(
                                onPressed: () {
                                  showToast("Does support now !!!");
                                },
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                  ),
                                  backgroundColor: CommonColor.redColor,
                                  elevation: 2,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(3),
                                  ),
                                ),
                                icon: const ImageIcon(
                                  AssetImage("assets/images/shopping/pay.png"),
                                  color: Colors.yellow,
                                ),
                                label: Text(
                                  LanguageGlobalVar.PAY.tr,
                                  style: CommonStyle.white18Bold,
                                ),
                              ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: Obx(
            () => isRemoving.value
                ? loadingWidget()
                : InkWell(
                    onTap: () {
                      _handleRemove();
                    },
                    child: const Icon(
                      Icons.remove_circle,
                      color: Colors.red,
                      size: 24,
                    ),
                  ),
          ),
        ),
        // Positioned(
        //   top: 0,
        //   left: 0,
        //   child: InkWell(
        //     onTap: () {
        //       isSelected.toggle();
        //       onSelect(data.id!, isSelected.value);
        //     },
        //     child: Obx(
        //       () => Icon(
        //         isSelected.value ? Icons.check_circle : Icons.circle_outlined,
        //         color: isSelected.value
        //             ? Colors.red
        //             : const Color.fromARGB(255, 227, 225, 225),
        //         size: 24,
        //       ),
        //     ),
        //   ),
        // ),
      ],
    );
  }

  final isSelected = false.obs;
  final isRemoving = false.obs;
  final isChangeAmounting = false.obs;
  void _handleRemove() async {
    final controller = Get.find<ShoppingCartController>();
    isRemoving.value = true;
    await controller
        .remove(
      data.id!,
    )
        .whenComplete(() {
      isRemoving.value = true;
    });
  }

  void _handleChangeAmount(int value) async {
    final controller = Get.find<ShoppingCartController>();
    isChangeAmounting.value = true;
    await controller
        .changeAmount(
      data.id!,
      value,
    )
        .whenComplete(() {
      isChangeAmounting.value = true;
    });
  }

  void _showAmountInputDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) {
        return AmountChangeDialog(
          cartItemId: data.id!,
          amount: data.amount!,
        );
      },
    );
  }
}
