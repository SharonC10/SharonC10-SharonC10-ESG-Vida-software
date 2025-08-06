import 'dart:io';

import 'package:ESGVida/pkg/constants/common.dart';
import 'package:ESGVida/pkg/toast.dart';
import 'package:ESGVida/pkg/utils/file.dart';
import 'package:ESGVida/pkg/language.dart';

import 'package:ESGVida/pkg/ext.dart';
import 'package:ESGVida/pkg/style_color.dart';
import 'package:ESGVida/widgets/common_appbar.dart';
import 'package:ESGVida/widgets/loadings.dart';
import 'package:ESGVida/widgets/video_thumbnail.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import 'controller.dart';

class ProductAddScreen extends StatelessWidget {
  const ProductAddScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GetX<ProductAddController>(
      init: ProductAddController(),
      initState: (state) {
        state.controller!.selectedPrice.value =
            state.controller!.priceList.first;
      },
      builder: (controller) {
        return Scaffold(
          appBar: CommonAppbarInside(
            context,
            title:
                '${LanguageGlobalVar.Product.tr} ${LanguageGlobalVar.Listing.tr}',
          ),
          body: ListView(
            shrinkWrap: true,
            physics: const ScrollPhysics(),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(
                  vertical: 15,
                  horizontal: 15,
                ),
                child: Form(
                  key: controller.productListingFormKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "${LanguageGlobalVar.Select.tr} ${LanguageGlobalVar.Media.tr}",
                            style: CommonStyle.black18Bold,
                          ),
                          10.width,
                          Container(
                            padding: const EdgeInsets.all(3),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: CommonColor.blueAccent,
                            ),
                            child: Text(
                              '${controller.selectedImages.length}',
                              style: CommonStyle.white12Light,
                            ),
                          ),
                        ],
                      ),
                      15.height,
                      SizedBox(
                        height: 80,
                        width: size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Flexible(
                              // height: 80,
                              //width: controller.selectedImages.isEmpty?0:width*0.69,
                              child: Scrollbar(
                                controller:
                                    controller.scrollbarController.value,
                                trackVisibility: true,
                                interactive: true,
                                thickness: 4,
                                child: ListView.builder(
                                  controller:
                                      controller.scrollbarController.value,
                                  shrinkWrap: true,
                                  physics: const ScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  itemCount: controller.selectedImages.length,
                                  itemBuilder: (context, index) {
                                    var data = controller.selectedImages[index];
                                    if (data.path.toString().split('.').last ==
                                        'mp4') {
                                      return Stack(
                                        children: [
                                          Container(
                                            height: 80,
                                            width: 75,
                                            margin: const EdgeInsets.only(
                                                right: 10),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              border: Border.all(
                                                color: CommonColor.greyColor,
                                                width: 0.5,
                                              ),
                                              boxShadow: [
                                                BoxShadow(
                                                  offset: const Offset(0, 0.3),
                                                  spreadRadius: 0.5,
                                                  color: CommonColor.greyColor
                                                      .withOpacity(0.4),
                                                ),
                                              ],
                                              //image: DecorationImage(image:MemoryImage()),
                                            ),
                                            child: VideoThumbnailWidget(
                                              videoPath: data.path,
                                            ),
                                          ),
                                          const Positioned(
                                            top: 0,
                                            bottom: 0,
                                            left: 0,
                                            right: 0,
                                            child: Icon(
                                              Icons.play_arrow,
                                              size: 24,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      );
                                    } else {
                                      return Container(
                                        height: 80,
                                        width: 75,
                                        margin:
                                            const EdgeInsets.only(right: 10),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          boxShadow: [
                                            BoxShadow(
                                              offset: const Offset(0, 0.1),
                                              spreadRadius: 1,
                                              color: CommonColor.greyColor
                                                  .withOpacity(0.3),
                                            ),
                                          ],
                                          border: Border.all(
                                            color: CommonColor.greyColor,
                                            width: 0.5,
                                          ),
                                          image: DecorationImage(
                                            image: FileImage(
                                              data,
                                            ),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                _selectFiles(controller);
                              },
                              child: Container(
                                margin: EdgeInsets.zero,
                                padding: EdgeInsets.zero,
                                height: 80,
                                width: 80,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    width: 0.5,
                                    color: CommonColor.greyColor,
                                  ),
                                ),
                                child: const Icon(
                                  Icons.add,
                                  color: Colors.black,
                                  size: 24,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      15.height,
                      Text(
                        "${LanguageGlobalVar.Product.tr} ${LanguageGlobalVar.Name.tr}",
                        style: CommonStyle.black18Bold,
                      ),
                      15.height,
                      TextFormField(
                        controller: controller.productNameController,
                        validator: (value) {
                          if (value!.isEmpty || value == "") {
                            return "${LanguageGlobalVar.Enter.tr} ${LanguageGlobalVar.Product.tr} ${LanguageGlobalVar.Name.tr}";
                          }
                          return null;
                        },
                        maxLength: 100,
                      ),
                      15.height,
                      Text(
                        LanguageGlobalVar.Description.tr,
                        style: CommonStyle.black18Bold,
                      ),
                      15.height,
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1,
                            color: CommonColor.greyColor,
                          ),
                        ),
                        child: TextFormField(
                          maxLines: 10,
                          maxLength: 300,
                          autofocus: false,
                          controller: controller.productDescriptionController,
                          style: CommonStyle.black14Light,
                          decoration: const InputDecoration(
                            alignLabelWithHint: true,
                            border: InputBorder.none,
                            filled: true,
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 5,
                              horizontal: 5,
                            ),
                            fillColor: Colors.transparent,
                            //  hintText: "Enter new confirm password",
                            hintStyle: CommonStyle.black14Light,
                          ),
                        ),
                      ),
                      15.height,
                      Text(
                        LanguageGlobalVar.Price.tr,
                        style: CommonStyle.black18Bold,
                      ),
                      10.height,
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            10.width,
                            DropdownButtonHideUnderline(
                              child: DropdownButton2(
                                isExpanded: true,
                                items: controller.priceList
                                    .map((item) => DropdownMenuItem(
                                          value: item,
                                          enabled: true,
                                          child: Text(
                                            item,
                                            style: CommonStyle.red22Bold,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ))
                                    .toList(),
                                value: controller.selectedPrice.value == ""
                                    ? null
                                    : controller.selectedPrice.value,
                                onChanged: (newValue) {
                                  controller.selectedPrice.value =
                                      newValue.toString();
                                },
                                iconStyleData: const IconStyleData(
                                  icon: Padding(
                                    padding: EdgeInsets.only(right: 0.0),
                                    child: Icon(
                                      Icons.keyboard_arrow_down_sharp,
                                    ),
                                  ),
                                  iconSize: 20,
                                  iconEnabledColor: Colors.grey,
                                  iconDisabledColor: Colors.grey,
                                ),
                                buttonStyleData: ButtonStyleData(
                                  height: 35,
                                  width: size.width * 0.25,
                                  padding: const EdgeInsets.only(
                                    left: 10,
                                    right: 3,
                                  ),
                                  overlayColor: WidgetStateProperty.all(
                                    Colors.transparent,
                                  ),
                                ),
                                menuItemStyleData: MenuItemStyleData(
                                  height: 40,
                                  selectedMenuItemBuilder: (context, child) {
                                    return Container(
                                      padding: const EdgeInsets.only(
                                        left: 0,
                                        right: 0,
                                      ),
                                      margin: const EdgeInsets.symmetric(
                                        horizontal: 1,
                                        vertical: 1,
                                      ),
                                      width: size.width * 0.25,
                                      height: 40,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          child,
                                          const Padding(
                                            padding:
                                                EdgeInsets.only(right: 5.0),
                                            child: Icon(
                                              Icons.done,
                                              color: Colors.red,
                                              size: 20,
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                  padding: const EdgeInsets.only(
                                    left: 8,
                                    right: 3,
                                  ),
                                ),
                                dropdownStyleData: DropdownStyleData(
                                  maxHeight: 200,
                                  padding: const EdgeInsets.only(
                                    left: 0,
                                    right: 0,
                                  ),
                                  width: size.width * 0.25,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.white,
                                    border: Border.all(
                                      color: CommonColor.greyColor,
                                      width: 1,
                                    ),
                                  ),
                                  elevation: 1,
                                  scrollbarTheme: ScrollbarThemeData(
                                    radius: const Radius.circular(20),
                                    thickness: WidgetStateProperty.all(5.0),
                                    minThumbLength: 20,
                                  ),
                                  offset: const Offset(0, -5),
                                ),
                                style: CommonStyle.red22Bold,
                              ),
                            ),
                            10.width,
                            Flexible(
                              child: TextFormField(
                                controller: controller.productPriceController,
                                keyboardType: TextInputType.number,
                                style: CommonStyle.red22Bold,
                                decoration: InputDecoration(
                                  isDense: true,
                                  border: InputBorder.none,
                                  hintText:
                                      '${LanguageGlobalVar.Enter.tr} ${LanguageGlobalVar.Price.tr}',
                                  hintStyle: CommonStyle.grey22light,
                                  alignLabelWithHint: true,
                                ),
                                validator: (value) {
                                  if (value!.isEmpty || value == "") {
                                    return '${LanguageGlobalVar.Please.tr} ${LanguageGlobalVar.Enter.tr} ${LanguageGlobalVar.Price.tr}';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          extendBody: true,
          bottomNavigationBar: BottomAppBar(
            padding: EdgeInsets.zero,
            height: 55,
            child: MaterialButton(
              onPressed: () async {
                controller.addProduct();
              },
              color: Colors.green,
              // minWidth: double.infinity,
              height: 40,
              elevation: 5,
              //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
              child: Center(
                child: controller.isAddProductLoading.value
                    ? loadingButtonWidget()
                    : Text(
                        LanguageGlobalVar.Submit.tr,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _selectFiles(ProductAddController controller) async {
    final ImagePicker picker = ImagePicker();
    await Get.defaultDialog(
      title: LanguageGlobalVar.SELECT_FILE.tr,
      content: Column(
        children: [
          ElevatedButton(
            onPressed: () async {
              final XFile? pickedFile = await picker.pickImage(
                source: ImageSource.gallery,
              );
              if (pickedFile != null) {
                controller.selectedImages.add(File(pickedFile.path));
              }
              Get.back(); // Close the dialog
            },
            child: Text(
              LanguageGlobalVar.SELECT_IMAGE.tr,
              style: CommonStyle.black12Medium,
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              final XFile? pickedFile =
                  await picker.pickVideo(source: ImageSource.gallery);
              if (pickedFile == null) {
                Get.back();
                return;
              }
              if (!FileUtils.isSupport(
                  CommonConstant.SUPPORT_EXT_LIST, pickedFile.path)) {
                showToast("${LanguageGlobalVar.ONLY_SUPPORT.tr}"
                    " ${CommonConstant.SUPPORT_EXT_LIST}"
                    ", ${LanguageGlobalVar.NO_SUPPORT_FILE_TYPE.tr}"
                    " ${FileUtils.filext(pickedFile.path)}");
              }
              controller.selectedImages.add(File(pickedFile.path));
              if (controller.selectedCoverPath.value.isEmpty) {
                if (FileUtils.isSupport(
                    CommonConstant.SUPPORTED_VIDEO, pickedFile.path)) {
                  final path = await _generateThumbnail(pickedFile.path);
                  if (path != null) {
                    controller.selectedCoverPath.value = path;
                  }
                } else {
                  controller.selectedCoverPath.value = pickedFile.path;
                }
              }
              Get.back(); // Close the dialog
            },
            child: Text(
              LanguageGlobalVar.SELECT_VIDEO.tr,
              style: CommonStyle.black12Medium,
            ),
          ),
        ],
      ),
    );
  }

  Future<String?> _generateThumbnail(String videoPath) async {
    final tempDir = await getTemporaryDirectory();
    return await VideoThumbnail.thumbnailFile(
      video: videoPath,
      thumbnailPath: tempDir.path,
      imageFormat: ImageFormat.JPEG,
      maxWidth: 128,
      quality: 25,
    );
  }
}
