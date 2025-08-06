import 'package:ESGVida/pkg/language.dart';

import 'package:ESGVida/pkg/ext.dart';
import 'package:ESGVida/pkg/style_color.dart';
import 'package:ESGVida/screens/shopping/product/id/controller.dart';
import 'package:ESGVida/widgets/loadings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

import 'widgets/latest_comment.dart';
import 'widgets/media_slider.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProductController>();
    final size = MediaQuery.sizeOf(context);
    return Obx(() {
      if (controller.isDetailLoading.isTrue) {
        Center(
          child: loadingWidget(),
        );
      }
      return Padding(
        // 防止底部被bottomsheet遮挡
        padding: const EdgeInsets.only(bottom: 55),
        child: ListView(
          shrinkWrap: true,
          physics: const ScrollPhysics(),
          children: [
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 5,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: CommonColor.primaryColor.withOpacity(0.03),
                    spreadRadius: 0.8,
                    blurRadius: 0.8,
                  ),
                ],
              ),
              width: size.width,
              child: ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                children: [
                  const MediaSlider(),
                  10.height,
                  // 商品名
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Text(
                            "${controller.detail.value!.name}",
                            style: CommonStyle.black24Bolt,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // 评分、评论数、商店名
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10.0,
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "${controller.detail.value!.rating} ",
                              style: CommonStyle.grey12Medium,
                            ),
                            RatingBarIndicator(
                              rating: double.parse(
                                controller.detail.value!.rating ?? "0",
                              ),
                              itemBuilder: (context, index) => const Icon(
                                Icons.star,
                                color: Colors.orange,
                              ),
                              itemCount: 5,
                              itemSize: 12.0,
                              direction: Axis.horizontal,
                            ),
                            Obx(
                              () => Text(
                                "(${controller.detail.value!.commentCount ?? 0})",
                                style: CommonStyle.grey12Medium,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Container(
                          alignment: Alignment.bottomLeft,
                          child: Row(
                            children: [
                              const Icon(
                                Icons.store,
                                color: Colors.grey,
                              ),
                              Text(
                                "${controller.detail.value!.shop!.name}",
                                style: CommonStyle.grey16Medium,
                                textAlign: TextAlign.left,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  // 配送费
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Row(
                      children: [
                        Text(
                          controller.detail.value!.currencyCode!,
                          style: CommonStyle.red22Bold,
                        ),
                        Text(
                          "${controller.detail.value!.price}",
                          style: CommonStyle.red22Bold,
                        ),
                        10.width,
                        // todo 一直免费配送？
                        Text(
                          LanguageGlobalVar.FREE_SHIPING.tr,
                          style: CommonStyle.grey14Medium,
                        ),
                      ],
                    ),
                  ),
                  //评论
                  const LatestComment(),
                  //商品描述
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10.0,
                    ),
                    child: Text(
                      LanguageGlobalVar.Description.tr,
                      maxLines: 1,
                      style: CommonStyle.blue20500,
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10.0,
                    ),
                    child: Text(
                      '${controller.detail.value!.description}',
                      style: CommonStyle.grey12Medium,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
