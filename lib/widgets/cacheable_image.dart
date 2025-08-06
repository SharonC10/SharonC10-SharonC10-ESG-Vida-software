import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get/get.dart';

Widget CommonChacheImage(
    {required double imgHeight,
    required double imgWidth,
    required String url,
    double? borderRadius,
    BoxShape? shape,
    Color? shodowColor}) {
  // print("Image Url = > " + url);
  return CachedNetworkImage(
    cacheManager: Get.find<CacheManager>(),
    imageBuilder: (context, imageProvider) => Container(
      height: imgHeight,
      width: imgWidth,
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(color: shodowColor ?? Colors.white, blurRadius: 1)
          ],
          shape: shape ?? BoxShape.rectangle,
          borderRadius:
              shape != null ? null : BorderRadius.circular(borderRadius ?? 5),
          image: DecorationImage(
              image: url.toString() == "null" || url.toString() == ""
                  ? const AssetImage("assets/place_holder_image.png")
                  : imageProvider,
              fit: BoxFit.cover)),
    ),
    imageUrl: url,
    errorWidget: (context, url, error) => Container(
      height: imgHeight,
      width: imgWidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius ?? 5),
        image: const DecorationImage(
          // image: AssetImage("assets/new_logo.png"),
          image: AssetImage("assets/place_holder_image.png"),
          // image: NetworkImage("https://www.airport-technology.com/wp-content/uploads/sites/14/2019/11/4737060_8f2da910_1024x1024.jpg"),
          fit: BoxFit.fill,
        ),
      ),
    ),
    placeholder: (context, url) => Container(
      height: imgHeight,
      width: imgWidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius ?? 5),
        image: const DecorationImage(
          image: AssetImage("assets/place_holder_image.png"),
          // image: AssetImage("assets/new_logo.png"),
          // image: NetworkImage("https://www.airport-technology.com/wp-content/uploads/sites/14/2019/11/4737060_8f2da910_1024x1024.jpg"),

          fit: BoxFit.fill,
        ),
      ),
    ),
  );
}
