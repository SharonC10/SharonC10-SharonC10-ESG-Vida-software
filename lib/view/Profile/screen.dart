import 'package:ESGVida/pkg/ext.dart';

import 'package:ESGVida/pkg/style_color.dart';
import 'package:ESGVida/view/Profile/pages/page_enum.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      init: ProfileController(),
      builder: (controller) {
        final size = MediaQuery.sizeOf(context);
        return Scaffold(
          appBar: AppBar(
            backgroundColor: CommonColor.primaryColor,
            automaticallyImplyLeading: false,
            actions: [
              Container(
                width: size.width,
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset(
                      "assets/images/appbarlogowhite.png",
                      height: 50,
                    ),
                    50.width,
                    Obx(
                      () => Text(
                        controller.currentPage.value.label.tr,
                        style: CommonStyle.white22Medium,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        controller.currentPage.value = ProfilePageEnum.SETTINGS;
                      },
                      icon: const Icon(
                        Icons.settings_outlined,
                        color: Color(0xFF32BEA6),
                        size: 40,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          body: Obx(
            () => controller.currentPage.value.builder(),
          ),
        );
      },
    );
  }
}
