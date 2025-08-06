import 'dart:async';

import 'package:ESGVida/model/common.dart';
import 'package:ESGVida/model/shopping.dart';
import '../base.dart';

class AddressProvider extends BusinessBaseProvider {
  Future<UnionResp<void>> remove({required int addressId}) async {
    return handlerResult(
      delete(
        "/api/user/address/$addressId/",
      ),
    );
  }

  Future<UnionResp<void>> update({
    required int addressId,
    String? username,
    String? phone,
    bool? isDefault,
    String? area,
    String? areaDetail,
  }) async {
    return handlerResult(
      put(
        "/api/user/address/$addressId/",
        {
          "name": username,
          "phone": phone,
          "is_default": isDefault,
          "area": area,
          "area_detail": areaDetail,
        },
      ),
    );
  }

  Future<UnionResp<void>> add({
    required String username,
    required String phone,
    required bool isDefault,
    required String area,
    required String areaDetail,
  }) async {
    return handlerResult(
      post(
        "/api/user/address/",
        {
          "name": username,
          "phone": phone,
          "is_default": isDefault,
          "area": area,
          "area_detail": areaDetail,
        },
      ),
    );
  }

  Future<UnionResp<List<AddressModel>>> listAll() async {
    return handlerResult(
      get("/api/user/address/"),
      transform: (body) {
        return getData<List<dynamic>>(body)
            .map((e) => AddressModel.fromJson(e))
            .toList();
      },
    );
  }
}
