import 'dart:io';
import 'package:ESGVida/pkg/inmemory_data.dart';
import 'package:ESGVida/pkg/toast.dart';
import 'package:ESGVida/screens/shopping/product/id/widgets/add_to_cart_dialog.dart';
import 'package:ESGVida/screens/shopping/widgets/purchase_dialog.dart';
import 'package:ESGVida/view/Chat/chatting/screen.dart';
import 'package:ESGVida/pkg/language.dart';
import 'package:ESGVida/pkg/ext.dart';
import 'package:ESGVida/pkg/style_color.dart';
import 'package:ESGVida/screens/shopping/product/id/controller.dart';
import 'package:ESGVida/widgets/loadings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

class ProductScreen extends StatelessWidget {
  final int id;

  const ProductScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return GetX<ProductController>(
      init: ProductController(detailId: id),
      initState: (state) {
        state.controller!.fetchDetail();
        state.controller!.fetchInteraction();
        state.controller!.fetchLatestComments();
      },
      builder: (controller) {
        return Scaffold(
          backgroundColor: const Color(0xFFF5F7FA),
          appBar: controller.currentPage.value.appBar != null
              ? controller.currentPage.value.appBar!()
              : AppBar(
                  elevation: 0,
                  toolbarHeight: 0,
                ),
          body: Obx(
            () => controller.currentPage.value.builder(),
          ),
          bottomSheet: Obx(() {
            if (controller.isDetailLoading.isTrue) {
              return Center(
                child: loadingWidget(),
              );
            }
            return Container(
              height: 55,
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: CommonColor.primaryColor.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 1,
                  ),
                ],
              ),
              width: size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Obx(
                    () => controller.isFavorOptLoading.isTrue ||
                            controller.isInteractionLoading.isTrue
                        ? loadingButtonWidget(
                            bgColor: const Color.fromARGB(255, 255, 230, 0),
                          )
                        : InkWell(
                            onTap: () {
                              controller.handlerFavor();
                            },
                            child: Icon(
                              controller.interaction?.isInWishlist == true
                                  ? Icons.star_rounded
                                  : Icons.star_border_rounded,
                              color: Colors.yellow,
                              size: 30,
                            ),
                          ),
                  ),
                  Obx(
                    () {
                      if (controller.isShareProductLoading.value) {
                        return loadingButtonWidget(bgColor: Colors.black);
                      }
                      return InkWell(
                        onTap: () {
                          _shareProduct(context, controller);
                        },
                        child: const Icon(
                          Icons.share,
                          color: Colors.black,
                          size: 24,
                        ),
                      );
                    },
                  ),
                  5.width,
                  // todo 不应该和用户聊天，而是和商家聊天，因为这个app同时是社交软件，用户可以是多个商家？
                  if (!GlobalInMemoryData.I
                      .isLoginUser(controller.detail.value!.shop!.user!.id))
                    ElevatedButton(
                      onPressed: () {
                        Get.to(
                          () => ChatPage(
                            UserName:
                                controller.detail.value!.shop!.user!.firstName!,
                            UserId: controller.detail.value!.shop!.user!.id
                                .toString(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(1),
                        backgroundColor: CommonColor.greyColor,
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      child: Text(
                        LanguageGlobalVar.Chat.tr,
                        style: CommonStyle.white16Medium,
                      ),
                    ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Flexible(
                          child: ElevatedButton.icon(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (ctx) {
                                  final product = controller.detail.value!;
                                  return PurchaseDialog(
                                    productPrice: double.parse(product.price!),
                                    productCurrencyCode: product.currencyCode!,
                                  );
                                },
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                              ),
                              backgroundColor: CommonColor.redColor,
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(3),
                              ),
                            ),
                            icon: const ImageIcon(
                              AssetImage("assets/images/shopping/pay.png"),
                              color: Colors.yellow,
                            ),
                            label: Text(
                              LanguageGlobalVar.BUY.tr,
                              style: CommonStyle.white18Bold,
                            ),
                          ),
                        ),
                        5.width,
                        ElevatedButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (ctx) {
                                return AddToCartDialog();
                              },
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(10),
                            backgroundColor: CommonColor.primaryColor,
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(3),
                            ),
                          ),
                          child: const Icon(
                            Icons.add_shopping_cart,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          }),
        );
      },
    );
  }

  void _shareProduct(BuildContext context, ProductController controller) {
    String message =
        "*${controller.detail.value!.name!.capitalizeFirst}*\n${controller.detail.value!.description!.capitalizeFirst}\n\n"
        "Download the app from Play Store by clicking the below link\n"
        "${Platform.isAndroid ? "https://play.google.com/store/apps/details?id=com.esgvida.social.apps" : "https://apps.apple.com/us/app/esgvida/id6504095654"}";
    final selectMediaUrl = controller.detail.value!
        .getMediaList()[controller.selectMediaIndex.value];
    controller.isShareProductLoading.value = true;
    Get.find<CacheManager>().getSingleFile(selectMediaUrl).then((value) {
      return Share.shareXFiles(
        [XFile(value.path)],
        text: message,
      );
    }).then((value) {
      if (value.status == ShareResultStatus.success) {
        controller.recordShare();
        showToast(LanguageGlobalVar.SHARE_SUCCESSFULLY.tr);
      } else if (value.status == ShareResultStatus.unavailable) {
        showToast("${LanguageGlobalVar.SHARE_FAILED.tr}[${value.status.name}]");
      }
    }).whenComplete(() {
      controller.isShareProductLoading.value = false;
    }).onError((error, stackTrace) {
      showToast(error.toString());
      print(stackTrace.toString());
    });
  }
}
