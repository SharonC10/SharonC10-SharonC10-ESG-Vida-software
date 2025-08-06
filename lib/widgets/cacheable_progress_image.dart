import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get/get.dart';

Widget commonCacheImage2({
  required double imgHeight,
  required double imgWidth,
  required String url,
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
      child: CachedNetworkImage(
        cacheManager: Get.find<CacheManager>(),
        progressIndicatorBuilder: (context, url, downloadProgress) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                  child: CircularProgressIndicator(
                      value: downloadProgress.progress)),
              if (showPrecessText)
                Text("${((downloadProgress.progress ?? 0) * 100).toInt()}%"),
            ],
          );
        },
        imageBuilder: (context, imageProvider) {
          return Image(
            image: url.toString() == "null" || url.toString() == ""
                ? const AssetImage("assets/place_holder_image.png")
                : imageProvider,
            fit: BoxFit.cover,
          );
        },
        imageUrl: url,
        errorWidget: (context, url, error) {
          return const Image(
            // image: AssetImage("assets/new_logo.png"),
            image: AssetImage("assets/place_holder_image.png"),
            // image: NetworkImage("https://www.airport-technology.com/wp-content/uploads/sites/14/2019/11/4737060_8f2da910_1024x1024.jpg"),
            fit: BoxFit.fill,
          );
        },
      ),
    ),
  );
}
