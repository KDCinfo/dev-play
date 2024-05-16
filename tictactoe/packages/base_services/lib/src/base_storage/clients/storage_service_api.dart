/// This is the contract that all storage services must follow.
abstract interface class StorageServiceApi {
  /// This is an (abstract) interface because these are all the things
  /// the app needs to be able to do, no matter which external API they interface with.
  ///
  /// @TODO: 'prefs' is a misnomer here.
  /// It's not the app's Preferences, but instead, a reference to SharedPreferences,
  /// which should be changed because that's too tightly coupled to a specific library.
  ///
  /// Perhaps 'local' would be a better name, although, Flutter Secure Storage is also local.
  /// 'storage' is a tad too generic.
  ///
  /// 'secure' on the other hand is apt.
  ///
  /// Maybe 'unsecure' would be the __apt opposite__.
  ///
  void prefsClearAll();
  Future<void> secureClearAll();
  Future<void> deleteAllSecureExcept({required List<String> exceptionList}) async {}

  bool containsKey(String key);
  Set<String> storedKeys();
  Future<Map<String, String>> secureStoredKeys();

  Future<void> prefsSetString({required String key, required String value});
  Future<void> prefsSetBool({required String key, required bool value});
  Future<void> prefsSetInt({required String key, required int value});

  String? prefsGetString(String key);
  bool? prefsGetBool(String key);
  int? prefsGetInt(String key);

  Future<void> prefsRemoveKey(String key);

  Future<void> secureStoreWrite({required String key, required String value});
  Future<String?> secureStoreRead(String key);
  Future<void> secureStoreDelete(String key);

  /// Additional examples:
  ///
  // Future cacheExchangeRateData(List<Rate> data);
  // Future<List<Rate>> getExchangeRateData();
  // Future<List<Currency>> getFavoriteCurrencies();
  // Future saveFavoriteCurrencies(List<Currency> data);
  // Future<bool> isExpiredCache();
}
