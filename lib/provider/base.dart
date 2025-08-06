import 'dart:async';
import 'package:ESGVida/model/common.dart';
import 'package:ESGVida/pkg/inmemory_data.dart';
import 'package:ESGVida/pkg/language.dart';
import 'package:ESGVida/pkg/toast.dart';

import 'package:get/get.dart';

import 'package:ESGVida/pkg/constants/common.dart';
import 'package:get/get_connect/http/src/request/request.dart';

class NetworkException implements Exception {
  final Response<dynamic> resp;
  final String? message;
  NetworkException(this.message, {required this.resp});
  @override
  String toString() {
    Object? message = this.message;
    if (message == null) return "NetworkException(${resp.statusCode})";
    return "NetworkException(${resp.statusCode}): $message";
  }
}

class BusinessBaseProvider extends GetConnect {
  @override
  void onInit() {
    baseUrl = CommonConstant.BE_BASE_URL;
    timeout = const Duration(seconds: 30);
    //连UnauthorizedException也抛出，这里就搞安全错误好咯，，，
    httpClient.errorSafety = true;
    httpClient.addRequestModifier<dynamic>((req) {
      final token = GlobalInMemoryData.I.token;
      if (token != null) {
        req.headers["Authorization"] = "Bearer $token";
      }
      req.headers["Accept-Language"] = GlobalInMemoryData.I.locale ==
              CommonConstant.DEFAULT_LOCALE
          ? "${GlobalInMemoryData.I.locale};q=1.0"
          : "${GlobalInMemoryData.I.locale};q=1.0, ${CommonConstant.DEFAULT_LOCALE};q=0.8";

      repairDelete(req);
      return req;
    });
  }

  /*
- django服务器除了这个delete请求，还收到了一个请求
- DEBUG: http\server.py# BaseHttpRequestHandler#parse_request
- 正常是words = [method, url, version]
- 但是第二个的请求行requestline是: 0\r\n (结束块、body为空)
  - 即报错：###  Bad request syntax ('0') ###
- 根据CHATGPT说法、以及实际测试
- 第二个请求的headers
```{
  "content-length":  "",
  "content-type":"application/json; charset=utf-8",
  "user-agent": "Dart/3.3 (dart:io)",
  "transfer-encoding":  "chunked",
  "accept-language": "zh-Hant;q=1.0, en-US;q=0.8",
  "accept-encoding": "gzip",
  "host": "127.0.0.1:8000"
}```
  - 只要content-length=0 or transfer-encoding='' 就会正常，不会有第二个请求
  - 不知道为什么，其他正常的GET等请求，都不会有transfer-encoding=chunked，但是这个delete请求就会有.
  - 可能就是GPT说的chunked导致多发了0\r\n，当然就被认为是一个新请求，因为前面的请求报文已经结束了
   */
  void repairDelete(Request<dynamic> req) {
    if (req.method.toUpperCase() == "DELETE") {
      if (req.contentLength == null || req.contentLength == 0) {
        req.headers["transfer-encoding"] = "";
      }
    }
  }

  /// ### after onError still continue invoke then, so  return UnionResp
  /// - error
  ///   1. toastError=true => null && toast
  ///   2. throwError=true => null &&  throw NetworkException
  /// - no error
  ///   1. transform!=null => transform()
  ///   2. is void => null,
  ///   3. else => body(Map)
  FutureOr<UnionResp<T>> handlerResult<T>(
      Future<Response<Map<String, dynamic>?>> reqFuture,
      {bool toastError = true,
      bool toastBizError = true,
      //if true, to catch it
      bool throwError = false,
      bool toastMessageOnSuccess = false,
      T Function(Map<String, dynamic>)? transform}) {
    return reqFuture.then((resp) {
      String? error;
      bool isBizError = false;
      if (resp.statusCode == null) {
        error = prettifyError(resp);
      } else if (resp.hasError || resp.body?["code"] != "0") {
        error =
            resp.body?["message"] ?? "${resp.statusCode}: ${resp.statusText}";
        isBizError = true;
      }
      T? data;
      if (error != null) {
        if (throwError) {
          throw NetworkException(null, resp: resp);
        }
        if (isBizError && toastBizError || !isBizError && toastError) {
          showToast(error);
        }
        print(
            "[esgvida.network]: [${resp.request?.method}] [${resp.request?.url}] [${resp.statusCode}], ${"error[$error]"}");
      } else {
        if (toastMessageOnSuccess && resp.body?["message"] != null) {
          showToast(resp.body?["message"]);
        }
        if (transform != null && resp.body != null) {
          data = transform(resp.body!);
        } else if (T.toString() == "void") {
          data = null;
        } else {
          data = resp.body as T;
        }
      }
      return UnionResp(
          code: resp.body?["code"], message: resp.body?["message"], data: data);
    }).onError((error, stackTrace) {
      String errStr =
          "${LanguageGlobalVar.ERROR_NETWORK_CLIENT.tr}: ${error.toString()}";
      if (toastError) {
        showToast(errStr);
      }
      print("esgvida: network err: $errStr\n\t$stackTrace");
      return UnionResp(code: "-400");
    });
  }

  T getData<T>(Map<String, dynamic> json) {
    return json["data"];
  }

  Map<String, dynamic> defaultTransform(Map<String, dynamic> json) => json;

  String prettifyError(Response<Map<String, dynamic>?> resp) {
    //TimeoutException、GetHttpException、UnauthorizedException
    String error;
    if (resp.statusText.toString().contains("TimeoutException")) {
      //TimeoutException after 0:00:05.000000: Future not completed
      error = "${LanguageGlobalVar.ERROR_NETWORK_TIMEOUT.tr}: "
          "${resp.statusText.toString().replaceFirst("TimeoutException after ", "").replaceFirst(": Future not completed", "")}";
    } else {
      error = "${LanguageGlobalVar.ERROR_NETWORK.tr}: ${resp.statusText}";
    }
    return error;
  }
}
