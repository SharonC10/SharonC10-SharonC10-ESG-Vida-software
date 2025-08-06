import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CommonShimmer extends StatelessWidget {
  final Widget childWidget;

  const CommonShimmer({super.key, required this.childWidget});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: const Color(0x1AEDF6F2),
      period: const Duration(seconds: 1),
      enabled: true,
      child: childWidget,
    );
  }
}
