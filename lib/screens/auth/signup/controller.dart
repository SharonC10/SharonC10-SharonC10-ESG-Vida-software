import 'package:ESGVida/pkg/ext.dart';
import 'package:ESGVida/pkg/inmemory_data.dart';
import 'package:ESGVida/pkg/toast.dart';
import 'package:ESGVida/provider/user.dart';
import 'package:ESGVida/view/main/bottom_nav_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  final userProvider = Get.find<UserProvider>();

  final controllerName = 'loginController'.obs;
  final firstNameController = TextEditingController().obs;
  final lastNameController = TextEditingController().obs;
  final emailIdController = TextEditingController().obs;
  final passwordController = TextEditingController().obs;
  final confirmPasswordController = TextEditingController().obs;
  final signUpGlobalKey = GlobalKey<FormState>().obs;
  final profileImagePath = "".obs;
  final signUpController = false.obs;
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
  final updateGender = "Male".obs;
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

  handlerSignup() {
    if (!checkArgs()) {
      return;
    }
    final Map<String, dynamic> data = {
      "email": emailIdController.value.text,
      "first_name": firstNameController.value.text,
      "last_name": lastNameController.value.text,
      "sex_type":
          updateGender.value == "Male" ? "M" : updateGender.value == "Female" ? "F" : updateGender.value == "Other" ? "O" : "M",
      "device_type": "Android",
      "device_token": GlobalInMemoryData.I.deviceToken,
      "password": passwordController.value.text,
      "profile_image": MultipartFile(profileImagePath.value,
          filename: profileImagePath.value.filename())
    };
    signUpController.value = true;
    userProvider.signup(FormData(data)).then((value) async {
      if (value.isFail) {
        return;
      }
      await GlobalInMemoryData.I.setToken(value.data!.key);
      await GlobalInMemoryData.I.setLoginUser(value.data!.value);
      Get.offAll(() => DashBordScreen());
    }).whenComplete(() {
      signUpController.value = false;
    });
  }

  final obscureTextSignup = true.obs;
  final obscureTextSignupConfirm = true.obs;

  bool checkArgs() {
    if (profileImagePath.value == "") {
      showToast("Please select profile image");
      return false;
    } else if (firstNameController.value.text.isEmpty) {
      showToast("Please enter first name");
      return false;
    } else if (lastNameController.value.text.isEmpty) {
      showToast("Please enter last name");
      return false;
    } else if (emailIdController.value.text.isEmpty) {
      showToast("Please enter emailId");
      return false;
    } else if (passwordController.value.text.isEmpty) {
      showToast("Please enter password");
      return false;
    } else if (confirmPasswordController.value.text.isEmpty) {
      showToast("Please enter confirm password");
      return false;
    } else if (passwordController.value.text.toString().trim() !=
        confirmPasswordController.value.text.toString().trim()) {
      showToast("password and confirm password not match");
      return false;
    } else if (updateGender.value == "") {
      showToast("Please select gender");
      return false;
    } else if (isCheckBoxDone.value == false) {
      showToast("Please select T&C");
      return false;
    }
    return true;
  }

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
}
