import 'package:ESGVida/model/shopping.dart';
import 'package:ESGVida/provider/shopping/shop.dart';
import 'package:ESGVida/provider/shopping/product.dart';
import 'package:get/get.dart';

class ShoppingController extends GetxController {
  final shopProvider = Get.find<ShopProvider>();
  final productProvider = Get.find<ProductProvider>();

  final isHotShopLoading = false.obs;
  final hotShopList = <ShopModel>[].obs;

  Future<void> fetchHotShop() async {
    isHotShopLoading.value = true;
    return shopProvider.hot().then((value) {
      if (value.isFail) {
        return;
      }
      hotShopList.value = value.data!;
    }).whenComplete(() {
      isHotShopLoading.value = false;
    });
  }

  final isHotProductLoading = false.obs;
  final hotProductList = <ProductModel>[].obs;

  Future<void> fetchHotProduct() async {
    isHotProductLoading.value = true;
    return productProvider.hot().then((value) {
      if (value.isFail) {
        return;
      }
      hotProductList.value = value.data!;
    }).whenComplete(() {
      isHotProductLoading.value = false;
    });
  }
}
