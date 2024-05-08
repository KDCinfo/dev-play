abstract class LocalStorageApi {
  // Base methods.
  T? read<T>(String key);
  Future<void> write<T>(String key, T value) async {}
  Future<void> delete(String key) async {}
  Future<void> clear() async {}

  bool containsKey(String key);
  Set<String> storedKeys();

  // Shared Preferences-specific methods.

  // Flutter Secure Storage-specific methods.
}
