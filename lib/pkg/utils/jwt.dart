import 'dart:convert';

bool isTokenExpired(String token) { //update on 10/8/2025 - Sharon 
  final parts = token.split(".");
  if (parts.length != 3) {
    return true; // Invalid token format, treat as expired
  }

  try {
    // Normalize Base64 string by adding padding if needed
    String normalized = base64.normalize(parts[1]);
    final payloadMap = jsonDecode(utf8.decode(base64Decode(normalized)));

    if (payloadMap is! Map || !payloadMap.containsKey("exp")) {
      return true; // Missing 'exp' field, treat as expired
    }

    final exp = payloadMap["exp"];
    final now = DateTime.now().millisecondsSinceEpoch ~/ 1000;

    return now >= exp;
  } catch (e) {
    print("Token decode error: $e");
    return true; // Any error means we treat token as expired
  }
}

// import 'dart:convert';

// bool isTokenExpired(String token) {
//   final parts = token.split(".");
//   if (parts.length != 3) {
//     return false;
//   }
//   final payload = jsonDecode(String.fromCharCodes(base64Decode(parts[1])));
//   return DateTime.now().millisecondsSinceEpoch ~/ 1000 >=
//       payload["exp"];
// }
