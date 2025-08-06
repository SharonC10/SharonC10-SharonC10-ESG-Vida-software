import 'package:ESGVida/model/wishlist.dart';
import 'package:ESGVida/provider/shopping/wishlist.dart';
import 'package:get/get.dart';

class WishListController extends GetxController {
  final _provider = Get.find<WishListProvider>();

  @override
  void onInit() {
    fetchMorePageData();
    super.onInit();
  }

  final isPageDataFirstLoading = true.obs;
  final isMorePageDataLoading = false.obs;
  final pageData = <WishListModel>[].obs;
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

  final isDeleting = false.obs;
  Future<void> remove(int id) async {
    isDeleting.value = true;
    await _provider.remove(id).then((_) {
      pageData.removeWhere((e) => e.id == id);
    }).whenComplete(() => isDeleting.value = false);
  }
}
