import 'dart:io';

import 'package:ESGVida/pkg/constants/common.dart';
import 'package:ESGVida/pkg/inmemory_data.dart';
import 'package:ESGVida/screens/auth/signup/controller.dart';
import 'package:ESGVida/pkg/ext.dart';
import 'package:ESGVida/pkg/style_color.dart';
import 'package:ESGVida/widgets/loadings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';

class signUpScreen extends StatelessWidget {
  const signUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return GetX<SignUpController>(
      init: SignUpController(),
      initState: (state) {
        GlobalInMemoryData.I.obtainDeviceToken();
      },
      builder: (controller) {
        print(controller.controllerName.value);
        return Scaffold(
          backgroundColor: CommonColor.whiteColor,
          appBar: AppBar(
            title: const Text(
              "SignUp in ESG-Vida",
              style: CommonStyle.grey18Bold,
            ),
            leading: InkWell(
              onTap: () {
                Get.back();
              },
              child: const Icon(Icons.arrow_back),
            ),
            actions: [
              Image.asset(
                'assets/new_logo.png',
                height: 35,
                width: 35,
                fit: BoxFit.fill,
              ),
              15.width
            ],
          ),
          bottomNavigationBar: BottomAppBar(
            color: Colors.transparent,
            elevation: 0,
            padding: const EdgeInsets.only(right: 15, left: 15, bottom: 10, top: 10),
            height: 60,
            child: MaterialButton(
                onPressed: () {
                  controller.handlerSignup();
                  // Get.to(const LoginScreen());
                },
                color: controller.isCheckBoxDone.value == true
                    ? CommonColor.blueAccent
                    : Colors.grey.shade400,
                minWidth: double.infinity,
                height: 40,
                elevation: 5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100)),
                child: Center(
                    child: controller.signUpController.value == true
                        ? loadingButtonWidget()
                        : const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "SignUp",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.white,
                              )
                            ],
                          ))),
          ),
          body: SizedBox(
            width: width,
            height: height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Image.asset('assets/new_logo.png',height: 70,fit: BoxFit.fill,),
                // 10.height,
                // const Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   crossAxisAlignment: CrossAxisAlignment.center,
                //   children: [
                //     Text("Share your green\nLifestyle",textAlign: TextAlign.center,style: CommonStyle.forteStyleNew,),
                //   ],
                // ),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    physics: const ScrollPhysics(),
                    shrinkWrap: true,
                    children: [
                      20.height,
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () async {
                              final ImagePicker picker = ImagePicker();
                              final XFile? pickedFile = await picker.pickImage(
                                  source: ImageSource.gallery);
                              if (pickedFile != null) {
                                controller.profileImagePath.value =
                                    pickedFile.path.toString();
                              }
                            },
                            child: Stack(
                              children: [
                                Container(
                                    width: 100,
                                    height: 100,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: CommonColor.whiteColor,
                                        border: Border.all(
                                            color: CommonColor.blueAccent
                                                .withOpacity(0.5),
                                            width: 0.5),
                                        boxShadow: [
                                          BoxShadow(
                                              color: CommonColor.greyColor
                                                  .withOpacity(0.5),
                                              blurRadius: 2)
                                        ],
                                        image:
                                            controller.profileImagePath.value ==
                                                    ""
                                                ? null
                                                : DecorationImage(
                                                    image: FileImage(File(
                                                        controller.profileImagePath.value)),
                                                  )),
                                    child:
                                        controller.profileImagePath.value == ""
                                            ? const Icon(
                                                Icons.add_box,
                                                color: CommonColor.blueAccent,
                                              )
                                            : const SizedBox()),
                                Positioned(
                                    right: 0,
                                    bottom: 5,
                                    child:
                                        controller.profileImagePath.value == ""
                                            ? const SizedBox()
                                            : Container(
                                                padding: const EdgeInsets.all(3),
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: CommonColor.greyColor
                                                        .withOpacity(0.5)),
                                                child: const Icon(
                                                  Icons.edit,
                                                  color: CommonColor.whiteColor,
                                                  size: 20,
                                                )))
                              ],
                            ),
                          ),
                        ],
                      ),
                      20.height,
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Enter your Details below.",
                            style: CommonStyle.grey14Light,
                          ),
                        ],
                      ),
                      10.height,
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(
                              width: 0.4, color: CommonColor.blueAccent),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.7),
                              //  spreadRadius: 2,
                              blurRadius: 3,
                              //offset: const Offset(0, 2), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Flexible(
                              child: TextFormField(
                                keyboardType: TextInputType.text,
                                autofocus: false,
                                controller:
                                    controller.firstNameController.value,
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
                                validator: (value) {
                                  if (value!.isEmpty || value == "") {
                                    return "Please enter product name";
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      10.height,
                      Container(
                        //  height: 45,
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        // color: Colors.grey.shade300,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(
                              width: 0.4, color: CommonColor.blueAccent),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.7),
                              //  spreadRadius: 2,
                              blurRadius: 3,
                              //  offset: const Offset(0, 2), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Flexible(
                              child: TextFormField(
                                keyboardType: TextInputType.text,
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
                                validator: (value) {
                                  if (value!.isEmpty || value == "") {
                                    return "Please enter product name";
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      10.height,
                      Container(
                        //  height: 45,
                        padding: const EdgeInsets.symmetric(horizontal: 8),

                        // color: Colors.grey.shade300,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(
                              width: 0.4, color: CommonColor.blueAccent),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.7),
                              // spreadRadius: 2,
                              blurRadius: 3,
                              // offset: const Offset(0, 2), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Flexible(
                              child: TextFormField(
                                keyboardType: TextInputType.text,
                                autofocus: false,
                                controller: controller.emailIdController.value,
                                style: CommonStyle.black14Light,
                                inputFormatters: [
                                  FilteringTextInputFormatter.deny(
                                      RegExp(r'\s')),
                                ],
                                decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    counterText: "",
                                    filled: true,
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 1, horizontal: 5),
                                    fillColor: Colors.transparent,
                                    hintText: "Enter email-id",
                                    hintStyle: CommonStyle.grey14Light),
                                validator: (value) {
                                  if (value!.isEmpty || value == "") {
                                    return "Please enter product name";
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      10.height,
                      Container(
                        //  height: 45,
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        // color: Colors.grey.shade300,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(
                              width: 0.4, color: CommonColor.blueAccent),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.7),
                              // spreadRadius: 2,
                              blurRadius: 3,
                              //  offset: const Offset(0, 2), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Flexible(
                              child: TextFormField(
                                keyboardType: TextInputType.text,
                                autofocus: false,
                                inputFormatters: [
                                  FilteringTextInputFormatter.deny(
                                      RegExp(r'\s')),
                                ],
                                controller: controller.passwordController.value,
                                style: CommonStyle.black14Light,
                                obscureText: controller.obscureTextSignup.value,
                                decoration: InputDecoration(
                                    suffixIcon: Padding(
                                      padding: const EdgeInsets.only(right: 5),
                                      child: InkWell(
                                          onTap: () {
                                            controller.obscureTextSignup.value =
                                                !controller
                                                    .obscureTextSignup.value;
                                          },
                                          child: Icon(
                                            controller.obscureTextSignup.value
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
                                    hintText: "Enter password",
                                    hintStyle: CommonStyle.grey14Light),
                                validator: (value) {
                                  if (value!.isEmpty || value == "") {
                                    return "Please enter product name";
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      10.height,
                      Container(
                        //  height: 45,
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        // color: Colors.grey.shade300,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(
                              width: 0.4, color: CommonColor.blueAccent),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.7),
                              // spreadRadius: 2,
                              blurRadius: 3,
                              //  offset: const Offset(0, 2), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Flexible(
                              child: TextFormField(
                                autofocus: false,
                                controller:
                                    controller.confirmPasswordController.value,
                                style: CommonStyle.black14Light,
                                obscureText:
                                    controller.obscureTextSignupConfirm.value,
                                inputFormatters: [
                                  FilteringTextInputFormatter.deny(
                                      RegExp(r'\s')),
                                ],
                                decoration: InputDecoration(
                                    suffixIcon: Padding(
                                      padding: const EdgeInsets.only(right: 5),
                                      child: InkWell(
                                          onTap: () {
                                            controller.obscureTextSignupConfirm
                                                    .value =
                                                !controller
                                                    .obscureTextSignupConfirm
                                                    .value;
                                          },
                                          child: Icon(
                                            controller.obscureTextSignupConfirm
                                                    .value
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
                                    hintText: "Enter confirm password",
                                    hintStyle: CommonStyle.grey14Light),
                                validator: (value) {
                                  if (value!.isEmpty || value == "") {
                                    return "Please enter product name";
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      10.height,
                      const Text(
                        "Select gender",
                        style: CommonStyle.grey14Medium,
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
                                value: controller.genderList[0],
                                activeColor: CommonColor.blueAccent,
                                groupValue: controller.updateGender.value,
                                onChanged: (value) {
                                  controller.updateGender.value = value!;
                                },
                              ),
                            ),
                            const Text(
                              "Male",
                              style: CommonStyle.black14Medium,
                            ),
                            Radio(
                              visualDensity: VisualDensity.compact,
                              value: controller.genderList[1],
                              activeColor: CommonColor.blueAccent,
                              groupValue: controller.updateGender.value,
                              onChanged: (value) {
                                controller.updateGender.value = value!;
                              },
                            ),
                            const Text(
                              "Female",
                              style: CommonStyle.black14Medium,
                            ),
                            Radio(
                              visualDensity: VisualDensity.compact,
                              value: controller.genderList[2],
                              groupValue: controller.updateGender.value,
                              activeColor: CommonColor.blueAccent,
                              onChanged: (value) {
                                controller.updateGender.value = value!;
                              },
                            ),
                            const Text(
                              "Other",
                              style: CommonStyle.black14Medium,
                            ),
                          ],
                        ),
                      ),
                      10.height,
                      Container(
                        padding: EdgeInsets.zero,
                        margin: EdgeInsets.zero,
                        child: Row(
                          children: [
                            SizedBox(
                              height: 24,
                              width: 24,
                              child: Checkbox(
                                materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                                activeColor: CommonColor.blueAccent,
                                value: controller.isCheckBoxDone.value,
                                onChanged: (value) {
                                  controller.isCheckBoxDone.value = value!;
                                },
                              ),
                            ),
                            10.width,
                            const Text(
                              "I agree with ",
                              style: CommonStyle.grey14Medium,
                            ),
                            InkWell(
                                onTap: () {
                                  launchUrl(Uri.parse(
                                      "${CommonConstant.BE_BASE_URL}/api/user/terms_and_conditions/"));
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //     builder: (context) => term_condition_webview(),
                                  //   ),
                                  // );
                                },
                                child: const Text(
                                  "T&C",
                                  style: CommonStyle.blue14Regular,
                                ))
                          ],
                        ),
                      ),
                      10.height,
                    ],
                  ),
                )
              ],
            ),
          ),
          // bottomSheet: Container(
          //   height: MediaQuery.of(context).size.height * 0.62,
          //   decoration: BoxDecoration(
          //     color: Colors.white,
          //     borderRadius: const BorderRadius.only(
          //       topLeft: Radius.circular(20),
          //       topRight: Radius.circular(20),
          //     ),
          //     boxShadow: [
          //       BoxShadow(
          //         color: Colors.grey.withOpacity(0.2),
          //         spreadRadius: 2,
          //         blurRadius: 5,
          //         offset: const Offset(0, 2), // changes position of shadow
          //       ),
          //     ],
          //   ),
          //   child: ListView(
          //     padding: const EdgeInsets.only(left: 15, right: 15),
          //     physics: const ScrollPhysics(),
          //     shrinkWrap: true,
          //     children: [
          //       20.height,
          //       Row(
          //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //         children: [
          //           Column(
          //           crossAxisAlignment: CrossAxisAlignment.start,
          //           children: [
          //             const Text("SignUp in ESG-Vida",style:CommonStyle.grey18Bold,),
          //             const Text("Enter your Details below.", style: CommonStyle.grey14Light,),
          //           ],
          //         ),
          //           InkWell(
          //             onTap: () async{
          //               final ImagePicker _picker = ImagePicker();
          //               final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
          //               if (pickedFile != null) {
          //                 controller.profileImagePath.value = pickedFile.path.toString();
          //               }
          //             },
          //             child: Container(
          //               width: 50,
          //               height: 50,
          //               child: controller.profileImagePath.value==""?Icon(Icons.add_box,color: Colors.black,):Image(image: FileImage(File("${controller.profileImagePath.value}")),fit: BoxFit.fill,),
          //             ),
          //           )
          //         ],
          //       ),
          //       8.height,
          //       Container(
          //         padding: const EdgeInsets.symmetric(horizontal: 8),
          //         decoration: BoxDecoration(
          //           color: Colors.white,
          //           borderRadius: BorderRadius.circular(25),
          //           border: Border.all(width: 0.4, color: CommonColor.blueAccent),
          //           boxShadow: [
          //             BoxShadow(
          //               color: Colors.grey.withOpacity(0.2),
          //               spreadRadius: 2,
          //               blurRadius: 5,
          //               offset: const Offset(0, 2), // changes position of shadow
          //             ),
          //           ],
          //         ),
          //         child: Row(
          //           crossAxisAlignment: CrossAxisAlignment.center,
          //           children: [
          //             Flexible(
          //               child: TextFormField(
          //                 keyboardType: TextInputType.text,
          //                 autofocus: false,
          //                 controller: controller.firstNameController.value,
          //                 style: CommonStyle.black14Light,
          //                 decoration: const InputDecoration(
          //                     border: InputBorder.none,
          //                     counterText: "",
          //                     filled: true,
          //                     contentPadding: EdgeInsets.symmetric(vertical: 1,horizontal: 5),
          //                     fillColor: Colors.transparent,
          //                     hintText: "First name",
          //                     hintStyle: CommonStyle.grey14Light),
          //                 validator: (value) {
          //                   if(value!.isEmpty || value==null || value==""){
          //                     return  "Please enter product name";
          //                   }
          //                   return null;
          //                 },
          //               ),
          //             ),
          //           ],
          //         ),
          //       ),
          //       8.height,
          //       Container(
          //         //  height: 45,
          //         padding: const EdgeInsets.symmetric(horizontal: 8),
          //         // color: Colors.grey.shade300,
          //         decoration: BoxDecoration(
          //           color: Colors.white,
          //           borderRadius: BorderRadius.circular(25),
          //           border: Border.all(width: 0.4, color: CommonColor.blueAccent),
          //           boxShadow: [
          //             BoxShadow(
          //               color: Colors.grey.withOpacity(0.2),
          //               spreadRadius: 2,
          //               blurRadius: 5,
          //               offset: const Offset(0, 2), // changes position of shadow
          //             ),
          //           ],
          //         ),
          //         child: Row(
          //           crossAxisAlignment: CrossAxisAlignment.center,
          //           children: [
          //             Flexible(
          //               child: TextFormField(
          //                 keyboardType: TextInputType.text,
          //                 autofocus: false,
          //                 controller: controller.lastNameController.value,
          //                 style: CommonStyle.black14Light,
          //                 decoration: const InputDecoration(
          //                     border: InputBorder.none,
          //                     counterText: "",
          //                     filled: true,
          //                     contentPadding: EdgeInsets.symmetric(vertical: 1,horizontal: 5),
          //                     fillColor: Colors.transparent,
          //                     hintText: "Last name",
          //                     hintStyle: CommonStyle.grey14Light
          //                 ),
          //                 validator: (value) {
          //                   if(value!.isEmpty || value==null || value==""){
          //                     return  "Please enter product name";
          //                   }
          //                   return null;
          //                 },
          //               ),
          //             ),
          //           ],
          //         ),
          //       ),
          //       8.height,
          //       Container(
          //         //  height: 45,
          //         padding: const EdgeInsets.symmetric(horizontal: 8),
          //         // color: Colors.grey.shade300,
          //         decoration: BoxDecoration(
          //           color: Colors.white,
          //           borderRadius: BorderRadius.circular(25),
          //           border: Border.all(width: 0.4, color: CommonColor.blueAccent),
          //           boxShadow: [
          //             BoxShadow(
          //               color: Colors.grey.withOpacity(0.2),
          //               spreadRadius: 2,
          //               blurRadius: 5,
          //               offset: const Offset(0, 2), // changes position of shadow
          //             ),
          //           ],
          //         ),
          //         child: Row(
          //           crossAxisAlignment: CrossAxisAlignment.center,
          //           children: [
          //             Flexible(
          //               child: TextFormField(
          //                 keyboardType: TextInputType.text,
          //                 autofocus: false,
          //                 controller: controller.emailIdController.value,
          //                 style: CommonStyle.black14Light,
          //                 decoration: const InputDecoration(
          //                     border: InputBorder.none,
          //                     counterText: "",
          //                     filled: true,
          //                     contentPadding: EdgeInsets.symmetric(vertical: 1,horizontal: 5),
          //                     fillColor: Colors.transparent,
          //                     hintText: "Enter email-id",
          //                     hintStyle: CommonStyle.grey14Light
          //                 ),
          //                 validator: (value) {
          //                   if(value!.isEmpty || value==null || value==""){
          //                     return  "Please enter product name";
          //                   }
          //                   return null;
          //                 },
          //               ),
          //             ),
          //           ],
          //         ),
          //       ),
          //       8.height,
          //       Container(
          //         //  height: 45,
          //         padding: const EdgeInsets.symmetric(horizontal: 8),
          //         // color: Colors.grey.shade300,
          //         decoration: BoxDecoration(
          //           color: Colors.white,
          //           borderRadius: BorderRadius.circular(25),
          //           border: Border.all(width: 0.4, color: CommonColor.blueAccent),
          //           boxShadow: [
          //             BoxShadow(
          //               color: Colors.grey.withOpacity(0.2),
          //               spreadRadius: 2,
          //               blurRadius: 5,
          //               offset: const Offset(0, 2), // changes position of shadow
          //             ),
          //           ],
          //         ),
          //         child: Row(
          //           crossAxisAlignment: CrossAxisAlignment.center,
          //           children: [
          //             Flexible(
          //               child: TextFormField(
          //                 keyboardType: TextInputType.text,
          //                 autofocus: false,
          //                 controller: controller.passwordController.value,
          //                 style: CommonStyle.black14Light,
          //                 decoration: const InputDecoration(
          //                     border: InputBorder.none,
          //                     counterText: "",
          //                     filled: true,
          //                     contentPadding: EdgeInsets.symmetric(vertical: 1,horizontal: 5),
          //                     fillColor: Colors.transparent,
          //                     hintText: "Enter password",
          //                     hintStyle: CommonStyle.grey14Light
          //                 ),
          //                 validator: (value) {
          //                   if(value!.isEmpty || value==null || value==""){
          //                     return  "Please enter product name";
          //                   }
          //                   return null;
          //                 },
          //               ),
          //             ),
          //           ],
          //         ),
          //       ),
          //       8.height,
          //       Container(
          //         //  height: 45,
          //         padding: const EdgeInsets.symmetric(horizontal: 8),
          //         // color: Colors.grey.shade300,
          //         decoration: BoxDecoration(
          //           color: Colors.white,
          //           borderRadius: BorderRadius.circular(25),
          //           border: Border.all(width: 0.4, color: CommonColor.blueAccent),
          //           boxShadow: [
          //             BoxShadow(
          //               color: Colors.grey.withOpacity(0.2),
          //               spreadRadius: 2,
          //               blurRadius: 5,
          //               offset: const Offset(0, 2), // changes position of shadow
          //             ),
          //           ],
          //         ),
          //         child: Row(
          //           crossAxisAlignment: CrossAxisAlignment.center,
          //           children: [
          //             Flexible(
          //               child: TextFormField(
          //                 autofocus: false,
          //                 controller: controller.confirmPasswordController.value,
          //                 style: CommonStyle.black14Light,
          //                 decoration: const InputDecoration(
          //                     border: InputBorder.none,
          //                     counterText: "",
          //                     filled: true,
          //                     contentPadding: EdgeInsets.symmetric(vertical: 1,horizontal: 5),
          //                     fillColor: Colors.transparent,
          //                     hintText: "Enter confirm password",
          //                     hintStyle: CommonStyle.grey14Light
          //                 ),
          //                 validator: (value) {
          //                   if(value!.isEmpty || value==null || value==""){
          //                     return  "Please enter product name";
          //                   }
          //                   return null;
          //                 },
          //               ),
          //             ),
          //           ],
          //         ),
          //       ),
          //       8.height,
          //       const Text("Select gender", style: CommonStyle.grey14Medium,),
          //       Container(
          //         child: Row(
          //           mainAxisAlignment: MainAxisAlignment.start,
          //           children: [
          //             SizedBox(
          //               height: 24,
          //               width: 24,
          //               child: Radio(
          //                 visualDensity: VisualDensity.compact,
          //                 value:controller.genderList[0],
          //                 activeColor: CommonColor.blueAccent,
          //                 groupValue:controller.updateGender.value,
          //                 onChanged: (value) {
          //                   controller.updateGender.value=value!;
          //                 },),
          //             ),
          //             const Text("Male",style: CommonStyle.black14Medium,),
          //             Radio(
          //               visualDensity: VisualDensity.compact,
          //               value:controller.genderList[1],
          //               activeColor: CommonColor.blueAccent,
          //               groupValue:controller.updateGender.value,
          //               onChanged: (value) {
          //                 controller.updateGender.value=value!;
          //               },),
          //             const Text("Female",style: CommonStyle.black14Medium,),
          //             Radio(
          //               visualDensity: VisualDensity.compact,
          //               value:controller.genderList[2],
          //               groupValue:controller.updateGender.value,
          //               activeColor: CommonColor.blueAccent,
          //               onChanged: (value) {
          //                 controller.updateGender.value=value!;
          //               },),
          //             const Text("Other",style: CommonStyle.black14Medium,),
          //           ],
          //         ),
          //       ),
          //       Container(
          //         padding: EdgeInsets.zero,
          //         margin: EdgeInsets.zero,
          //         child: Row(
          //           children: [
          //             Container(
          //               height: 24,
          //               width: 24,
          //               child: Checkbox(
          //                 materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          //                 activeColor: CommonColor.blueAccent,
          //                 value: controller.isCheckBoxDone.value,
          //                 onChanged: (value) {
          //                   controller.isCheckBoxDone.value=value!;
          //                 },),
          //             ),10.width,
          //              const Text("I agree with ",style: CommonStyle.grey14Medium,),
          //             InkWell(onTap:  () {
          //               Get.to(()=>const termsAndConditionsScreen(),);
          //             },child: const
          //             Text("T&C",style: CommonStyle.blue14Regular,))
          //           ],
          //         ),
          //       ),
          //       5.height,
          //       MaterialButton(
          //           onPressed: (){
          //             if(controller.firstNameController.value.text.isEmpty){
          //               showToast("Please enter first name");
          //             }else if(controller.lastNameController.value.text.isEmpty){
          //               showToast("Please enter last name");
          //             }else if(controller.emailIdController.value.text.isEmpty){
          //               showToast("Please enter emailId");
          //             }else if(controller.passwordController.value.text.isEmpty){
          //               showToast("Please enter password");
          //             }else if(controller.confirmPasswordController.value.text.isEmpty){
          //               showToast("Please enter confirm password");
          //             }else if(controller.passwordController.value.text.toString().trim()!=controller.confirmPasswordController.value.text.toString().trim()){
          //               showToast("password and confirm password not match");
          //             }else if(controller.updateGender.value==""){
          //               showToast("Please select gender");
          //             }else if(controller.isCheckBoxDone.value==false){
          //               showToast("Please select T&C");
          //             }else{
          //               controller.signUpApi();
          //             }
          //             // Get.to(const LoginScreen());
          //           },
          //           color: controller.isCheckBoxDone.value==true?CommonColor.blueAccent:Colors.grey.shade400,
          //           minWidth: double.infinity,
          //           height: 40,
          //           elevation: 5,
          //           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
          //           child:  Center(
          //               child: controller.signUpController.value==true?loadingButtonWidget():Row(
          //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //                 children: [
          //                   Text("SignUp", style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500),),
          //                   Icon(Icons.arrow_forward_ios, color: Colors.white,)
          //                 ],
          //               ))),
          //     ],
          //   ),
          // ),
        );
      },
    );
  }
}
