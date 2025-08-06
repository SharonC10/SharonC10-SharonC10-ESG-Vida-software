import 'package:ESGVida/pkg/style_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

loadingButtonWidget({
  Color bgColor = CommonColor.whiteColor,
}) {
  return Center(
    child: Container(
      padding: const EdgeInsets.all(5),
      child: CupertinoActivityIndicator(
        color: bgColor,
        animating: true,
        radius: 18,
      ),
    ),
  );
}

loadingIndigator(
    {double? width,
    double? height,
    Color? color,
    double? value,
    double? radius}) {
  return Container(
    height: height,
    width: width,
    alignment: Alignment.center,
    child: CircularProgressIndicator(
      value: value,
      color: color,
      backgroundColor: Colors.transparent,
      strokeAlign: 1,
      strokeWidth: radius ?? 3,
    ),
  );
}

loadingWidget() {
  return Center(
    child: Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: const [
            BoxShadow(
                // color: Colors.grey.shade400,
                color: CommonColor.primaryColor20,
                blurRadius: 5,
                spreadRadius: 0,
                blurStyle: BlurStyle.outer)
          ]),
      child: const CupertinoActivityIndicator(
        color: CommonColor.primaryColor,
        radius: 18,
      ),
    ),
  );
}
