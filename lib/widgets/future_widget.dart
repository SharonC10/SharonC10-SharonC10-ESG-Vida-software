import 'package:flutter/material.dart';

FutureBuilder<T> futureWidget<T>({
  required Future<T> future,
  bool notNull = true,
  required Widget Function(T data) builder,
  Widget? errorWidget,
  Widget? loadingWidget,
  double? errorOrLoadingWidth,
  double? errorOrLoadingHeight,
}) {
  return FutureBuilder<T>(
      future: future,
      builder: (ctx, snap) {
        if (snap.hasError) {
          if (errorWidget != null) {
            return errorWidget;
          }
          return Container(
            width: errorOrLoadingWidth,
            height: errorOrLoadingHeight,
            alignment: Alignment.center,
            child: const Icon(Icons.error, color: Colors.red),
          );
        }
        if (notNull && !snap.hasData) {
          if (loadingWidget != null) {
            return loadingWidget;
          }
          return Container(
            width: errorOrLoadingWidth,
            height: errorOrLoadingHeight,
            alignment: Alignment.center,
            child: Image.asset("assets/loading.gif"),
          );
        }
        return builder(snap.data as T);
      });
}
