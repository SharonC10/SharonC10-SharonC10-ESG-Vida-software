import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class NoDataFound extends StatelessWidget {
  final double height;
  final double width;

  const NoDataFound({super.key, required this.height, required this.width});

  @override
  Widget build(BuildContext context) {
    return Lottie.asset("assets/noDataLottie.json",
        width: width, height: height);
  }
}
