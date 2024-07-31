// ignore_for_file: avoid-inferrable-type-arguments

import 'package:base_services/base_services.dart';

import 'package:shared_preferences/shared_preferences.dart';

/// {@template storage_repository}
/// This API provides an interface to
/// read, write and delete local data on the device.
///
/// Comments within this file for each method have been pasted from the API docs.
/// https://pub.dev/documentation/shared_preferences/latest/shared_preferences/SharedPreferences-class.html
///
/// / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / /
///
/// read<T>(String key)           => T?
/// write<T>(String key, T value) => Future<void>
/// delete(String key)            => Future<void>
/// storedKeys()                  => Set<String>
/// clear()                       => Future<void>
/// containsKey(String key)       => bool
///
/// / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / /
///
/// # Unimplemented methods
///
/// ? .reload() → Future<void>
///   Fetches the latest values from the host platform.
/// ? .setDouble(String key, double value) → Future<bool>
///   Saves a double value to persistent storage in the background.
/// ? .setStringList(String key, List<String> value) → Future<bool>
///   Saves a list of strings value to persistent storage in the background.
/// {@endtemplate}
class SharedPrefsApi extends LocalStorageApi {
  /// {@macro storage_repository}
  SharedPrefsApi._init();

  static Future<SharedPrefsApi> init({SharedPreferences? instance}) async {
    final sharedPrefsApi = SharedPrefsApi._init();
    if (instance == null) {
      await sharedPrefsApi.initSharedPrefs();
    }
    return sharedPrefsApi;
  }

  Future<void> initSharedPrefs() async {
    _instance = await SharedPreferences.getInstance();
  }

  // Future<SharedPreferences> get _instance async => SharedPreferences.getInstance();

  late SharedPreferences _instance;

  /// Clear all values from storage.
  @override
  Future<void> clear() async {
    await _clear();
  }

  Future<void> _clear() async {
    /// Completes with true once the user preferences for the app has been cleared.
    await _instance.clear();
  }

  @override
  bool containsKey(String key) => _containsKey(key);

  bool _containsKey(String key) {
    /// Returns true if persistent storage the contains the given key.
    return _instance.containsKey(key);
  }

  /// Return a value for the given [key].
  ///
  /// Throws ArgumentError if the type on [T] isn't supported.
  @override
  T? read<T>(String key) {
    return _readValue<T>(key);
  }

  /// `_readValue`:
  ///
  /// Reads a value of any type from persistent storage.
  /// Not all public methods from the API have been implemented.
  /// Feel free to add more as needed.
  ///
  /// ? .getDouble(String key) → double?
  ///   Reads a value from persistent storage, throwing an exception if it's not a double.
  ///   .getKeys() → Set<String>
  ///   Returns all keys in the persistent storage.
  /// ? .getStringList(String key) → List<String>?
  ///   Reads a set of string values from persistent storage, throwing an exception if it's not a string set.
  ///
  T? _readValue<T>(String key) {
    // final instance = await _instance;
    final instance = _instance;
    if (T == String) {
      /// Reads a value from persistent storage, throwing an exception if it's not a String.
      return instance.getString(key) as T?;
    } else if (T == DateTime) {
      /// The `DateTime` type is an unlikely scenario considering any DateTime elements are
      /// converted to Strings with `.toIso8601String()` prior to storing.
      final rawValue = instance.getString(key);
      if (rawValue != null) {
        return DateTime.parse(rawValue) as T?;
      }
      return null;
    } else if (T == int) {
      /// Reads a value from persistent storage, throwing an exception if it's not an int.
      return instance.getInt(key) as T?;
    } else if (T == bool) {
      /// Reads a value from persistent storage, throwing an exception if it's not a bool.
      return instance.getBool(key) as T?;
    }
    throw ArgumentError('Unsupported type "$T"');
  }

  /// Write a value type [T] with the given [key].
  @override
  Future<void> write<T>(String key, T value) async {
    await _writeValue<T>(key, value);
  }

  Future<void> _writeValue<T>(String key, T value) async {
    final instance = _instance;
    if (T == String) {
      /// Saves a string value to persistent storage in the background.
      await instance.setString(key, value as String);
    } else if (T == DateTime) {
      await instance.setString(key, (value as DateTime).toIso8601String());
    } else if (T == int) {
      /// Saves an integer value to persistent storage in the background.
      await instance.setInt(key, value as int);
    } else if (T == bool) {
      /// Saves a boolean value to persistent storage in the background.
      await instance.setBool(key, value as bool);
    } else {
      throw ArgumentError('Unsupported type "$T"');
    }
  }

  /// Delete a value with the given [key];
  @override
  Future<void> delete(String key) async {
    /// Removes an entry from persistent storage.
    await _instance.remove(key);
  }

  /// Returns a collection of all the stored keys in the storage
  @override
  Set<String> storedKeys() {
    return _instance.getKeys();
  }
}
