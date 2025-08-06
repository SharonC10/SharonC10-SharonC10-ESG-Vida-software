import 'dart:async';
import 'dart:io';

import 'package:ESGVida/screens/news/id/screen.dart';
import 'package:ESGVida/screens/news/list/screen.dart';
import 'package:ESGVida/view/main/bottom_nav_screen.dart';
import 'package:ESGVida/pkg/ext.dart';
import 'package:ESGVida/pkg/language.dart';
import 'package:ESGVida/pkg/style_color.dart';
import 'package:ESGVida/widgets/dialogs/notification_permission_dialog.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

import 'controller.dart';
import 'widgets/latest_news_loading.dart';
import 'widgets/news_preview.dart';
import 'widgets/post_feed/controller.dart';
import 'widgets/post_feed/screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return GetBuilder<HomeScreenController>(
      init: HomeScreenController(),
      initState: (value) {
        Get.put(PostFeedListController());
        _requireNotificationPermission(context);
      },
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: CommonColor.primaryColor,
            automaticallyImplyLeading: false,
            actions: [
              Container(
                width: size.width,
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset(
                      'assets/images/appLogowhite.png',
                      height: 50,
                    ),
                    const Spacer(),
                    Image.asset(
                      'assets/new_logo.png',
                      height: 40,
                      fit: BoxFit.fill,
                    ),
                    5.width,
                    Text(
                      LanguageGlobalVar.ESG_Vida.tr,
                      style: CommonStyle.white20Medium,
                    )
                  ],
                ),
              )
            ],
          ),
          body: NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification notification) {
              if (Get.isRegistered<PostFeedListController>()) {
                Get.find<PostFeedListController>().onScrollEnd(notification);
              }
              return true;
            },
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  10.height,
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Row(
                          children: [
                            Image.asset(
                              "assets/images/newspaper.png",
                              height: 20,
                            ),
                            10.width,
                            Text(
                              LanguageGlobalVar.Latest_News.tr,
                              style: CommonStyle.secondary16Medium,
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Get.to(const NewsListScreen());
                        },
                        child: Text(
                          LanguageGlobalVar.More.tr,
                          style: CommonStyle.secondary16Medium,
                        ),
                      ),
                    ],
                  ),
                  Obx(() {
                    if (controller.latestNewsLoader.value) {
                      return const LatestNewsCarouselSliderLoading();
                    } else if (controller.latestNewsList.isEmpty) {
                      return const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "No Latest News Found",
                          style: CommonStyle.black16Regular,
                        ),
                      );
                    } else {
                      return CarouselSlider.builder(
                        itemCount: controller.latestNewsList.length,
                        itemBuilder: (context, index, realIndex) {
                          var data = controller.latestNewsList[index];
                          return InkWell(
                            onTap: () {
                              Get.to(() => NewsScreen(
                                    id: data.id!,
                                  ));
                            },
                            child: NewsFeedPreview(
                              data: data,
                            ),
                          );
                        },
                        options: CarouselOptions(
                          height: 150,
                          autoPlay:
                              controller.latestNewsList.isEmpty ? false : true,
                          disableCenter: true,
                          viewportFraction: 0.97,
                        ),
                      );
                    }
                  }),
                  10.height,
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 70, vertical: 5),
                    child: Divider(
                      height: 3,
                      thickness: 3,
                      color: CommonColor.secondaryColor,
                    ),
                  ),
                  10.height,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.add_to_queue_outlined,
                              color: CommonColor.blackColor,
                              size: 30,
                            ),
                            10.width,
                            Text(
                              LanguageGlobalVar.Reels_Sharing.tr,
                              style: CommonStyle.secondary16Medium,
                            )
                          ],
                        ),
                        InkWell(
                            onTap: () {
                              Get.offAll(() => DashBordScreen(
                                    selectedIndex: 2,
                                  ));
                            },
                            child: Text(
                              LanguageGlobalVar.ADD.tr,
                              style: CommonStyle.secondary14Medium,
                            ))
                      ],
                    ),
                  ),
                  15.height,
                  const PostFeedList(),
                  15.height,
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _requireNotificationPermission(BuildContext context) {
    Timer(const Duration(milliseconds: 1), () async {
      try {
        if (Platform.isAndroid) {
          await Permission.notification.isDenied.then((permission) async {
            if (permission) {
              Notification_permission_dialog(context).then((_) async {
                await Permission.notification.isGranted;
              });
            }
          });
        } else {
          var permissionNotificationStatus =
              await Permission.notification.status;

          if (!permissionNotificationStatus.isGranted) {
            Notification_permission_dialog(context).then((_) async {
              await Permission.notification.isGranted;
            });
          }
        }
      } catch (e) {
        print('error in catch init state $e');
      }
    });
  }
}
