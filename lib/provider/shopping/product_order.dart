import 'dart:async';

import 'package:ESGVida/model/common.dart';
import 'package:ESGVida/model/shopping.dart';
import '../base.dart';

class ProductOrderProvider extends BusinessBaseProvider {
  ///status, count
  Future<UnionResp<Map<ProductOrderStatus, int>>> status() async {
    return handlerResult(
      get("/api/user/product/order/status/"),
      transform: (body) {
        return getData<Map<String, dynamic>>(body).map((key, value) => MapEntry(
              ProductOrderStatus.values.firstWhere((e) => e.name == key),
              value as int,
            ));
      },
    );
  }

  Future<UnionResp<PageModel<ProductOrderModel>>> list({
    int page = 1,
    String? key,
    ProductOrderStatus? status,
  }) async {
    return handlerResult(
      get("/api/user/product/order/", query: {
        "page": "$page",
        "feed": "true",
        "key": key,
        "status": status?.name,
      }),
      transform: (body) {
        return PageModel.fromJson(getData<Map<String, dynamic>>(body),
            (e) => ProductOrderModel.fromJson(e));
      },
    );
  }
}
