import 'package:flutter/material.dart';

class CommonUtils {
  static T? defaultIfEq<T>(T oldVal, T newVal, {T? defaultVal}) {
    return oldVal == newVal ? defaultVal : newVal;
  }
}

class FormatUtils {
  static String likeCount(int likeCount) {
    if (likeCount < 1000) {
      return likeCount.toString();
    } else if (likeCount < 1000000) {
      double count = likeCount / 1000;
      return '${count.toStringAsFixed(count.truncateToDouble() == count ? 0 : 1)}k';
    } else {
      double count = likeCount / 1000000;
      return '${count.toStringAsFixed(count.truncateToDouble() == count ? 0 : 1)}M';
    }
  }
}

class LocaleUtils {
  static Locale fromUnder(String locale) {
    return _parse(locale.split("_"));
  }

  static String? toDash(Locale? locale) {
    if (locale == null) return null;
    return "${locale.languageCode}-${locale.scriptCode}";
  }

  static Locale fromDash(String locale) {
    return _parse(locale.split("-"));
  }

  static Locale _parse(List<String> strs) {
    return Locale(strs[0], strs[1]);
  }
}
