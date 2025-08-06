import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

extension IndexedIterable<E> on Iterable<E> {
  Iterable<T> mapIndexed<T>(T Function(E e, int i) f) {
    var i = 0;
    return map((e) => f(e, i++));
  }
}

extension EmailMobileValidator on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }

  bool isValidMobile() {
    return RegExp(
            r'^\s*(?:\+?(\d{1,3}))?[-. (]*(\d{3})[-. )]*(\d{3})[-. ]*(\d{4})(?: *x(\d+))?\s*$')
        .hasMatch(this);
  }

  String filename(){
    return substring(lastIndexOf(Platform.pathSeparator)+1);
  }
}

extension Str on String? {
  bool isNil() {
    if (this == null) {
      return true;
    }
    final str = toString();
    return str == "null" || str == "";
  }
}

extension EmptySpace on num {
  SizedBox get height => SizedBox(height: toDouble());

  SizedBox get width => SizedBox(width: toDouble());

  String toFriendlyDatetimeStr({
    bool isSecs = true,
    bool? isMills,
  }) {
    var timestamp = isSecs
        ? (this * 1000).toInt()
        : isMills == true
            ? toInt()
            : (this * 1000 * 1000).toInt();
    final datetime =
        DateTime.fromMillisecondsSinceEpoch(timestamp, isUtc: false);
    final now = DateTime.now();
    var str = "${datetime.hour.toTwoNum()}:${datetime.minute.toTwoNum()}";
    if (now.day != datetime.day) {
      str = "${datetime.month.toTwoNum()}-${datetime.day.toTwoNum()} $str";
    }
    if (now.year != datetime.year) {
      str = "${datetime.year}-$str";
    }
    return str;
  }

  String toTwoNum() {
    if (this < 10) {
      return "0$this";
    } else {
      return toString();
    }
  }
}

Center loading() => const Center(child: CircularProgressIndicator());

commonElevatedButtonEXt(
    {required Color backgroundColor,
    required double height,
    required double width,
    required Callback onTapButton,
    required Widget child,
    required double borderRadius,
    required double elevation,
    bordarcolor,
    bordarWidth}) {
  return ElevatedButton(
    onPressed: onTapButton,
    style: ElevatedButton.styleFrom(
      padding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          side: BorderSide(
            color: bordarcolor ?? Colors.transparent,
            width: bordarWidth ?? 0.0,
          )),
      fixedSize: Size(width, height),
      minimumSize: Size(width, height),
      elevation: elevation,
      backgroundColor: backgroundColor,
    ),
    child: child,
  );

  // CommonTextfeild({controller, hinttext}) {
  //   return TextFormField(
  //     maxLength: 10,
  //     autofocus: false,
  //     controller: controller,
  //     style: CommonStyle.black14Light,
  //     decoration: InputDecoration(
  //         border: InputBorder.none,
  //         counterText: "",
  //         filled: true,
  //         contentPadding: EdgeInsets.symmetric(vertical: 1, horizontal: 5),
  //         fillColor: Colors.transparent,
  //         hintText: hinttext,
  //         hintStyle: CommonStyle.grey14Light),
  //   );
  // }
}

//
// Future<File> fileFromImageUrlEXT(url) async {
//   print("url $url");
//   final response = await http.get(Uri.parse(url));
//   print("response ${response.bodyBytes}");
//
//       final documentDirectory = await getApplicationDocumentsDirectory();
//   final tempFile = File("${(await getTemporaryDirectory()).path}/${DateTime.now().hour}${DateTime.now().minute}${DateTime.now().second}esgVida.jpg");
//   final file = await tempFile.writeAsBytes(response.bodyBytes.buffer.asUint8List(response.bodyBytes.offsetInBytes, response.bodyBytes.lengthInBytes),);
//   // Share.shareXFiles([XFile(file.path)]);
//   // final file = File(join(documentDirectory.path, 'imagetest.png'));
//   //
//   // file.writeAsBytesSync(response.bodyBytes);
//
//   return file;
// }

Future<File> fileFromImageUrlEXT(String url, String name) async {
  final response = await http.get(Uri.parse(url));
  final documentDirectory = await getApplicationDocumentsDirectory();
  final file = File(join(documentDirectory.path, name));
  file.writeAsBytesSync(response.bodyBytes);
  return file;
}
