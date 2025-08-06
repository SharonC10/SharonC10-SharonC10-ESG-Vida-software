import 'package:ESGVida/view/Chat/controller.dart';
import 'package:ESGVida/view/Chat/chatting/screen.dart';

import 'package:ESGVida/pkg/ext.dart';
import 'package:ESGVida/pkg/style_color.dart';
import 'package:ESGVida/widgets/cacheable_image.dart';
import 'package:ESGVida/widgets/loadings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:ESGVida/pkg/language.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX<ChatScreenController>(
      init: ChatScreenController(),
      initState: (v) {
        v.controller!.fetchChatThread();
      },
      builder: (controller) {
        print(controller.controllername.value);
        return Scaffold(
            appBar: AppBar(
              backgroundColor: CommonColor.primaryColor,
              automaticallyImplyLeading: false,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    "assets/images/appbarlogowhite.png",
                    height: 60,
                  ),
                  Text(
                    LanguageGlobalVar.Chat.tr,
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
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      10.width,
                      Stack(
                        children: [
                          Container(
                            height: 38,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 35, vertical: 0),
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      offset: const Offset(0, 4),
                                      color: Colors.grey.shade300,
                                      spreadRadius: 0.2,
                                      blurRadius: 0.2)
                                ],
                                color: const Color(0xFF0094EE),
                                borderRadius: BorderRadius.circular(5)),
                            child: Center(
                                child: Text(
                              LanguageGlobalVar.ALL.tr,
                              style: CommonStyle.white14Bold,
                            )),
                          ),
                        ],
                      ),
                      20.width,
                      Container(
                        height: 38,
                        padding:
                            const EdgeInsets.symmetric(horizontal: 30, vertical: 0),
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  offset: const Offset(0, 4),
                                  color: Colors.grey.shade300,
                                  spreadRadius: 0.2,
                                  blurRadius: 0.2)
                            ],
                            color: const Color(0xFFFC5549),
                            borderRadius: BorderRadius.circular(5)),
                        child: Center(
                            child: Text(
                          LanguageGlobalVar.LATEST.tr,
                          style: CommonStyle.white14Bold,
                        )),
                      ),
                      20.width,

                      // InkWell(child: Container(
                      //   height: 38,
                      //   padding: EdgeInsets.symmetric(horizontal: 30,vertical: 0),
                      //   decoration: BoxDecoration(
                      //       boxShadow: [
                      //         BoxShadow(
                      //             offset: Offset(0,4),
                      //             color: Colors.grey.shade300,
                      //             spreadRadius: 0.2,blurRadius: 0.2
                      //
                      //         )
                      //       ],
                      //       color:  Color(0xFF505050),
                      //       borderRadius: BorderRadius.circular(5)
                      //   ),
                      //   child:  Center(child: Text("${LanguageGlobalVar.SELF.tr}",style: CommonStyle.white14Bold,)),
                      // )),
                      // InkWell(
                      //   child: InkWell(
                      //     onTap: () {
                      //       Get.to(() => UserListforChat());
                      //     },
                      //     child: Container(
                      //       height: 38,
                      //       padding: EdgeInsets.symmetric(
                      //           horizontal: 5, vertical: 6),
                      //       decoration: BoxDecoration(
                      //           boxShadow: [
                      //             BoxShadow(
                      //                 offset: Offset(0, 3),
                      //                 color: Colors.grey.shade200,
                      //                 spreadRadius: 0.2,
                      //                 blurRadius: 0.2)
                      //           ],
                      //           color: Colors.white,
                      //           borderRadius: BorderRadius.circular(5)),
                      //       child: Icon(
                      //         Icons.add,
                      //         color: CommonColor.primaryColor,
                      //         size: 28,
                      //       ),
                      //     ),
                      //   ),
                      // )
                    ],
                  ),
                  20.height,
                  controller.isLoadUserThread.value
                      ? Padding(
                          padding: const EdgeInsets.only(top: 200),
                          child: loadingWidget(),
                        )
                      : controller.allUserThreadData.isEmpty
                          ? const Padding(
                              padding: EdgeInsets.only(top: 200),
                              child: Text(
                                "Chat Not Found!",
                                style: CommonStyle.grey14Medium,
                              ),
                            )
                          : Flexible(
                              child: ListView.builder(
                                itemCount: controller.allUserThreadData.length,
                                itemBuilder: (context, index) {
                                  var data =
                                      controller.allUserThreadData[index];
                                  return InkWell(
                                    onTap: () {
                                      Get.to(() => ChatPage(
                                            UserName: data.name.toString(),
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
                                          Container(
                                            alignment: Alignment.center,
                                            height: 15,
                                            width: 15,
                                            decoration: BoxDecoration(
                                                color: data.seen.toString() ==
                                                        "true"
                                                    ? const Color(0xFFFC5549)
                                                    : const Color(0xFF0094EE),
                                                borderRadius:
                                                    BorderRadius.circular(50)),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10, right: 10),
                                            child: CommonChacheImage(
                                                imgHeight: 55,
                                                imgWidth: 55,
                                                url: "${data.image}",
                                                shape: BoxShape.circle),
                                          ),

                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                '${data.name}',
                                                style:
                                                    CommonStyle.black16Medium,
                                              ),
                                              Text(
                                                '${data.email}',
                                                style: CommonStyle.black14Light,
                                              ),
                                            ],
                                          ),
                                          Expanded(
                                            child: Container(
                                              height: 50,
                                              alignment: Alignment.topRight,
                                              child: Text(
                                                "${data.latestMessageTimestamp?.toFriendlyDatetimeStr()}",
                                                style: CommonStyle.grey8Bold,
                                              ),
                                            ),
                                          ),
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
