import 'package:ESGVida/model/news_model.dart';
import 'package:ESGVida/provider/news.dart';
import 'package:get/get.dart';

class NewsListController extends GetxController {
  final _provider = Get.find<NewsProvider>();

  final isPageDataFirstLoading = false.obs;
  final isMorePageDataLoading = false.obs;
  final pageData = <NewsModel>[].obs;
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
        .feedList(
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
