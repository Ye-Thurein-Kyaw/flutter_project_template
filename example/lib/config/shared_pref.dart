import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  late SharedPreferences _prefs;

  Preferences._private();

  static final _instance = Preferences._private();

  factory Preferences() {
    return _instance;
  }

  Future<void> initPreferences() async {
    _prefs = await SharedPreferences.getInstance();
  }

  void setString(PrefKey key, String value) {
    _prefs.setString(key.key, value);
  }

  String? getString(PrefKey key) {
    return _prefs.getString(key.key);
  }

  void setInt(PrefKey key, int value) {
    _prefs.setInt(key.key, value);
  }

  int? getInt(PrefKey key) {
    return _prefs.getInt(key.key);
  }

  void setBool(PrefKey key, bool value) {
    _prefs.setBool(key.key, value);
  }

  bool? getBool(PrefKey key) {
    return _prefs.getBool(key.key);
  }

  void setDouble(PrefKey key, double value) {
    _prefs.setDouble(key.key, value);
  }

  double? getDouble(PrefKey key) {
    return _prefs.getDouble(key.key);
  }

  void setStringList(PrefKey key, List<String> value) {
    _prefs.setStringList(key.key, value);
  }

  List<String>? getStringList(PrefKey key) {
    return _prefs.getStringList(key.key);
  }

  bool containsKey(PrefKey key) {
    return _prefs.containsKey(key.key);
  }

  void remove(PrefKey key) {
    _prefs.remove(key.key);
  }

  void clear() {
    _prefs.clear();
  }

  void reload() {
    _prefs.reload();
  }

  /// Use this method only for dynamic keys.
  /// Dynamic keys are those that are not predefined in the project
  /// and can change frequently.
  ///
  /// Example usage:
  /// ```dart
  /// setManual<bool>('isFeatureEnabled', true);
  /// setManual<int>('userAge', 30);
  /// setManual<String>('customMessage', 'Hello');
  /// setManual<List<String>>('userRoles', ['Admin', 'Editor']);
  /// ```
  void setManual<T>(String key, T value) {
    if (value is bool) {
      _prefs.setBool(key, value);
    } else if (value is String) {
      _prefs.setString(key, value);
    } else if (value is int) {
      _prefs.setInt(key, value);
    } else if (value is double) {
      _prefs.setDouble(key, value);
    } else if (value is List<String>) {
      _prefs.setStringList(key, value);
    }
  }

  /// Use this method only for dynamic keys.
  /// Dynamic keys are those that are not predefined in the project
  /// and can change frequently.
  ///
  /// Example usage:
  /// ```dart
  /// bool? isFeatureEnabled = getManual<bool>('isFeatureEnabled');
  /// int? userAge = getManual<int>('userAge');
  /// String? customMessage = getManual<String>('customMessage');
  /// List<String>? userRoles = getManual<List<String>>('userRoles');
  /// ```
  T? getManual<T>(String key) {
    if (T is bool) {
      return _prefs.getBool(key) as T?;
    } else if (T is String) {
      return _prefs.getString(key) as T?;
    } else if (T is int) {
      return _prefs.getInt(key) as T?;
    } else if (T is double) {
      return _prefs.getDouble(key) as T?;
    } else if (T is List<String>) {
      return _prefs.getStringList(key) as T?;
    }
    return null;
  }
  
  final String _isDarkMode = 'isDarkMode';

  ThemeMode getDarkMode() {
    final darkMode = _prefs.getBool(_isDarkMode) ?? false;
    return darkMode ? ThemeMode.dark : ThemeMode.light;
  }

  void setDarkMode(bool darkMode) {
    _prefs.setBool(_isDarkMode, darkMode);
  }

  final String _locale = 'locale';

  String getLocale() {
    return _prefs.getString(_locale) ?? 'en-US';
  }

  void setLocale(String locale) {
    _prefs.setString(_locale, locale);
  }
}
enum PrefKey {  
  firstRun('first_run'),
  locale('locale'),;
  
  final String key;
  const PrefKey(this.key);
}
