import 'dart:developer';

import 'package:base_services/base_services.dart';

// This class is the concrete implementation of [StorageService]. Internally
// it uses shared preferences to save and retrieve data, but that is an
// implementation detail that no other class in the app knows about. Swapping
// out shared preferences with a SQL database should be as simple as creating
// a new [StorageService] implementation.
class StorageServiceProd implements StorageServiceApi {
  StorageServiceProd({
    required LocalStorageApi localStorageApi,
    required LocalSecureStorageApi localSecureStorageApi,
    // required WebApi webApi,
    required this.canPrint,
  })  : _localStorageApi = localStorageApi,
        _localSecureStorageApi = localSecureStorageApi;
  // _webApi = webApi;

  final LocalStorageApi _localStorageApi;
  final LocalSecureStorageApi _localSecureStorageApi;
  // final WebApi _webApi;
  final bool canPrint;

  // static const secureStoreEmailKey = 'userEmail';
  final secureStoreEmailKey = 'userEmail';

  @override
  bool containsKey(String key) => _localStorageApi.containsKey(key);

  @override
  Set<String> storedKeys() {
    return _localStorageApi.storedKeys();
    // return _instance.getKeys();
  }

  @override
  Future<Map<String, String>> secureStoredKeys() async {
    // Future<Map<String, String>> storedKeys(String key)
    // return _instance.getKeys();
    return _localSecureStorageApi.storedKeys();
  }

  @override
  void prefsClearAll() {
    _localStorageApi.clear();
  }

  @override
  Future<void> secureClearAll() async {
    await _localSecureStorageApi.deleteAll();
  }

  @override
  Future<void> deleteAllSecureExcept({required List<String> exceptionList}) async {
    await _localSecureStorageApi.deleteAllSecureExcept(
      exceptionList: exceptionList,
    );
  }

  void _catchErrors(String eKey, String eMsg) {
    log('[storage_service] [$eKey] $eMsg');
  }

  /// CAUTION: This is akin to resetting the entire app.
  void resetItAll() {
    prefsClearAll();
    secureClearAll();
  }

  ///
  /// ***** ***** ***** ***** ***** ***** ***** ***** ***** *****
  ///
  ///
  ///                   SHARED PREFERENCES
  ///
  ///
  /// ***** ***** ***** ***** ***** ***** ***** ***** ***** *****
  ///
  @override
  Future<void> prefsSetString({required String key, required String value}) async {
    try {
      // await serviceLocatorPrefs.setString(key, value);
      await _localStorageApi.write(key, value);
      if (canPrint) {
        log('[storage_service: prefsSetString] | [$key] [$value]');
      }
    } catch (err) {
      _catchErrors('storage_service: prefsSetString', err.toString());
    }
  }

  @override
  String? prefsGetString(String key) {
    try {
      return _localStorageApi.read<String>(key);
    } catch (err) {
      _catchErrors('storage_service: prefsGetString', err.toString());
      return '[error]';
    }
  }

  @override
  Future<void> prefsSetBool({required String key, required bool value}) async {
    try {
      if (canPrint) {
        log('[storage_service: prefsSetBool] | [$key] [$value]');
      }
      // await serviceLocatorPrefs.setBool(key, value);
      await _localStorageApi.write<bool>(key, value);
    } catch (err) {
      _catchErrors('storage_service: prefsSetBool', err.toString());
    }
  }

  @override
  bool? prefsGetBool(String key) {
    try {
      // return serviceLocatorPrefs.getBool(key);
      return _localStorageApi.read<bool>(key);
    } catch (err) {
      _catchErrors('storage_service: prefsGetBool', err.toString());
      return null;
    }
  }

  @override
  Future<void> prefsSetInt({required String key, required int value}) async {
    try {
      if (canPrint) {
        log('[storage_service: prefsSetInt] | [$key] [$value]');
      }
      await _localStorageApi.write<int>(key, value);
    } catch (err) {
      _catchErrors('storage_service: prefsSetInt', err.toString());
    }
  }

  @override
  int? prefsGetInt(String key) {
    try {
      return _localStorageApi.read<int>(key);
    } catch (err) {
      _catchErrors('storage_service: prefsGetInt', err.toString());
      return null;
    }
  }

  @override
  Future<void> prefsRemoveKey(String key) async {
    try {
      if (canPrint) {
        log('[storage_service: prefsRemoveKey] | [$key]');
      }
      // await serviceLocatorPrefs.remove(key);
      await _localStorageApi.delete(key);
    } catch (err) {
      _catchErrors('storage_service: prefsRemoveKey', err.toString());
    }
  }

  ///
  /// ***** ***** ***** ***** ***** ***** ***** ***** ***** *****
  ///
  ///
  ///                   SECURE STORAGE
  ///
  ///
  /// ***** ***** ***** ***** ***** ***** ***** ***** ***** *****
  ///
  @override
  Future<void> secureStoreWrite({required String key, required String value}) async {
    try {
      if (canPrint) {
        log('[storage_service: secureStoreWrite] | [$key] [$value]');
      }
      // await serviceLocatorSecureStore.write(key: key, value: value);
      await _localSecureStorageApi.write(key, value);
    } catch (err) {
      _catchErrors('storage_service: secureStoreWrite', err.toString());
    }
  }

  @override
  Future<String?> secureStoreRead(String rkey) async {
    String? tempRead;
    if (canPrint) {
      log('[storage_service_implementation] | tempRead for [$rkey] V V V V V');
    }
    try {
      // tempRead = await serviceLocatorSecureStore.read(key: rkey);
      tempRead = await _localSecureStorageApi.read(rkey);
      if (canPrint) {
        log(
          '[storage_service_...] [secureStoreRead] | '
          '[$rkey]: ${tempRead ?? "isNull"}',
        );
      }
    } catch (err) {
      _catchErrors('storage_service: secureStoreRead', err.toString());
    }
    return tempRead;
  }

  @override
  Future<void> secureStoreDelete(String key) async {
    try {
      if (canPrint) {
        log('[storage_service] [secureStoreDelete] | [$key]');
      }
      // serviceLocatorSecureStore.delete(key: key);
      await _localSecureStorageApi.delete(key);
    } catch (err) {
      _catchErrors('storage_service: secureStoreDelete', err.toString());
    }
  }

  /// Additional examples:
  ///
  // static const sharedPrefExchangeRateKey = 'exchange_rate_key';
  // static const sharedPrefCurrencyKey = 'currency_key';
  // static const sharedPrefLastCacheTimeKey = 'cache_time_key';
}
