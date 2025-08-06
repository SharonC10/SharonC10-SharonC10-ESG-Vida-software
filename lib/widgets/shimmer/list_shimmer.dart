import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Widget HomePageHoriShimmer(context) {
  var width = MediaQuery.of(context).size.width;
  var height = MediaQuery.of(context).size.height;
  return SizedBox(
      height: height * 0.153,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 4,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            period: const Duration(seconds: 1),
            child: Container(
              width: width * 0.36,
              margin: const EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: height * 0.14,
                    width: width * 0.5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: const DecorationImage(
                        image: AssetImage("assets/loading.gif"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ));
}
