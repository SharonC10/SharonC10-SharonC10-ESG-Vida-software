import 'dart:async';

import 'package:ESGVida/model/common.dart';
import 'package:ESGVida/model/shopping.dart';
import 'package:get/get.dart';
import '../base.dart';

class ProductProvider extends BusinessBaseProvider {
  Future<UnionResp<void>> recordShare(
    int productId,
  ) async {
    return handlerResult(
      post(
        "/api/user/product/share/",
        {
          "product_id": productId,
        },
      ),
    );
  }

  Future<UnionResp<void>> deleteComment({
    required int commentId,
  }) async {
    return handlerResult(delete("/api/user/product/comment/$commentId/"),
        toastMessageOnSuccess: true);
  }

  Future<UnionResp<void>> updateComment({
    required int commentId,
    required double rating,
    required String content,
  }) async {
    return handlerResult(
      put(
        "/api/user/product/comment/$commentId/",
        {
          "rating": rating,
          "content": content,
        },
      ),
    );
  }

  Future<UnionResp<void>> addComment({
    required int productId,
    int? pid,
    required double rating,
    required String content,
  }) async {
    return handlerResult(
      post("/api/user/product/comment/", {
        "product_id": productId,
        "pid": pid,
        "rating": rating,
        "content": content,
      }),
    );
  }

  Future<UnionResp<List<ProductCommentModel>>> latestComment({
    required int productId,
    int size = 4,
  }) async {
    return handlerResult(
        get("/api/user/product/comment/latest/", query: {
          "product_id": "$productId",
          "size": "$size",
        }), transform: (body) {
      return getData<List<dynamic>>(body)
          .map((e) => ProductCommentModel.fromJson(e))
          .toList();
    });
  }

  Future<UnionResp<PageModel<ProductCommentModel>>> listComment(
      {int page = 1, required int productId}) async {
    return handlerResult(
        get("/api/user/product/comment/",
            query: {"page": "$page", "product_id": "$productId"}),
        transform: (body) {
      return PageModel.fromJson(
        getData(body),
        (e) => ProductCommentModel.fromJson(e),
      );
    });
  }

  Future<UnionResp<ProductInteractionModel>> getInteraction(
      int productId) async {
    return handlerResult(get("/api/user/product/$productId/interaction/"),
        toastBizError: false, transform: (body) {
      return ProductInteractionModel.fromJson(getData(body));
    });
  }

  Future<UnionResp<void>> add({required FormData formData}) async {
    return handlerResult(
      post("/api/user/product/", formData),
      toastMessageOnSuccess: true,
      toastBizError: true,
    );
  }

  Future<UnionResp<ProductModel>> getById(int id) async {
    return handlerResult(
      get("/api/user/product/$id/"),
      transform: (body) {
        return ProductModel.fromJson(getData<Map<String, dynamic>>(body));
      },
    );
  }

  Future<UnionResp<List<ProductModel>>> hot() async {
    return handlerResult(
      get("/api/user/product/hot/", query: {
        "feed": "true",
      }),
      transform: (body) {
        return getData<List<dynamic>>(body)
            .map((e) => ProductModel.fromJson(e))
            .toList();
      },
    );
  }

  Future<UnionResp<PageModel<ProductModel>>> list(
      {int? shopId, int page = 1, String key = ""}) async {
    return handlerResult(
      get("/api/user/product/", query: {
        "page": "$page",
        //todo null可以忽视？
        "shop_id": shopId != null ? "$shopId" : null,
        "feed": "true",
        "key": key,
      }),
      transform: (body) {
        return PageModel.fromJson(
          getData<dynamic>(body),
          (e) => ProductModel.fromJson(e),
        );
      },
    );
  }
}
