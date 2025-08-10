import 'dart:async';

import 'package:ESGVida/pkg/inmemory_data.dart';
import 'package:ESGVida/screens/auth/login/screen.dart';
import 'package:ESGVida/pkg/ext.dart';
import 'package:ESGVida/pkg/style_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'bottom_nav_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double turnRotations = 0;

  chageRotation() {
    setState(() {
      turnRotations += 1 / 1;
    });
  }

  @override
  void initState() {
    chageRotation();
    // TODO: implement initState
    super.initState();
    navigate();
  }

  navigate() async {
    Future.delayed(
      const Duration(milliseconds: 1),
      () {
        chageRotation();
      },
    );
    Timer(const Duration(seconds: 3), () {
      if (GlobalInMemoryData.I.isLogin) {
        Get.offAll(() => DashBordScreen( //If the user is logged in, the app navigates to DashBordScreen.
              selectedIndex: 0,
            ));
      } else {
        Get.offAll(() => const SignInScreen()); //If not logged in, it goes to SignInScreen.
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox(
            height: MediaQuery.sizeOf(context).height,
            width: MediaQuery.sizeOf(context).width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/new_logo.png',
                  height: 200,
                  fit: BoxFit.fill,
                ),
                20.height,
                const Text(
                  "Share your green\nLifestyle",
                  textAlign: TextAlign.center,
                  style: CommonStyle.forteStyleNew,
                ),
                20.height,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/appLogoblack.png',
                      height: 100,
                      fit: BoxFit.fill,
                    ),
                  ],
                )
              ],
            )));
  }
}
