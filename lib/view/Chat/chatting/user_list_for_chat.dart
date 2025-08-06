import 'package:ESGVida/view/Chat/controller.dart';
import 'package:ESGVida/view/Chat/chatting/screen.dart';

import 'package:ESGVida/pkg/ext.dart';
import 'package:ESGVida/pkg/style_color.dart';
import 'package:ESGVida/widgets/cacheable_image.dart';
import 'package:ESGVida/widgets/loadings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:ESGVida/pkg/language.dart';

class UserListforChat extends StatelessWidget {
  const UserListforChat({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX<ChatScreenController>(
      init: ChatScreenController(),
      initState: (v) {
        v.controller!.getAllUser();
      },
      builder: (controller) {
        print(controller.controllername.value);
        return Scaffold(
            appBar: AppBar(
              backgroundColor: CommonColor.primaryColor,
              automaticallyImplyLeading: true,
              titleSpacing: 0,
              iconTheme: const IconThemeData(color: Colors.white),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "New ${LanguageGlobalVar.Chat.tr}",
                    style: CommonStyle.white22Medium,
                  ),
                  40.width,
                ],
              ),
              centerTitle: true,
            ),
            body: Container(
              margin: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  20.height,
                  controller.isLoadUserList.value
                      ? loadingWidget()
                      : controller.allUserData.isEmpty
                          ? const Padding(
                              padding: EdgeInsets.only(top: 200),
                              child: Text(
                                "User Not Found!",
                                style: CommonStyle.grey14Medium,
                              ),
                            )
                          : Flexible(
                              child: ListView.builder(
                                itemCount: controller.allUserData.length,
                                itemBuilder: (context, index) {
                                  var data = controller.allUserData[index];
                                  return InkWell(
                                    onTap: () {
                                      Get.to(() => ChatPage(
                                            UserName: data.firstName.toString(),
                                            UserId: data.id.toString(),
                                          ));
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10.0, horizontal: 7),
                                      margin: const EdgeInsets.only(bottom: 8),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(7),
                                          boxShadow: [
                                            BoxShadow(
                                                color: CommonColor.primaryColor
                                                    .withOpacity(0.1),
                                                offset: const Offset(0, 1),
                                                spreadRadius: 1,
                                                blurRadius: 0.2),
                                          ],
                                          color: Colors.white),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10, right: 10),
                                            child: CommonChacheImage(
                                                imgHeight: 55,
                                                imgWidth: 55,
                                                url: "${data.profileImage}",
                                                shape: BoxShape.circle),
                                          ),

                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                '${data.firstName} ${data.lastName}',
                                                style:
                                                    CommonStyle.black16Medium,
                                              ),
                                              Text(
                                                '${data.email}',
                                                style: CommonStyle.black14Light,
                                              ),
                                            ],
                                          ),
                                          const Spacer(),

                                          // Text(_currentTime,style: CommonStyle.black14Medium,),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            )
                ],
              ),
            ));
      },
    );
  }
}
