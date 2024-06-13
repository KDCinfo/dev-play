abstract class LocalSecureStorageApi {
  // Flutter Secure Storage-specific methods.
  Future<void> write(String key, String? value) async {}
  Future<String?> read(String key);
  Future<void> delete(String key) async {}
  Future<void> deleteAll() async {}
  Future<void> deleteAllSecureExcept({required List<String> exceptionList}) async {}
  Future<Map<String, String>> storedKeys();
}
