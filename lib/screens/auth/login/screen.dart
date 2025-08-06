import 'package:ESGVida/pkg/inmemory_data.dart';
import 'package:ESGVida/screens/auth/change_password/forgot_password_screen.dart';
import 'package:ESGVida/screens/auth/signup/screen.dart';
import 'package:ESGVida/screens/auth/login/controller.dart';

import 'package:ESGVida/pkg/ext.dart';
import 'package:ESGVida/pkg/style_color.dart';
import 'package:ESGVida/widgets/loadings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX<logInController>(
      init: logInController(),
      initState: (state) {
        GlobalInMemoryData.I.obtainDeviceToken();
      },
      builder: (controller) {
        print(controller.controllerName.value);
        return Scaffold(
          appBar: AppBar(
            leading: InkWell(
                onTap: () {
                  Get.back();
                },
                child: const Icon(
                  Icons.arrow_back,
                  color: CommonColor.blackColor,
                  size: 24,
                )),
          ),
          body: SingleChildScrollView(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/new_logo.png',
                height: 180,
                fit: BoxFit.fill,
              ),
              20.height,
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Share your green\nLifestyle",
                    textAlign: TextAlign.center,
                    style: CommonStyle.forteStyleNew,
                  ),
                ],
              ),
              20.height,
            ],
          )),
          bottomSheet: Container(
            height: MediaQuery.of(context).size.height * 0.42,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  spreadRadius: 4,
                  blurRadius: 3,
                  offset: const Offset(0, 4),
                ),
              ],
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: ListView(
              padding: const EdgeInsets.only(left: 15, right: 15),
              physics: const ScrollPhysics(),
              shrinkWrap: true,
              children: [
                const SizedBox(
                  height: 7,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 165.0),
                  child: Divider(
                    thickness: 3,
                    color: const Color(0xFF79747E).withOpacity(0.4),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                  child: RichText(
                      text: const TextSpan(
                          style: TextStyle(color: Colors.black),
                          children: [
                        TextSpan(
                            text: "Login to ", style: CommonStyle.grey18Bold),
                        TextSpan(
                          text: "ESG-Vida",
                          style: CommonStyle.blue18Bold,
                          // recognizer:TapGestureRecognizer()..onTap = (){
                          //   helpAndSupportBottomSheet(context,"on-boarding",width,height);
                          // }
                        ),
                      ])),
                ),
                5.height,
                const Row(
                  children: [
                    Text(
                      "Welcome to the ESG-Vida",
                      style: CommonStyle.black14Light,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  //  height: 45,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  // color: Colors.grey.shade300,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                    border:
                        Border.all(width: 0.4, color: CommonColor.blueAccent),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset:
                            const Offset(0, 2), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(
                        child: TextFormField(
                          autofocus: false,
                          controller: controller.emailIdControllerSignIn.value,
                          style: CommonStyle.black15Medium,
                          inputFormatters: [
                            FilteringTextInputFormatter.deny(RegExp(r'\s')),
                          ],
                          decoration: const InputDecoration(
                              border: InputBorder.none,
                              counterText: "",
                              filled: true,
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 1, horizontal: 5),
                              fillColor: Colors.transparent,
                              hintText: "Enter Email-id",
                              hintStyle: CommonStyle.grey14Light),
                        ),
                      ),
                    ],
                  ),
                ),
                15.height,
                Container(
                  //  height: 45,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  // color: Colors.grey.shade300,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                    border:
                        Border.all(width: 0.4, color: CommonColor.blueAccent),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset:
                            const Offset(0, 2), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(
                        child: TextFormField(
                          obscureText: controller.obscureTextLogin.value,
                          autofocus: false,
                          controller: controller.passwordControllerSignIn.value,
                          style: CommonStyle.black15Medium,
                          inputFormatters: [
                            FilteringTextInputFormatter.deny(RegExp(r'\s')),
                          ],
                          decoration: InputDecoration(
                              suffixIcon: Padding(
                                padding: const EdgeInsets.only(right: 5),
                                child: InkWell(
                                    onTap: () {
                                      controller.obscureTextLogin.value =
                                          !controller.obscureTextLogin.value;
                                    },
                                    child: Icon(
                                      controller.obscureTextLogin.value
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      color: CommonColor.blueAccent,
                                      size: 20,
                                    )),
                              ),
                              suffixIconConstraints: const BoxConstraints(
                                  maxHeight: 30,
                                  minHeight: 20,
                                  maxWidth: 40,
                                  minWidth: 20),
                              border: InputBorder.none,
                              counterText: "",
                              filled: true,
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 1, horizontal: 5),
                              fillColor: Colors.transparent,
                              hintText: "Enter Password",
                              hintStyle: CommonStyle.grey14Light),
                        ),
                      ),
                    ],
                  ),
                ),
                10.height,
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                        onTap: () {
                          Get.to(const ForgotPasswordScreen());
                        },
                        child: const Text(
                          "Forgot password",
                          style: CommonStyle.blue14Boldunderline,
                        )),
                  ],
                ),
                const SizedBox(height: 10),
                MaterialButton(
                    onPressed: () {
                      controller.handlerLogin();
                    },
                    color: CommonColor.blueAccent,
                    minWidth: double.infinity,
                    height: 40,
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100)),
                    child: controller.isLoginIsLoading.value
                        ? loadingButtonWidget()
                        : const Center(
                            child: Text(
                            "Login",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                          ))),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Haven't Account? ", style: CommonStyle.grey12Medium),
                    InkWell(
                        onTap: () {
                          Get.to(const signUpScreen());
                        },
                        child: const Text(
                          "SignUp",
                          style: CommonStyle.blue14Regular,
                        )),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
