import 'dart:convert';

bool isTokenExpired(String token) {
  final parts = token.split(".");
  if (parts.length != 3) {
    return false;
  }
  final payload = jsonDecode(String.fromCharCodes(base64Decode(parts[1])));
  return DateTime.now().millisecondsSinceEpoch ~/ 1000 >=
      payload["exp"];
}
