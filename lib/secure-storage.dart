import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserSecureStorage {
  static final _storage = FlutterSecureStorage();

  static const _key = 'key';
  static const _otherkey = 'otherkey';

  static Future setAccessToken(String token) async =>
      await _storage.write(key: _key, value: token);

  static Future<String?> getAccessToken() async =>
      await _storage.read(key: _key);

  static Future setUserId(String token) async =>
      await _storage.write(key: _otherkey, value: token);

  static Future<String?> getUserId() async =>
      await _storage.read(key: _otherkey);
}
