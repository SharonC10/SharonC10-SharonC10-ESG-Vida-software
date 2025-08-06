import 'package:ESGVida/model/shopping.dart';
import 'package:ESGVida/provider/shopping/shoppingcart.dart';
import 'package:get/get.dart';

class ShoppingCartController extends GetxController {
  final _provider = Get.find<ShoppingCartProvider>();

  @override
  void onInit() {
    fetchMorePageData();
    super.onInit();
  }

  final isPageDataFirstLoading = true.obs;
  final isMorePageDataLoading = false.obs;
  final pageData = <ShoppingCartItemModel>[].obs;
  int _page = 1;
  bool hasNext = true;
  bool hasPrevious = false;

  Future<void> fetchMorePageData() async {
    if (_page == 1) {
      isPageDataFirstLoading.value = true;
    } else {
      isMorePageDataLoading.value = true;
    }
    return _provider
        .list(
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

  Future<void> remove(int id) async {
    await _provider.remove(id).then((_) {
      pageData.removeWhere((e) => e.id == id);
    });
  }

  Future<void> changeAmount(int id, int amount) async {
    await _provider
        .changeAmount(
      cartItemId: id,
      amount: amount,
    )
        .then((_) {
      final index = pageData.indexWhere((e) => e.id == id);
      pageData[index] = pageData[index].copyWith(amount: amount);
    });
  }

  // final totalPrice = 0.0.obs;
  final selectedCartItems = <ShoppingCartItemModel>[].obs;
  void addSelectedCartItem(int cartItemId, bool isSelected) {
    if (isSelected) {
      final exists =
          selectedCartItems.firstWhereOrNull((e) => e.id == cartItemId);
      if (exists == null) {
        final newItem = pageData.firstWhere((e) => e.id == cartItemId);
        selectedCartItems.add(newItem);
        // totalPrice.value +=
        //     newItem.amount! * double.parse(newItem.product!.price!);
      }
    } else {
      final index = selectedCartItems.indexWhere((e) => e.id! == cartItemId);
      if (index == -1) {
        return;
      }
      // final removedItem = selectedCartItems[index];
      // totalPrice.value +=
      //     removedItem.amount! * double.parse(removedItem.product!.price!);
      selectedCartItems.removeAt(index);
    }
  }

  final isSelectAll = false.obs;
}
