import 'dart:async';

import 'package:ESGVida/model/common.dart';
import 'package:ESGVida/model/user.dart';
import 'package:get/get.dart';
import 'base.dart';

class UserProvider extends BusinessBaseProvider {
  Future<UnionResp<void>> forgotPassword({
    required String email,
    required String newOne,
    required String confirm,
  }) async {
    return handlerResult(
      post("/api/user/forgot-password/", {
        "email": email,
        "new_password": newOne,
        "confirm_password": confirm
      }),
      toastMessageOnSuccess: true,
    );
  }

  Future<UnionResp<void>> changePassword({
    required String old,
    required String newOne,
    required String confirm,
  }) async {
    return handlerResult(
      post("/api/user/change-password/", {
        "old_password": old,
        "new_password": newOne,
        "confirm_password": confirm
      }),
      toastMessageOnSuccess: true,
    );
  }

  Future<UnionResp<UserProfileModel>> updateProfile({
    required FormData formData,
  }) async {
    return handlerResult(
      put("/api/user/update-user/", formData),
      transform: (body) {
        return UserProfileModel.fromJson(getData(body));
      },
    );
  }

  Future<UnionResp<LoginUserModel>> getLoginUser({
    required int userId,
  }) async {
    return handlerResult(
      get("/api/user/login-user/"),
      transform: (body) {
        return LoginUserModel.fromJson(getData(body));
      },
    );
  }

  Future<UnionResp<UserProfileModel>> getProfile({
    required int userId,
  }) async {
    return handlerResult(
      get("/api/user/profile/?user_id=$userId"),
      transform: (body) {
        return UserProfileModel.fromJson(getData(body));
      },
    );
  }

  Future<UnionResp<MapEntry<String, LoginUserModel>>> signup(
      FormData formData) async {
    return handlerResult(
      post("/api/user/signup/", formData),
      transform: (body) {
        final data = getData(body);
        return MapEntry(
            data["access_token"], LoginUserModel.fromJson(data["login_user"]));
      },
    );
  }

  Future<UnionResp<MapEntry<String, LoginUserModel>>> login({
    required String email,
    required String password,
    required String deviceType,
    required String deviceToken,
  }) async {
    return handlerResult(
      post("/api/user/login/", {
        "email": email,
        "password": password,
        "device_type": deviceType,
        "device_token": deviceType
      }),
      transform: (body) {
        final data = getData(body);
        return MapEntry(
            data["access_token"], LoginUserModel.fromJson(data["login_user"]));
      },
    );
  }
}
