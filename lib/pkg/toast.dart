import 'package:flutter_easyloading/flutter_easyloading.dart';

showToast(String message, {double? duration}) {
  EasyLoading.showToast(
      duration: Duration(seconds: duration == null ? 2 : 3),
      message,
      toastPosition: EasyLoadingToastPosition.top);
}
