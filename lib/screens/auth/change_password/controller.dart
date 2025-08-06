import 'package:ESGVida/pkg/ext.dart';
import 'package:ESGVida/pkg/inmemory_data.dart';
import 'package:ESGVida/pkg/toast.dart';
import 'package:ESGVida/provider/user.dart';
import 'package:ESGVida/screens/auth/login/screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ChangePasswordController extends GetxController {
  final userProvider = Get.find<UserProvider>();
  final controllerName = "changePassword".obs;

  final currentPasswordVisible = true.obs;
  final newPasswordVisible = true.obs;
  final confirmPasswordVisible = true.obs;

  final oldPasswordController = TextEditingController().obs;
  final newPasswordController = TextEditingController().obs;
  final confirmPasswordController = TextEditingController().obs;

//Todo change password
  final isChangePasswordIsLoading = false.obs;

  changePassword() {
    final old = oldPasswordController.value.text;
    final newOne = newPasswordController.value.text;
    final confirm = confirmPasswordController.value.text;
    if (old.isEmpty) {
      showToast("Please enter old password ");
      return;
    } else if (newOne.isEmpty) {
      showToast("Please enter new password");
      return;
    } else if (confirm.isEmpty) {
      showToast("Please enter confirm password");
      return;
    } else if (newOne != confirm) {
      showToast("New password and confirm password do not match");
      return;
    }
    isChangePasswordIsLoading.value = true;
    userProvider
        .changePassword(old: old, newOne: newOne, confirm: confirm)
        .then((value) async {
      if (value.isFail) {
        return;
      }
      confirmPasswordVisible.value = true;
      currentPasswordVisible.value = true;
      newPasswordVisible.value = true;
      oldPasswordController.value.clear();
      newPasswordController.value.clear();
      confirmPasswordController.value.clear();
      GlobalInMemoryData.I.clearLoginData();
      Get.offAll(
        () => const SignInScreen(),
        transition: Transition.fadeIn,
        duration: const Duration(milliseconds: 300),
      );
    }).whenComplete(() {
      isChangePasswordIsLoading.value = false;
    });
  }

  //Todo forgot password
  final isForgotPasswordIsLoading = false.obs;

  final newPasswordVisibleForgot = true.obs;
  final confirmPasswordVisibleForgot = true.obs;

  final emailController = TextEditingController().obs;
  final newPasswordControllerForgot = TextEditingController().obs;
  final confirmPasswordControllerForgot = TextEditingController().obs;

  forgotPassword() {
    final email = emailController.value.text;
    final newOne = newPasswordController.value.text;
    final confirm = confirmPasswordController.value.text;
    if (email.isEmpty) {
      showToast("Please enter email");
      return;
    } else if (!email.isValidEmail()) {
      showToast("Please enter valid email");
      return;
    } else if (newOne.isEmpty) {
      showToast("Please enter new password");
      return;
    } else if (confirm.isEmpty) {
      showToast("Please enter confirm password");
      return;
    } else if (newOne != confirm) {
      showToast("New password & confirm password did not match");
      return;
    }

    isForgotPasswordIsLoading.value = true;
    userProvider
        .forgotPassword(email: email, newOne: newOne, confirm: confirm)
        .then((value) {
      isForgotPasswordIsLoading.value = false;
      confirmPasswordVisibleForgot.value = true;
      newPasswordVisibleForgot.value = true;
      newPasswordControllerForgot.value.clear();
      confirmPasswordControllerForgot.value.clear();
      emailController.value.clear();
      Get.offAll(() => const SignInScreen());
    }).whenComplete(() {
      isForgotPasswordIsLoading.value = false;
    });
  }
}
