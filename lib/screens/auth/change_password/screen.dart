import 'package:ESGVida/screens/auth/change_password/controller.dart';
import 'package:ESGVida/pkg/ext.dart';
import 'package:ESGVida/pkg/style_color.dart';
import 'package:ESGVida/widgets/common_appbar.dart';
import 'package:ESGVida/widgets/fields/password_field.dart';
import 'package:ESGVida/widgets/loadings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ESGVida/pkg/language.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX<ChangePasswordController>(
      init: ChangePasswordController(),
      builder: (controller) {
        print(controller.controllerName.value);
        return Scaffold(
          backgroundColor: const Color(0xFFF5F7FA),
          appBar: CommonAppbarInside(
            bgColor: const Color(0xFF1CdFAD),
            context,
            title: LanguageGlobalVar.ChangePassword.tr,
          ),
          body: Stack(
            children: [
              SingleChildScrollView(
                child: Container(
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/password.png'),
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
              ),
              // controller.isGetSocialDetails.value == false
              //     ? Center(
              //   child: Container(
              //     height: 80,
              //     width: 80,
              //     margin: const EdgeInsets.only(bottom: 100),
              //     decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.white, boxShadow: [BoxShadow(color: Colors.grey.shade300, offset: const Offset(0, 1), blurRadius: 1, spreadRadius: 2)]),
              //     child: Center(
              //       child: SizedBox(
              //         height: 65,
              //         child: OverflowBox(
              //           minHeight: 110,
              //           maxHeight: 110,
              //           maxWidth: 110,
              //           minWidth: 110,
              //           child: Lottie.asset('assets/signInImage/Animation_2.json', fit: BoxFit.fill),
              //         ),
              //       ),
              //     ),
              //   ),
              // )
              //     : const SizedBox()
            ],
          ),
          bottomSheet: Container(
            height: MediaQuery.of(context).size.height * 0.55,
            color: Colors.white,
            child: ListView(
              padding: const EdgeInsets.only(left: 15, right: 15),
              physics: const ScrollPhysics(),
              shrinkWrap: true,
              children: [
                15.height,
                PasswordField(
                  obscureText: controller.currentPasswordVisible,
                  textEditingController: controller.oldPasswordController.value,
                  hintText: LanguageGlobalVar.ENTER_OLD_PASSWORD.tr,
                ),
                15.height,
                PasswordField(
                  obscureText: controller.newPasswordVisible,
                  textEditingController: controller.newPasswordController.value,
                  hintText: LanguageGlobalVar.ENTER_NEW_PASSWORD.tr,
                ),
                15.height,
                PasswordField(
                  obscureText: controller.confirmPasswordVisible,
                  textEditingController:
                      controller.confirmPasswordController.value,
                  hintText: LanguageGlobalVar.ENTER_CONFIRM_PASSWORD.tr,
                ),
                40.height,
                const SizedBox(height: 10),
                MaterialButton(
                    onPressed: () async {
                      controller.changePassword();
                    },
                    color: CommonColor.blueAccent,
                    minWidth: double.infinity,
                    height: 40,
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100)),
                    child: Center(
                        child: controller.isChangePasswordIsLoading.value
                            ? loadingButtonWidget()
                            : Text(
                                LanguageGlobalVar.ChangePassword.tr,
                                style: CommonStyle.white14Bold,
                              ))),
                5.height,
                Text(
                  LanguageGlobalVar.ChangePasswordNote.tr,
                  style: CommonStyle.black12Medium,
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
