import 'package:ESGVida/model/user.dart';
import 'package:ESGVida/pkg/cache/core.dart';
import 'package:ESGVida/pkg/constants/cache.dart';
import 'package:ESGVida/pkg/constants/common.dart';
import 'package:ESGVida/pkg/constants/sp.dart';
import 'package:ESGVida/pkg/utils/common.dart';
import 'package:ESGVida/pkg/utils/jwt.dart';
import 'package:ESGVida/pkg/utils/location.dart';
import 'package:ESGVida/pkg/utils/sp.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

class GlobalInMemoryData {
  static final GlobalInMemoryData I = GlobalInMemoryData();
  LoginUserModel? loginUser;
  String? token;
  bool get isLogin =>
      token != null && loginUser != null && !isTokenExpired(token!);
  // late String locale;
  String? locale;
  final String deviceType = GetPlatform.isAndroid
      ? "Android"
      : GetPlatform.isIOS
          ? "IOS"
          : "";
  String get deviceToken => _deviceToken ?? CommonConstant.DEFAULT_DEVICE_TOKEN;
  String? _deviceToken;

  int? get userId => loginUser?.profile?.id;
  bool isLoginUser(int? userId) => this.userId != null && this.userId == userId;

  Future<void> init() async {
    final token = await SP.get<String>(SPConstant.TOKEN);
    if (token != null && !isTokenExpired(token)) {
      this.token = token;
      loginUser = await SP.get(SPConstant.LOGIN_USER,
          converter: LoginUserModel.fromJson);
    }
    var locale = await SP.get<String>(SPConstant.LOCALE);
    if (locale == null) {
      final systemDefault = LocaleUtils.toDash(Get.deviceLocale);
      locale = CommonConstant.LOCALES.containsKey(systemDefault)
          ? systemDefault
          : CommonConstant.DEFAULT_LOCALE;
    }
    locale = locale!;
    this.locale = locale;
    
    _deviceToken = await SP.get<String>(SPConstant.DEVICE_TOKEN);
  }

  Future<void> setGEO(double longitude, double latitude, String address) async {
    LazyCacheManager.instance.saveCache(
      CacheConstant.GEO,
      (longitude, latitude, address),
      const Duration(minutes: 2),
    );
  }

  Future<(double longitude, double latitude, String address)> getGEO() async {
    var data = await LazyCacheManager.instance.getCacheEventExpired<
        (double longitude, double latitude, String address)>(
      CacheConstant.GEO,
    );
    if (data == null || data.isExpired()) {
      bool isOK = await loadLocationIfHasNotLoad();
      if (!isOK) {
        await LazyCacheManager.instance.saveCache(
          CacheConstant.GEO,
          (0.0, 0.0, ""),
          const Duration(
            minutes: 10,
          ),
        );
      }
      data = await LazyCacheManager.instance.getCacheEventExpired<
          (double longitude, double latitude, String address)>(
        CacheConstant.GEO,
      );
    }
    if (data == null) {
      return (0.0, 0.0, "");
    }
    return data.value;
  }

  Future<void> obtainDeviceToken() async {
    if (_deviceToken == null) {
      await FirebaseMessaging.instance.getToken().then((value) {
        if (value != null) {
          setDeviceToken(value);
        } else {
          print("[esdvida.firebase] obtain  device token");
        }
      }).onError((error, stackTrace) {
        print(
            "[esdvida.firebase] has error when obtain empty device token, $error\n\t$stackTrace");
      });
    }
  }

  Future<void> setDeviceToken(String? deviceToken) async {
    if (deviceToken != null) {
      await SP.set<String>(SPConstant.DEVICE_TOKEN, deviceToken);
      _deviceToken = deviceToken;
    }
  }

  Future<void> setLocale(String locale) async {
    await SP.set<String>(SPConstant.LOCALE, locale);
    this.locale = locale;
  }

  Future<void> setToken(String token) async {
    await SP.set<String>(SPConstant.TOKEN, token);
    this.token = token;
  }

  Future<void> setLoginUser(LoginUserModel loginUser) async {
    await SP.set(SPConstant.LOGIN_USER, loginUser,
        converter: (data) => data.toJson());
    this.loginUser = loginUser;
  }

  Future<void> clearLoginData() async {
    await SP.remove(SPConstant.LOGIN_USER);
    await SP.remove(SPConstant.TOKEN);
  }
}
