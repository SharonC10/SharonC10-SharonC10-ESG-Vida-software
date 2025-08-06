import 'dart:async';

import 'package:ESGVida/model/common.dart';
import 'package:ESGVida/model/shopping.dart';
import '../base.dart';

class ShoppingCartProvider extends BusinessBaseProvider {
  Future<UnionResp<void>> changeAmount({
    required int cartItemId,
    required int amount,
  }) async {
    return handlerResult(
      post(
        "/api/user/shopping-cart-item/$cartItemId/change-amount/?amount=$amount",
        null,
      ),
    );
  }

  Future<UnionResp<PageModel<ShoppingCartItemModel>>> list(
      {int page = 1}) async {
    return handlerResult(
      get(
        "/api/user/shopping-cart-item/",
        query: {
          "page": "$page",
        },
      ),
      toastMessageOnSuccess: false,
      transform: (body) {
        return PageModel.fromJson(getData<Map<String, dynamic>>(body),
            (e) => ShoppingCartItemModel.fromJson(e));
      },
    );
  }

  Future<UnionResp<void>> remove(int cartItemId) async {
    return handlerResult(
      delete(
        "/api/user/shopping-cart-item/$cartItemId/",
      ),
    );
  }

  Future<UnionResp<void>> add(int productId, {int amount = 1}) async {
    return handlerResult(
      post(
        "/api/user/shopping-cart-item/",
        {
          "product_id": productId,
          "amount": amount,
        },
      ),
    );
  }
}
