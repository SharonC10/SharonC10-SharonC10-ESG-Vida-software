import 'dart:io';

import 'package:ESGVida/pkg/toast.dart';

import 'package:ESGVida/pkg/ext.dart';
import 'package:ESGVida/pkg/style_color.dart';
import 'package:ESGVida/widgets/cacheable_image.dart';
import 'package:ESGVida/widgets/loadings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'package:ESGVida/model/user.dart';

import '../controller.dart';

class EditProfileScreen extends StatelessWidget {
  final UserProfileModel details;

  const EditProfileScreen({super.key, required this.details});

  @override
  Widget build(BuildContext context) {
    return GetX<ProfileController>(
      init: ProfileController(),
      initState: (v) {
        v.controller!.editInit(details);
      },
      builder: (controller) {
        return Scaffold(
          backgroundColor: CommonColor.bgColor,
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
                  "Edit Profile",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 16),
                  textAlign: TextAlign.center,
                )
              ],
            ),
            // actions: [
            //   Padding(
            //     padding: const EdgeInsets.only(right: 20.0),
            //     child: InkWell(
            //         onTap: () async {
            //           // String message = "Details About Station";
            //           // Share.share(message);
            //           // final image = await controller.ShareScreenshotController.capture();
            //           // if (image == null) return;
            //           // // await saveImage(image);
            //           // saveAndShare(image, from == "main" ? "${turfModel!.turfName}" : "${filterturfmodel!.turfName}");
            //         },
            //         child: const Icon(
            //           Icons.share,
            //           color: Colors.black,
            //           size: 22,
            //         )),
            //   ),
            // ],
          ),
          body: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            shrinkWrap: true,
            physics: const ScrollPhysics(),
            children: [
              20.height,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      controller.profileImagePath.value == ""
                          ? Container(
                              height: 100,
                              width: 100,
                              padding: const EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: CommonColor.whiteColor,
                                  boxShadow: const [
                                    BoxShadow(
                                        color: CommonColor.greyColor,
                                        blurRadius: 2)
                                  ],
                                  image: details.profileImage == null
                                      ? DecorationImage(
                                          image: NetworkImage(
                                              "${details.profileImage}"),
                                          fit: BoxFit.cover)
                                      : null),
                              child: details.profileImage == null
                                  ? const SizedBox()
                                  : CommonChacheImage(
                                      imgHeight: 100,
                                      imgWidth: 100,
                                      url: "${details.profileImage}",
                                      shape: BoxShape.circle),
                            )
                          : Container(
                              height: 100,
                              width: 100,
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: CommonColor.whiteColor,
                                  boxShadow: const [
                                    BoxShadow(
                                        color: CommonColor.greyColor,
                                        blurRadius: 2)
                                  ],
                                  image: DecorationImage(
                                      image: FileImage(File(
                                          controller.profileImagePath.value)),
                                      fit: BoxFit.cover)),
                            ),
                      Positioned(
                          bottom: 0,
                          right: 0,
                          child: InkWell(
                            onTap: () async {
                              final ImagePicker picker = ImagePicker();
                              final XFile? pickedFile = await picker.pickImage(
                                  source: ImageSource.gallery);
                              if (pickedFile != null) {
                                controller.profileImagePath.value =
                                    pickedFile.path.toString();
                              }
                            },
                            child: const CircleAvatar(
                              radius: 12,
                              backgroundColor: Colors.blue,
                              child: Icon(
                                Icons.camera_alt,
                                color: Colors.white,
                                size: 15,
                              ),
                            ),
                          ))
                    ],
                  ),
                ],
              ),
              20.height,
              const Text(
                "First name",
                style: CommonStyle.black15400,
              ),
              5.height,
              Container(
                //  height: 45,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                // color: Colors.grey.shade300,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: 0.4, color: CommonColor.blueAccent),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 2), // changes position of shadow
                    ),
                  ],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        maxLength: 10,
                        autofocus: false,
                        controller: controller.firstNameController.value,
                        style: CommonStyle.black14Light,
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            counterText: "",
                            filled: true,
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 1, horizontal: 5),
                            fillColor: Colors.transparent,
                            hintText: "First name",
                            hintStyle: CommonStyle.grey14Light),
                      ),
                    ),
                  ],
                ),
              ),
              10.height,
              const Text(
                "Last name",
                style: CommonStyle.black15400,
              ),
              5.height,
              Container(
                //  height: 45,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                // color: Colors.grey.shade300,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: 0.4, color: CommonColor.blueAccent),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 2), // changes position of shadow
                    ),
                  ],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        maxLength: 10,
                        autofocus: false,
                        controller: controller.lastNameController.value,
                        style: CommonStyle.black14Light,
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            counterText: "",
                            filled: true,
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 1, horizontal: 5),
                            fillColor: Colors.transparent,
                            hintText: "Last name",
                            hintStyle: CommonStyle.grey14Light),
                      ),
                    ),
                  ],
                ),
              ),
              10.height,
              const Text(
                "Email Address",
                style: CommonStyle.black15400,
              ),
              5.height,
              Container(
                //  height: 45,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                // color: Colors.grey.shade300,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: 0.4, color: CommonColor.blueAccent),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 2), // changes position of shadow
                    ),
                  ],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        readOnly: true,
                        maxLength: 10,
                        autofocus: false,
                        controller: TextEditingController(text: details.email),
                        style: CommonStyle.black14Light,
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            counterText: "",
                            filled: true,
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 1, horizontal: 5),
                            fillColor: Colors.transparent,
                            hintText: "Enter email-id",
                            hintStyle: CommonStyle.grey14Light),
                      ),
                    ),
                  ],
                ),
              ),
              10.height,
              const Text(
                "Select gender",
                style: CommonStyle.black15400,
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 24,
                      width: 24,
                      child: Radio(
                        visualDensity: VisualDensity.compact,
                        value: Gender.male.value,
                        activeColor: CommonColor.blueAccent,
                        groupValue: controller.updateGender.value,
                        onChanged: (value) {
                          controller.updateGender.value = value!;
                        },
                      ),
                    ),
                    Text(
                      Gender.male.label.tr,
                      style: CommonStyle.black14Medium,
                    ),
                    Radio(
                      visualDensity: VisualDensity.compact,
                      value: Gender.female.value,
                      activeColor: CommonColor.blueAccent,
                      groupValue: controller.updateGender.value,
                      onChanged: (value) {
                        controller.updateGender.value = value!;
                      },
                    ),
                    Text(
                      Gender.female.label.tr,
                      style: CommonStyle.black14Medium,
                    ),
                    Radio(
                      visualDensity: VisualDensity.compact,
                      value: Gender.other.value,
                      groupValue: controller.updateGender.value,
                      activeColor: CommonColor.blueAccent,
                      onChanged: (value) {
                        controller.updateGender.value = value!;
                      },
                    ),
                    Text(
                      Gender.other.label.tr,
                      style: CommonStyle.black14Medium,
                    ),
                  ],
                ),
              ),
              50.height,
              MaterialButton(
                  onPressed: () {
                    if (controller.firstNameController.value.text.isEmpty) {
                      showToast("Please enter first name");
                    } else if (controller
                        .lastNameController.value.text.isEmpty) {
                      showToast("Please enter last name");
                    } else {
                      controller.updateProfile(details);
                    }
                  },
                  color: CommonColor.blueAccent,
                  minWidth: double.infinity,
                  height: 45,
                  elevation: 1,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100)),
                  // onPressed:controller.isCheckBoxDone.value==true? () async {
                  //   if(controller.mobileControllerSignInScreen.value.text.isEmpty){
                  //     Constant.showToastTop("Please enter mobile number");
                  //   }else if(controller.mobileControllerSignInScreen.value.text.length<10){
                  //     Constant.showToastTop("Please enter vailid mobile number");
                  //   }else{
                  //     print(controller.mobileControllerSignInScreen.value.text);
                  //     Get.to(()=> const otpVerifyScreen(),transition:Constant.transition,duration: const Duration(milliseconds: 300));
                  //   }
                  // }:(){},
                  child: Center(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      controller.updateProfileIsLoading.value
                          ? loadingButtonWidget()
                          : const Text(
                              "Update",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500),
                            ),
                    ],
                  ))),
            ],
          ),
        );
      },
    );
  }
}
