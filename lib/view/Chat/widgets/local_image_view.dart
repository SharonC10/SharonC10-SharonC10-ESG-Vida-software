import 'dart:io';

import 'package:ESGVida/pkg/style_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LocalImageView extends StatefulWidget {
  String url;

  LocalImageView({super.key, required this.url});

  @override
  State<LocalImageView> createState() => _LocalImageViewState();
}

class _LocalImageViewState extends State<LocalImageView> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.sizeOf(context).height;
    var width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      backgroundColor: CommonColor.blackColor,
      appBar: AppBar(
        elevation: 2,
        shadowColor: Colors.grey,
        titleSpacing: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        toolbarHeight: 40,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              width: 20,
            ),
            GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                  size: 21,
                )),
            const SizedBox(
              width: 5,
            ),
            const Text(
              "Image view",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 16),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
              width: width,
              height: height * 0.5,
              child: Image.file(
                File(widget.url),
                fit: BoxFit.cover,
              ))
        ],
      ),
    );
  }
}
