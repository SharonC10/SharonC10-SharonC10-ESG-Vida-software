import 'package:ESGVida/model/news_model.dart';
import 'package:ESGVida/provider/news.dart';
import 'package:get/get.dart';

class HomeScreenController extends GetxController {
  @override
  void onInit() {
    fetchLatestNews();
    super.onInit();
  }

  //latest news
  final newsProvider = Get.find<NewsProvider>();
  final latestNewsList = <NewsModel>[].obs;
  final latestNewsLoader = true.obs;

  void fetchLatestNews() {
    latestNewsLoader.value = true;
    latestNewsList.value = [];
    newsProvider.listLatestNews().then((value) {
      if (value.isFail) {
        return;
      }
      latestNewsList.value = value.data!;
    }).whenComplete(() {
      latestNewsLoader.value = false;
    });
  }
}
