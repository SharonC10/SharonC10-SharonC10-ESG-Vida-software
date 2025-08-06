import 'storage.dart';

class CacheData<T> {
  final T value;
  final int expiry;
  CacheData({
    required this.value,
    required this.expiry,
  });
  bool isExpired() {
    return DateTime.now().microsecondsSinceEpoch >= this.expiry;
  }
}

class LazyCacheManager {
  static final LazyCacheManager instance = LazyCacheManager(MemoryStorage());

  final CacheStorage _storage;

  LazyCacheManager(this._storage);

  Future<void> saveCache<T>(
      String key, T value, Duration expiryDuration) async {
    final expiry = DateTime.now().add(expiryDuration).millisecondsSinceEpoch;
    await _storage.save(
      key,
      CacheData(value: value, expiry: expiry),
    );
  }

  Future<T?> getCache<T>(String key) async {
    final cachedData = await _storage.get(key);
    if (cachedData == null) {
      return null;
    }
    if (cachedData != null && cachedData.isExpired()) {
      await _storage.clear(key);
      return null;
    }
    return cachedData.value;
  }

  Future<CacheData<T>?> getCacheEventExpired<T>(
    String key, [
    Future<T> Function()? getter,
  ]) async {
    final cachedData = await _storage.get(key);
    if (cachedData == null) {
      return null;
    }
    if (cachedData != null && cachedData.isExpired()) {
      await _storage.clear(key);
      if (getter != null) {
        await _storage.save(key, await getter());
      }
    }
    return cachedData;
  }

  Future<void> clearCache(String key) async {
    await _storage.clear(key);
  }
}
