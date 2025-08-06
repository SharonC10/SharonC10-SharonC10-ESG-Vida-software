import 'package:ESGVida/model/shopping.dart';
import 'package:ESGVida/provider/shopping/shop.dart';
import 'package:ESGVida/provider/shopping/product.dart';
import 'package:get/get.dart';

class ShopController extends GetxController {
  final int detailId;
  ShopController({required this.detailId});
  final _productProvider = Get.find<ProductProvider>();
  final _provider = Get.find<ShopProvider>();

  final isDetailLoading = false.obs;
  ShopModel? detail;
  Future<void> fetchDetail() async {
    isDetailLoading.value = true;
    return _provider.getById(detailId).then((value) {
      if (value.isFail) {
        return;
      }
      detail = value.data!;
    }).whenComplete(() {
      isDetailLoading.value = false;
    });
  }

  final isPageDataFirstLoading = false.obs;
  final isMorePageDataLoading = false.obs;
  final pageData = <ProductModel>[].obs;
  int _page = 1;
  bool hasNext = true;
  bool hasPrevious = false;

  Future<void> fetchMorePageData() async {
    if (_page == 1) {
      isPageDataFirstLoading.value = true;
    } else {
      isMorePageDataLoading.value = true;
    }
    return _productProvider
        .list(
      shopId: detailId,
      page: _page,
    )
        .then((value) {
      if (value.isFail) {
        return;
      }
      hasPrevious = value.data!.hasPrevious;
      hasNext = value.data!.hasNext;
      if (hasNext) {
        _page++;
      }
      if (value.data!.results.isNotEmpty) {
        pageData.addAll(value.data!.results);
      }
    }).whenComplete(() {
      if (isPageDataFirstLoading.value) {
        isPageDataFirstLoading.value = false;
      } else {
        isMorePageDataLoading.value = false;
      }
    });
  }
}
