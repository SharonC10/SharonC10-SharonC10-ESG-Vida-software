import 'package:ESGVida/pkg/ext.dart';
import 'package:flutter/material.dart';

Widget HomePageGridShimmer(context) {
  var width = MediaQuery.of(context).size.width;
  var height = MediaQuery.of(context).size.height;
  return SingleChildScrollView(
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: width * 0.45,
              height: height * 0.25,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: const DecorationImage(
                  image: AssetImage("assets/loading.gif"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              width: width * 0.45,
              height: height * 0.25,
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
        10.height,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: width * 0.45,
              height: height * 0.25,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: const DecorationImage(
                  image: AssetImage("assets/loading.gif"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              width: width * 0.45,
              height: height * 0.25,
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
        10.height,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: width * 0.45,
              height: height * 0.25,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: const DecorationImage(
                  image: AssetImage("assets/loading.gif"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              width: width * 0.45,
              height: height * 0.25,
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
      ],
    ),
  );
}
