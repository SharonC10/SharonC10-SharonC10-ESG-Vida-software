import 'package:ESGVida/model/shopping.dart';
import 'package:ESGVida/provider/shopping/product.dart';

import 'package:get/get.dart';

class ProductCommentListController extends GetxController {
  final int detailId;
  ProductCommentListController({required this.detailId});
  final _provider = Get.find<ProductProvider>();

  final isPageDataFirstLoading = false.obs;
  final isMorePageDataLoading = false.obs;
  final pageData = <ProductCommentModel>[].obs;
  int _page = 1;
  bool hasNext = true;
  bool hasPrevious = false;
  Future<void> fetchMorePageData() async {
    if (!hasNext) {
      return;
    }
    if (_page == 1) {
      isPageDataFirstLoading.value = true;
    } else {
      isMorePageDataLoading.value = true;
    }
    return _provider
        .listComment(page: _page, productId: detailId)
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
