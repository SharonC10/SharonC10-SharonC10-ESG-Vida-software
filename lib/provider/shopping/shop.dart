import 'dart:async';

import 'package:ESGVida/model/common.dart';
import 'package:ESGVida/model/shopping.dart';
import '../base.dart';

class ShopProvider extends BusinessBaseProvider {
  Future<UnionResp<ShopModel>> getById(
    int id,
  ) async {
    return handlerResult(
      get("/api/user/shop/$id/"),
      transform: (body) {
        return ShopModel.fromJson(getData<Map<String, dynamic>>(body));
      },
    );
  }

  Future<UnionResp<List<ShopModel>>> hot() async {
    return handlerResult(
      get("/api/user/shop/hot/", query: {
        "feed": "true",
      }),
      transform: (body) {
        return getData<List<dynamic>>(body)
            .map((e) => ShopModel.fromJson(e))
            .toList();
      },
    );
  }

  Future<UnionResp<PageModel<ShopModel>>> list({
    int page = 1,
    String? key,
  }) async {
    return handlerResult(
      get("/api/user/shop/",
          query: {"page": "$page", "feed": "true", "key": key}),
      transform: (body) {
        return PageModel.fromJson(
            getData<Map<String, dynamic>>(body), (e) => ShopModel.fromJson(e));
      },
    );
  }
}
