import 'package:shared_preferences/shared_preferences.dart';

abstract class CacheStorage<T> {
  Future<void> save(String key, T value);
  Future<T?> get(String key);
  Future<void> clear(String key);
}

class SharedPreferencesStorage<T> implements CacheStorage<T> {
  @override
  Future<void> save(String key, T value) async {
    final pref = await SharedPreferences.getInstance();
    if (value is String) {
      await pref.setString(key, value);
    } else if (value is int) {
      await pref.setInt(key, value);
    } else if (value is bool) {
      await pref.setBool(key, value);
    } else if (value is double) {
      await pref.setDouble(key, value);
    } else if (value is List<String>) {
      await pref.setStringList(key, value);
    } else {
      throw UnsupportedError('Unsupported type: ${value.runtimeType}');
    }
  }

  @override
  Future<T?> get(String key) async {
    final pref = await SharedPreferences.getInstance();
    if (T == String) {
      return pref.getString(key) as T?;
    } else if (T == int) {
      return pref.getInt(key) as T?;
    } else if (T == bool) {
      return pref.getBool(key) as T?;
    } else if (T == double) {
      return pref.getDouble(key) as T?;
    } else if (T == List<String>) {
      return pref.getStringList(key) as T?;
    } else {
      throw UnsupportedError('Unsupported type: $T');
    }
  }

  @override
  Future<void> clear(String key) async {
    final pref = await SharedPreferences.getInstance();
    await pref.remove(key);
  }
}

class MemoryStorage<T> implements CacheStorage<T> {
  final Map<String, T> _storage = {};

  @override
  Future<void> save(String key, T value) async {
    _storage[key] = value;
  }

  @override
  Future<T?> get(String key) async {
    return _storage[key];
  }

  @override
  Future<void> clear(String key) async {
    _storage.remove(key);
  }
}
