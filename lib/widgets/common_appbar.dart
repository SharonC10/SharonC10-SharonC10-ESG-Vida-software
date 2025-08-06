import 'package:ESGVida/pkg/style_color.dart';
import 'package:flutter/material.dart';

CommonAppbarInside(context, {required String title, Color? bgColor}) {
  return AppBar(
    toolbarHeight: 45,
    // centerTitle: true,
    backgroundColor: bgColor ?? const Color(0xFF0094EE),
    leading: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: const Icon(
          Icons.arrow_back,
          color: Colors.white,
          size: 24,
        )),
    title: Text(title, style: CommonStyle.white30Medium),
  );
}
