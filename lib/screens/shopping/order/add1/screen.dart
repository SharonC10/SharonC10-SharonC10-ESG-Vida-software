import 'package:ESGVida/model/shopping.dart';
import 'package:ESGVida/pkg/language.dart';
import 'package:ESGVida/pkg/style_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

//todo 暂时不做，因为货币原因，不止购物车多选不好做，这个总结算也不好做
class OrderAddScreen extends StatelessWidget {
  final List<ShoppingCartItemModel> cartItems;
  const OrderAddScreen({
    super.key,
    required this.cartItems,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          padding: const EdgeInsets.only(left: 50),
          child: Text(
            LanguageGlobalVar.FILL_IN_THE_ORDER.tr,
            style: CommonStyle.white12Bold,
          ),
        ),
        backgroundColor: Colors.red,
      ),
      body: const SingleChildScrollView(
        child: Column(
          children: [Text("XXX")],
        ),
      ),
    );
  }
}
