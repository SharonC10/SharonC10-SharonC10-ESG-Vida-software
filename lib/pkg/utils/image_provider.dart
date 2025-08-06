import 'package:flutter/material.dart';

class CacheControllableFileImage extends FileImage {
  final String cacheKey;

  const CacheControllableFileImage(super.file, {required this.cacheKey});
  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is CacheControllableFileImage &&
        other.cacheKey == cacheKey &&
        other.file.path == file.path &&
        other.scale == scale;
  }

  @override
  int get hashCode => Object.hash(cacheKey, file.path, scale);
}
