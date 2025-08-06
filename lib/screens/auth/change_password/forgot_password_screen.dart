import 'package:ESGVida/screens/auth/change_password/controller.dart';

import 'package:ESGVida/pkg/ext.dart';
import 'package:ESGVida/pkg/style_color.dart';
import 'package:ESGVida/widgets/loadings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../widgets/fields/password_field.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX<ChangePasswordController>(
      init: ChangePasswordController(),
      builder: (controller) {
        print(controller.controllerName.value);
        return Scaffold(
          backgroundColor: const Color(0xFFF5F7FA),
          appBar: AppBar(
            elevation: 2,
            scrolledUnderElevation: 0,
            shadowColor: CommonColor.primaryColor.withOpacity(0.2),
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
                  "Forgot password",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 16),
                  textAlign: TextAlign.center,
                )
              ],
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/forgot_image.png'),
                            fit: BoxFit.cover)),
                    // color: Colors.grey,
                    height: MediaQuery.of(context).size.height * 0.4,
                    child: const Center(
                        // child: Image.asset('assets/images/solars.png'),
                        // child: Column(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   crossAxisAlignment: CrossAxisAlignment.start,
                        //   children: [
                        //     Auth_slider(
                        //       items: controller.items,
                        //     )
                        //   ],
                        // ),
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
                      border: Border.all(
                          width: 0.4, color: CommonColor.primaryColor),
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
                            controller: controller.emailController.value,
                            style: CommonStyle.black14Regular,
                            decoration: const InputDecoration(
                                border: InputBorder.none,
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
                  PasswordField(
                      obscureText: controller.newPasswordVisibleForgot,
                      textEditingController:
                          controller.newPasswordControllerForgot.value,
                      hintText: "Enter new password"),
                  15.height,
                  PasswordField(
                      obscureText: controller.confirmPasswordVisibleForgot,
                      textEditingController:
                          controller.confirmPasswordControllerForgot.value,
                      hintText: "Enter confirm password"),
                  40.height,
                  const SizedBox(height: 10),
                  MaterialButton(
                      onPressed: () {
                        controller.forgotPassword();
                      },
                      color: CommonColor.blueAccent,
                      minWidth: double.infinity,
                      height: 40,
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100)),
                      child: Center(
                          child: controller.isForgotPasswordIsLoading.isTrue
                              ? loadingButtonWidget()
                              : const Text(
                                  "Change password",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                )))
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
