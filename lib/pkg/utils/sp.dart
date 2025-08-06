import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SP {
  static Future<bool> remove<T>(String key) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.remove(key);
  }
  static Future<T?> get<T>(String key,
      {T Function(Map<String, dynamic> json)? converter}) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    final data = pref.getString(key);
    if (data == null) return null;
    if (converter == null) {
      return data as T;
    }
    return converter(jsonDecode(data));
  }

  static Future<void> set<T>(String key, T value,
      {Map<String, dynamic> Function(T obj)? converter}) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    if (value is String) {
      await pref.setString(key, value);
    } else if (value is int) {
      await pref.setInt(key, value);
    } else if (value is bool) {
      await pref.setBool(key, value);
    } else if (value is double) {
      await pref.setDouble(key, value);
    } else if (converter != null) {
      await pref.setString(key, jsonEncode(converter(value)));
    }
  }
}
