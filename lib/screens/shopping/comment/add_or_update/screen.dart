import 'package:ESGVida/model/shopping.dart';
import 'package:ESGVida/pkg/ext.dart';
import 'package:ESGVida/pkg/language.dart';
import 'package:ESGVida/pkg/style_color.dart';
import 'package:ESGVida/widgets/loadings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

import 'controller.dart';

class AddOrUpdateCommentScreen extends StatelessWidget {
  final int productId;
  final ProductCommentModel? data;

  String get _title => data != null
      ? LanguageGlobalVar.EDIT_COMMENT.tr
      : LanguageGlobalVar.ADD_COMMENT.tr;
  const AddOrUpdateCommentScreen({
    super.key,
    required this.productId,
    this.data,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return GetBuilder<AddOrUpdateCommentController>(
      init: AddOrUpdateCommentController(
        data: data,
        productId: productId,
      ),
      builder: (controller) {
        return Scaffold(
          backgroundColor: const Color(0xFFF5F7FA),
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
                InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: const Icon(
                    Icons.arrow_back_ios,
                    color: CommonColor.greyColor,
                    size: 21,
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  _title,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                )
              ],
            ),
          ),
          body: ListView(
            shrinkWrap: true,
            physics: const ScrollPhysics(),
            scrollDirection: Axis.vertical,
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 10,
            ),
            children: [
              10.height,
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 15,
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          LanguageGlobalVar.RATING.tr,
                        ),
                        Obx(
                          () => RatingBar.builder(
                            itemCount: 5,
                            minRating: 1,
                            initialRating: controller.rating.value,
                            //   initialRating: controller.addReviewRating.value,
                            itemSize: 30,
                            allowHalfRating: false,
                            itemBuilder: (context, index) => const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (value) {
                              controller.rating.value = value;
                            },
                          ),
                        ),
                        5.width,
                        Obx(
                          () => Text(
                            "(${controller.rating.value})",
                            style: CommonStyle.black18Medium,
                          ),
                        ),
                      ],
                    ),
                    8.height,
                    Text(
                      LanguageGlobalVar.COMMENT_CONTENT.tr,
                      style: CommonStyle.black14Medium,
                    ),
                    10.height,
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF5F7FA),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: CommonColor.primaryColor.withOpacity(
                              0.1,
                            ),
                            spreadRadius: 0.8,
                            blurRadius: 0.8,
                          ),
                        ],
                      ),
                      child: TextFormField(
                        minLines: 8,
                        maxLines: 15,
                        maxLength: 800,
                        controller: controller.content,
                        textCapitalization: TextCapitalization.sentences,
                        style: CommonStyle.black16Medium,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          fillColor: CommonColor.whiteColor,
                          filled: true,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              100.height
            ],
          ),
          bottomSheet: Stack(
            children: [
              Container(
                height: 75,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 15,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: CommonColor.primaryColor.withOpacity(
                        0.2,
                      ),
                      spreadRadius: 1,
                      blurRadius: 1,
                    ),
                  ],
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  onPressed: () {
                    controller.submitComment().then((_) {
                      Get.back(
                        result: data?.copyWith(
                          content: controller.content.text,
                          rating: controller.rating.value.toString(),
                        ),
                      );
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(
                      size.width,
                      40,
                    ),
                    backgroundColor: CommonColor.primaryColor,
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Obx(
                    () => controller.isSubmitCommentLoading.isTrue
                        ? loadingButtonWidget()
                        : Text(
                            _title,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
