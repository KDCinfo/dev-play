import 'package:base_services/base_services.dart';

/// This service class has not been implemented.
/// It is mostly just to show how fake data could be used during development.
///
class FakeStorageService implements StorageServiceApi {
  @override
  Future<void> prefsSetString({required String key, required String value}) async {}
  @override
  String? prefsGetString(String key) {
    return '';
  }

  // Future<void> prefsSetBool({required String key, required bool value}) async {}
  // bool? prefsGetBool(String key) {
  //   return null;
  // }

  // Future<void> prefsSetInt({required String key, required int value}) async {}
  // int? prefsGetInt(String key) {
  //   return null;
  // }
  @override
  Future<void> prefsRemoveKey(String key) async {}

  @override
  Future<void> secureStoreWrite({required String key, required String value}) async {}
  @override
  Future<String?> secureStoreRead(String key) async {
    return '';
  }

  @override
  Future<void> secureStoreDelete(String key) async {}

  @override
  bool containsKey(String key) {
    // Implement containsKey
    throw UnimplementedError();
  }

  @override
  void prefsClearAll() {
    // Implement prefsClearAll
  }

  @override
  bool? prefsGetBool(String key) {
    // Implement prefsGetBool
    throw UnimplementedError();
  }

  @override
  int? prefsGetInt(String key) {
    // Implement prefsGetInt
    throw UnimplementedError();
  }

  @override
  Future<void> prefsSetBool({required String key, required bool value}) {
    // Implement prefsSetBool
    throw UnimplementedError();
  }

  @override
  Future<void> prefsSetInt({required String key, required int value}) {
    // Implement prefsSetInt
    throw UnimplementedError();
  }

  @override
  Future<void> secureClearAll() async {
    // Implement secureClearAll
  }

  @override
  Future<void> deleteAllSecureExcept({required List<String> exceptionList}) async {}

  @override
  Set<String> storedKeys() {
    // Implement storedKeys
    throw UnimplementedError();
  }

  @override
  Future<Map<String, String>> secureStoredKeys() {
    // Implement storedKeys
    throw UnimplementedError();
  }

/*
  /// Additional examples:

  @override
  Future<List<Rate>> getExchangeRateData() async {
    List<Rate> list = [];
    list.add(Rate(
      baseCurrency: 'USD',
      quoteCurrency: 'EUR',
      exchangeRate: 0.91,
    ));
    list.add(Rate(
      baseCurrency: 'USD',
      quoteCurrency: 'CNY',
      exchangeRate: 7.05,
    ));
    list.add(Rate(
      baseCurrency: 'USD',
      quoteCurrency: 'MNT',
      exchangeRate: 2668.37,
    ));
    return list;
  }

  @override
  Future cacheExchangeRateData(List<Rate> data) {
    return null;
  }

  @override
  Future<List<Currency>> getFavoriteCurrencies() async {
    List<Currency> list = [];
    list.add(Currency('USD', amount: 0.0));
    list.add(Currency('EUR', amount: 0.0));
    list.add(Currency('CNY', amount: 0.0));
    list.add(Currency('MNT', amount: 0.0));
    return list;
  }

  @override
  Future saveFavoriteCurrencies(List<Currency> data) {
    return null;
  }

  @override
  Future<bool> isExpiredCache() async {
    return false;
  }
*/
}
