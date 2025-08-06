import 'package:ESGVida/screens/shopping/wishlist/screen.dart';
import 'package:ESGVida/pkg/ext.dart';
import 'package:ESGVida/pkg/language.dart';

import 'package:ESGVida/pkg/style_color.dart';
import 'package:ESGVida/screens/shopping/cart/screen.dart';
import 'package:ESGVida/view/Profile/controller.dart';
import 'package:ESGVida/widgets/shimmer/common_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../edit/screen.dart';
import 'widgets/order_nav.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final controller = Get.find<ProfileController>();
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 10, left: 10, top: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              5.width,
              controller.profileIsLoading.value
                  ? CommonShimmer(
                      childWidget: SizedBox(
                      width: size.width * 0.35,
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              Container(
                                height: 80,
                                width: 80,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                  boxShadow: const [
                                    BoxShadow(
                                      color: CommonColor.whiteColor,
                                      blurRadius: 1,
                                    )
                                  ],
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      controller.userProfile.value,
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: InkWell(
                                  onTap: () {
                                    Get.to(() => EditProfileScreen(
                                          details: controller.profileData.value,
                                        ));
                                  },
                                  child: const CircleAvatar(
                                    radius: 12,
                                    backgroundColor: Colors.blue,
                                    child: Icon(
                                      Icons.edit,
                                      color: Colors.white,
                                      size: 15,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          10.height,
                          const Text(
                            'User Name',
                            style: CommonStyle.black14Bold,
                          ),
                        ],
                      ),
                    ))
                  : Flexible(
                      child: SizedBox(
                        width: size.width * 0.35,
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                Container(
                                  height: 80,
                                  width: 80,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                    boxShadow: const [
                                      BoxShadow(
                                        color: CommonColor.greyColor,
                                        blurRadius: 2,
                                      ),
                                    ],
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        controller.userProfile.value,
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: InkWell(
                                    onTap: () {
                                      Get.to(() => EditProfileScreen(
                                            details:
                                                controller.profileData.value,
                                          ));
                                    },
                                    child: const CircleAvatar(
                                      radius: 12,
                                      backgroundColor: Colors.blue,
                                      child: Icon(
                                        Icons.edit,
                                        color: Colors.white,
                                        size: 15,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            10.height,
                            Text(
                              '${controller.profileData.value.firstName ?? ""} ${controller.profileData.value.lastName ?? ""}',
                              style: CommonStyle.black14Bold,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ),
              5.width,
              Flexible(
                child: Text(
                  LanguageGlobalVar.GreatDayComes.tr,
                  style: CommonStyle.black18Medium,
                  overflow: TextOverflow.clip,
                  maxLines: 5,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: controller.profileData.value.profileImage == null ||
                        controller.profileData.value.profileImage!.isEmpty
                    ? Image.asset(
                        'assets/new_logo.png',
                        height: 90,
                        fit: BoxFit.fill,
                      )
                    : Image.asset(
                        'assets/new_logo.png',
                        height: 90,
                        fit: BoxFit.fill,
                      ),
              ),
            ],
          ),
        ),
        10.height,
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    Get.to(() => const ShoppingCartScreen());
                  },
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    alignment: Alignment.centerLeft,
                    height: 60,
                    width: MediaQuery.of(context).size.width,
                    color: const Color.fromRGBO(207, 19, 51, 1),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          LanguageGlobalVar.SHOPPING_CART.tr,
                          style: CommonStyle.white18Bold,
                        ),
                        Container(
                          alignment: Alignment.centerRight,
                          child: const Icon(
                            Icons.navigate_next,
                            color: Color.fromRGBO(255, 255, 179, 1),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const OrderNavBar(),
                const Divider(),
                InkWell(
                  onTap: () async {
                    Get.to(() => const WishListScreen());
                  },
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    alignment: Alignment.centerLeft,
                    height: 60,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.blue,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${LanguageGlobalVar.My.tr} ${LanguageGlobalVar.Sharing.tr} / ${LanguageGlobalVar.My.tr} ${LanguageGlobalVar.Favorites.tr}',
                          style: CommonStyle.white18Bold,
                        ),
                        const Icon(
                          Icons.navigate_next,
                          color: Color.fromARGB(255, 255, 255, 179),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
