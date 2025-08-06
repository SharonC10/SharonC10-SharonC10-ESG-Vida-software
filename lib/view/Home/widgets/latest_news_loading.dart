import 'package:ESGVida/pkg/ext.dart';

import 'package:ESGVida/pkg/style_color.dart';
import 'package:ESGVida/widgets/shimmer/common_shimmer.dart';
import 'package:flutter/material.dart';

class LatestNewsCarouselSliderLoading extends StatelessWidget {
  const LatestNewsCarouselSliderLoading({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    var width = size.width;
    var height = size.height;
    return CommonShimmer(
      childWidget: Container(
        width: width,
        height: height * 0.16,
        margin: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 15,
        ),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
          boxShadow: [
            BoxShadow(
              color: CommonColor.primaryColor.withOpacity(
                0.15,
              ),
              spreadRadius: 1,
              blurRadius: 1,
            ),
          ],
          border: Border.all(
            color: CommonColor.primaryColor.withOpacity(0.2),
            width: 0.1,
          ),
          color: Colors.white,
          image: const DecorationImage(
            image: AssetImage("assets/images/solars.png"),
            fit: BoxFit.fill,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color(0xE6ECFBFF),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 10,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 90,
                width: 120,
              ),
              15.width,
              const Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Title",
                      style: CommonStyle.black16Bold,
                    ),
                    Text(
                      "Description",
                      style: CommonStyle.grey14Medium,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
