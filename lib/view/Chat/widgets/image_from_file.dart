import 'dart:io';
import 'package:flutter/material.dart';

Widget imageFromFile({
  required double imgHeight,
  required double imgWidth,
  required String uri,
  double? borderRadius,
  BoxShape? shape,
  Color? shadowColor,
  bool showPrecessText = false,
}) {
  return Container(
    height: imgHeight,
    width: imgWidth,
    decoration: BoxDecoration(
      boxShadow: [BoxShadow(color: shadowColor ?? Colors.white, blurRadius: 1)],
      shape: shape ?? BoxShape.rectangle,
      borderRadius:
          shape != null ? null : BorderRadius.circular(borderRadius ?? 5),
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius ?? 5),
      child: Image.file(
        File(uri),
        errorBuilder: (ctx, error, stack) {
          return const Image(
            image: AssetImage("assets/place_holder_image.png"),
            fit: BoxFit.fill,
          );
        },
      ),
    ),
  );
}
