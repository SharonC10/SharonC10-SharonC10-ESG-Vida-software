import 'package:ESGVida/model/shopping.dart';
import 'package:ESGVida/provider/shopping/product.dart';
import 'package:get/get.dart';

class ProductListController extends GetxController {
  final _provider = Get.find<ProductProvider>();

  final isPageDataFirstLoading = false.obs;
  final isMorePageDataLoading = false.obs;
  final pageData = <ProductModel>[].obs;
  String _key = "";
  int _page = 1;
  bool hasNext = true;
  bool hasPrevious = false;
  Future<void> search({String key = ""}) async {
    //在key相等的时候，如果上一次找不到，会重新搜索
    if (_key == key && pageData.isNotEmpty) {
      return;
    }
    _page = 1;
    pageData.clear();
    _key = key;
    isPageDataFirstLoading.value = true;
    return _provider.list(page: _page, key: key).then((value) {
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
      isPageDataFirstLoading.value = false;
    });
  }

  Future<void> fetchMorePageData() async {
    if (!hasNext) {
      return;
    }
    isMorePageDataLoading.value = true;
    return _provider.list(page: _page, key: _key).then((value) {
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
      isMorePageDataLoading.value = false;
    });
  }
}
