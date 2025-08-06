import 'package:ESGVida/model/shopping.dart';
import 'package:ESGVida/pkg/ext.dart';
import 'package:ESGVida/pkg/inmemory_data.dart';
import 'package:ESGVida/provider/shopping/product_order.dart';
import 'package:ESGVida/provider/user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ESGVida/model/user.dart';
import 'package:permission_handler/permission_handler.dart';

import 'pages/page_enum.dart';

class ProfileController extends GetxController {
  @override
  void onInit() {
    init();
    super.onInit();
  }

  Future<void> init() async {
    final profileUrl = GlobalInMemoryData.I.loginUser?.profile?.profileImage ??
        "https://cdn-icons-png.flaticon.com/128/11820/11820145.png";
    userProfile.value = profileUrl;
    bool status = await Permission.notification.isGranted;
    if (status) {
      isSwitched.value = true;
      // notification permission is granted
    } else {
      isSwitched.value = false;
      // Open settings to enable notification permission
    }
    await fetchCurrentUserProfile();
  }

  final _userProvider = Get.find<UserProvider>();
  final _productOrderProvider = Get.find<ProductOrderProvider>();

  final currentPage = (ProfilePageEnum.MAIN).obs;

  final userProfile = "".obs;
  final isSwitched = false.obs;
  final firstNameController = TextEditingController().obs;
  final lastNameController = TextEditingController().obs;

  final passwordController = TextEditingController().obs;
  final confirmPasswordController = TextEditingController().obs;
  final signUpGlobalKey = GlobalKey<FormState>().obs;
  final updateGender = "Male".obs;

  final signupItems = [
    'assets/signInImage/Animation_4.json',
    'assets/signInImage/Animation_1.json',
  ].obs;
  final isGetSocialDetails = true.obs;
  final isCheckBoxDone = false.obs;

  final isOrderStatusLoading = false.obs;
  Map<ProductOrderStatus, int> orderStatus = {};
  Future<void> fetchOrderStatus() {
    isOrderStatusLoading.value = true;
    return _productOrderProvider.status().then((value) {
      if (value.isFail) {
        return;
      }
      orderStatus = value.data!;
    }).whenComplete(() {
      isOrderStatusLoading.value = false;
    });
  }

  // Todo get profile
  final profileIsLoading = false.obs;

  final profileData = UserProfileModel().obs;

  fetchCurrentUserProfile() {
    final userId = GlobalInMemoryData.I.userId;
    if (userId == null) {
      return;
    }
    profileIsLoading.value = true;
    _userProvider.getProfile(userId: userId).then((value) {
      if (value.isFail) {
        return;
      }
      profileData.value = value.data!;
    }).whenComplete(() {
      profileIsLoading.value = false;
    });
  }

  //Todo edit profile
  final profileImagePath = "".obs;

  editInit(UserProfileModel details) {
    firstNameController.value.text = details.firstName ?? "";
    lastNameController.value.text = details.lastName ?? "";
    updateGender.value = details.sexType ?? "";
  }

  final updateProfileIsLoading = false.obs;

  updateProfile(UserProfileModel details) {
    Map<String, dynamic> data = {};
    if (firstNameController.value.text != details.firstName) {
      data["first_name"] = firstNameController.value.text;
    }
    if (lastNameController.value.text != details.lastName) {
      data["last_name"] = lastNameController.value.text;
    }
    if (updateGender.value != details.sexType) {
      data["sex_type"] = updateGender.value;
    }
    if (profileImagePath.value.isNotEmpty) {
      data["profile_image"] = MultipartFile(
        profileImagePath.value,
        filename: profileImagePath.value.filename(),
      );
    }
    updateProfileIsLoading.value = true;
    _userProvider.updateProfile(formData: FormData(data)).then((value) async {
      if (value.isFail) {
        return;
      }
      await GlobalInMemoryData.I
          .setLoginUser(GlobalInMemoryData.I.loginUser!.copyWith(
        profile: value.data!,
      ));
      userProfile.value = value.data!.profileImage!;
      firstNameController.value.clear();
      lastNameController.value.clear();
      profileImagePath.value = "";
      updateGender.value = "";
      profileData.value = value.data!;
      Get.back();
    }).whenComplete(() {
      updateProfileIsLoading.value = false;
    });
  }
}
