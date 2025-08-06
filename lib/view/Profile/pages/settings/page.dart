import 'package:ESGVida/pkg/inmemory_data.dart';
import 'package:ESGVida/pkg/language.dart';
import 'package:ESGVida/pkg/style_color.dart';
import 'package:ESGVida/screens/auth/change_password/screen.dart';
import 'package:ESGVida/screens/auth/login/screen.dart';
import 'package:ESGVida/screens/shopping/address/list/screen.dart';
import 'package:ESGVida/view/Profile/controller.dart';
import 'package:ESGVida/view/Profile/pages/page_enum.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../screens/settings/language_setting_screen.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProfileController>();
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (didPop) {
          return;
        }
        controller.currentPage.value = ProfilePageEnum.MAIN;
      },
      child: SingleChildScrollView(
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                onPressed: () {
                  controller.currentPage.value = ProfilePageEnum.MAIN;
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.green,
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Get.to(() => LanguageSettingScreen());
              },
              child: Container(
                padding: const EdgeInsets.all(15),
                alignment: Alignment.centerLeft,
                height: 60,
                width: MediaQuery.of(context).size.width,
                color: const Color(0xFF5856D6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${LanguageGlobalVar.Language.tr} ${LanguageGlobalVar.Setting.tr}',
                      style: CommonStyle.white18Bold,
                    ),
                    const Icon(
                      Icons.navigate_next,
                      color: Color.fromARGB(255, 255, 255, 178),
                    ),
                  ],
                ),
              ),
            ),
            const Divider(),
            Container(
              padding: const EdgeInsets.all(15),
              alignment: Alignment.centerLeft,
              height: 60,
              width: MediaQuery.of(context).size.width,
              color: const Color(0xFF10D6E1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    LanguageGlobalVar.PushNotification.tr,
                    style: CommonStyle.white18Bold,
                  ),
                  Switch(
                    activeColor: Colors.blue,
                    value: controller.isSwitched.value,
                    onChanged: (value) async {
                      await _handleNotificationPermission(controller);
                    },
                  )
                ],
              ),
            ),
            const Divider(),
            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return const ChangePasswordScreen();
                  },
                ));
              },
              child: Container(
                padding: const EdgeInsets.all(15),
                alignment: Alignment.centerLeft,
                height: 60,
                width: MediaQuery.of(context).size.width,
                color: const Color(0xFF1CdFAD),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      LanguageGlobalVar.ChangePassword.tr,
                      style: CommonStyle.white18Bold,
                    ),
                    const Icon(
                      Icons.navigate_next,
                      color: Color.fromARGB(255, 255, 255, 180),
                    ),
                  ],
                ),
              ),
            ),
            const Divider(),
            InkWell(
              onTap: () {
                _handleLogout(context);
              },
              child: Container(
                padding: const EdgeInsets.all(15),
                alignment: Alignment.centerLeft,
                height: 60,
                width: MediaQuery.of(context).size.width,
                color: const Color.fromARGB(255, 21, 180, 74),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      LanguageGlobalVar.Logout.tr,
                      style: CommonStyle.white18Bold,
                    ),
                    const Icon(
                      Icons.navigate_next,
                      color: Color.fromARGB(255, 254, 254, 178),
                    ),
                  ],
                ),
              ),
            ),
            const Divider(),
            InkWell(
              onTap: () {
                Get.to(const AddressListScreen());
              },
              child: Container(
                padding: const EdgeInsets.all(15),
                alignment: Alignment.centerLeft,
                height: 60,
                width: MediaQuery.of(context).size.width,
                color: Colors.redAccent,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      LanguageGlobalVar.ADDRESS.tr,
                      style: CommonStyle.white18Bold,
                    ),
                    const Icon(
                      Icons.navigate_next,
                      color: Color.fromARGB(255, 254, 254, 178),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _handleNotificationPermission(
      ProfileController controller) async {
    await openAppSettings().then((value) async {
      await Permission.notification.isGranted.then((value2) {
        controller.isSwitched.value = true;
      });
    });
  }

  void _handleLogout(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          elevation: 0,
          backgroundColor: Colors.white,
          child: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(vertical: 20),
            children: [
              Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: CommonColor.primaryColor,
                    width: 2,
                  ),
                ),
                child: const Icon(
                  Icons.question_mark,
                  size: 30,
                  color: CommonColor.primaryColor,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 20,
                  bottom: 10,
                ),
                child: Text(LanguageGlobalVar.ComeBackSoon.tr,
                    style: CommonStyle.black16Medium,
                    textAlign: TextAlign.center),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Text(
                  LanguageGlobalVar.AreYouSureLogout.tr,
                  style: CommonStyle.black14Medium,
                  textAlign: TextAlign.center,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                      // Get.back();
                    },
                    child: Container(
                      height: 35,
                      width: 100,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            CommonColor.blueAccent,
                            CommonColor.blueAccent,
                            //add more colors
                          ],
                        ),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Center(
                        child: Text(
                          LanguageGlobalVar.CANCEL.tr,
                          style: CommonStyle.white14Medium,
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      await GlobalInMemoryData.I.clearLoginData();
                      Get.offAll(
                        () => const SignInScreen(),
                        transition: Transition.fadeIn,
                        duration: const Duration(milliseconds: 300),
                      );
                    },
                    child: Container(
                      height: 35,
                      width: 100,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            CommonColor.blueAccent,
                            CommonColor.blueAccent,
                            //add more colors
                          ],
                        ),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Center(
                        child: Text(
                          LanguageGlobalVar.Logout.tr,
                          style: CommonStyle.white16Medium,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
