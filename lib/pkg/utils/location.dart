import 'dart:async';

import 'package:ESGVida/pkg/inmemory_data.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

Future<bool> loadLocationIfHasNotLoad() async {
  // 检查位置权限状态
  final status = await Permission.location.status;
  if (status.isDenied) {
    // 如果权限被拒绝，请求权限
    final requestedStatus = await Permission.location.request();
    if (requestedStatus.isGranted) {
      return await _fetchAndSetLocation();
    } else {
      // 处理权限被拒绝的情况
      print('Location permission denied');
      return false;
    }
  } else if (status.isPermanentlyDenied) {
    // 如果权限被永久拒绝，打开应用设置
    final isOpened = await openAppSettings();
    if (isOpened) {
      // 检查用户是否在设置中授予了权限
      final newStatus = await Permission.location.status;
      if (newStatus.isGranted) {
        return await _fetchAndSetLocation();
      } else {
        print('Location permission still denied after opening settings');
        return false;
      }
    }
  } else if (status.isGranted) {
    // 如果权限已授予，直接获取位置
    return await _fetchAndSetLocation();
  }
  return false;
}

Future<bool> _fetchAndSetLocation() async {
  Position? position;
  try {
    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  } catch (e, stackTrace) {
    // 捕获异常并打印异常信息和堆栈信息
    print('Error getting location: $e');
    print('Stack trace: $stackTrace');
  }
  List<Placemark> placemarks = List.empty();
  if (position != null) {
    try {
      placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);
    } catch (e, stackTrace) {
      // 捕获异常并打印异常信息和堆栈信息
      print('Error getting address: $e, from $position');
      print('Stack trace: $stackTrace');
    }
  }
  print("location and address:  $position, $placemarks");
  final placemark = placemarks.isEmpty ? null : placemarks[0];
  await GlobalInMemoryData.I.setGEO(
    position?.longitude ?? 0,
    position?.latitude ?? 0,
    placemark == null
        ? ""
        : "${placemark.name} ${placemark.street}"
            "${placemark.subLocality} ${placemark.thoroughfare}"
            "${placemark.locality} ${placemark.postalCode}"
            "${placemark.administrativeArea} ${placemark.country}",
  );
  return true;
}
