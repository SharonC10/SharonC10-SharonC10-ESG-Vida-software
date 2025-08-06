import 'dart:async';

import 'package:ESGVida/model/common.dart';
import 'package:ESGVida/model/wishlist.dart';
import '../base.dart';

class WishListProvider extends BusinessBaseProvider {
  Future<UnionResp<PageModel<WishListModel>>> list({int page = 1}) async {
    return handlerResult(
      get(
        "/api/user/wishlist/",
        query: {
          "page": "$page",
        },
      ),
      transform: (body) {
        return PageModel.fromJson(
          getData(body),
          (e) => WishListModel.fromJson(e),
        );
      },
    );
  }

  Future<UnionResp<void>> removeByProductId(
    int productId,
  ) async {
    return handlerResult(
      delete(
        "/api/user/wishlist/remove/",
        query: {
          "product_id": "$productId",
        },
      ),
    );
  }

  Future<UnionResp<void>> remove(
    int wishListId,
  ) async {
    return handlerResult(
      delete(
        "/api/user/wishlist/$wishListId/",
      ),
    );
  }

  Future<UnionResp<void>> add(
    int productId,
  ) async {
    return handlerResult(
      post(
        "/api/user/wishlist/",
        {
          "product_id": productId,
        },
      ),
    );
  }
}
