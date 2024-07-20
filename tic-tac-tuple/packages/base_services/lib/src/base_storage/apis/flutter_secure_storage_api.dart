import 'package:base_services/base_services.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class FlutterSecureStorageApi implements LocalSecureStorageApi {
  factory FlutterSecureStorageApi() {
    return FlutterSecureStorageApi._();
  }

  FlutterSecureStorageApi._() {
    _instance = const FlutterSecureStorage();
  }

  late final FlutterSecureStorage _instance;

  @override
  Future<void> write(String key, String? value) async {
    await _instance.write(key: key, value: value);
  }

  @override
  Future<String?> read(String key) {
    return _instance.read(key: key);
  }

  @override
  Future<void> delete(String key) async {
    await _instance.delete(key: key);
  }

  @override
  Future<void> deleteAll() async {
    await _instance.deleteAll();
  }

  @override
  Future<void> deleteAllSecureExcept({required List<String> exceptionList}) async {
    final allKeys = await _instance.readAll();
    for (final key in allKeys.keys) {
      if (!exceptionList.contains(key)) {
        await _instance.delete(key: key);
      }
    }
  }

  @override
  Future<Map<String, String>> storedKeys() {
    return _instance.readAll();
  }
}
