import 'package:ESGVida/model/shopping.dart';
import 'package:ESGVida/provider/shopping/product_order.dart';
import 'package:get/get.dart';

class ProductOrderController extends GetxController {
  ProductOrderController({ProductOrderStatus status = ProductOrderStatus.ALL}) {
    this.status.value = status;
  }
  final _provider = Get.find<ProductOrderProvider>();
  // todo 搜索, 订单页面顶部订单状态导航栏
  final Rx<ProductOrderStatus> status = ProductOrderStatus.ALL.obs;

  final isPageDataFirstLoading = false.obs;
  final isMorePageDataLoading = false.obs;
  final pageData = <ProductOrderModel>[].obs;
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
    return _provider
        .list(
      page: _page,
      key: key,
      status: status.value == ProductOrderStatus.ALL ? null : status.value,
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
      isPageDataFirstLoading.value = false;
    });
  }

  Future<void> fetchMorePageData() async {
    if (!hasNext) {
      return;
    }
    isMorePageDataLoading.value = true;
    return _provider
        .list(
      page: _page,
      key: _key,
      status: status.value == ProductOrderStatus.ALL ? null : status.value,
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
      isMorePageDataLoading.value = false;
    });
  }
}
