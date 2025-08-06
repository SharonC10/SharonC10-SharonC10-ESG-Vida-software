import 'package:ESGVida/pkg/ext.dart';
import 'package:ESGVida/pkg/inmemory_data.dart';
import 'package:ESGVida/pkg/toast.dart';
import 'package:ESGVida/provider/user.dart';
import 'package:ESGVida/view/main/bottom_nav_screen.dart';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class logInController extends GetxController {
  final userProvider = Get.find<UserProvider>();
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  final selectedScreen = 0.obs;
  final controllerName = 'loginController'.obs;
  final emailidSignipController = TextEditingController().obs;
  final passwordSignipController = TextEditingController().obs;
  final signUpGlobalKey = GlobalKey<FormState>().obs;

  final items = [
    'assets/signInImage/Animation_1699418621936.json',
    'assets/signInImage/Animation_228.json',
  ].obs;

  final itemsOtp = [
    'assets/signInImage/Animation_4.json',
    'assets/signInImage/Animation_1.json',
  ].obs;

  final signupItems = [
    'assets/signInImage/Animation_4.json',
    'assets/signInImage/Animation_1.json',
  ].obs;
  final isGetSocialDetails = true.obs;
  final isCheckBoxDone = false.obs;

  /// sign up screen

  final genderList = ["Male", "Female", "Other"].obs;
  final updateGender = "".obs;
  final selectCategoryList = [
    "Java",
    "Python",
    "Html",
    "C++",
    "Java1",
    "Python1",
    "Html1",
    "C++1",
    "Java2",
    "Python2",
    "Html2",
    "C++2"
  ].obs;
  final selectCategoryListSlectItem = [].obs;

  //
  final obscureTextLogin = true.obs;

  ///verify otp Screen

  // final isTimerOn=false.obs;
  // late Timer timer;
  // final codeRemainingSeconds = 30.obs;
  // void startTimer() {
  //   isTimerOn.value=true;
  //   codeRemainingSeconds.value = 30;
  //   const oneSec = Duration(seconds: 1);
  //   timer = Timer.periodic(
  //     oneSec,
  //         (Timer timer) {
  //       if (codeRemainingSeconds.value == 0) {
  //         isTimerOn.value = false;
  //         timer.cancel();
  //       } else {
  //         codeRemainingSeconds.value--;
  //       }
  //     },
  //   );
  // }

//Todo Login

  final isLoginIsLoading = false.obs;
  final emailIdControllerSignIn = TextEditingController().obs;
  final passwordControllerSignIn = TextEditingController().obs;

  handlerLogin() {
    GlobalInMemoryData.I.obtainDeviceToken();
    final email = emailIdControllerSignIn.value.text;
    final password = passwordControllerSignIn.value.text;
    if (email.isEmpty) {
      showToast("Please enter email ");
    } else if (!email.isValidEmail()) {
      showToast("Please enter valid email");
    } else if (password.isEmpty) {
      showToast("Please enter password");
    }
    isLoginIsLoading.value = true;
    userProvider
        .login(
            email: emailIdControllerSignIn.value.text,
            password: passwordControllerSignIn.value.text,
            deviceType: GlobalInMemoryData.I.deviceType,
            deviceToken: GlobalInMemoryData.I.deviceToken)
        .then((value) async {
      if (value.isFail) {
        return;
      }
      await GlobalInMemoryData.I.setToken(value.data!.key);
      await GlobalInMemoryData.I.setLoginUser(value.data!.value);
      Get.offAll(() => DashBordScreen());
    }).whenComplete(() {
      isLoginIsLoading.value = false;
    });
  }

//Todo sign up

  final firstNameSignUpController = TextEditingController().obs;
  final lastNameSignUpController = TextEditingController().obs;
  final emailIdSIgnUpController = TextEditingController().obs;
  final passwordSignupController = TextEditingController().obs;
  final confirmSignUpPasswordController = TextEditingController().obs;
}
