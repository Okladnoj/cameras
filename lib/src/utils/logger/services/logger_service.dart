import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoggerService {
  static const _key = 'keyLoggerService';
  late final SharedPreferences _preferences;

  LoggerService._(this._preferences);

  static Future<LoggerService> get instance async {
    final result = LoggerService._(await SharedPreferences.getInstance());
    result._preferences.setStringList(_key, []);
    return result;
  }

  Future<bool> setString(String text) async {
    final list = _preferences.getStringList(_key) ?? [];
    return _preferences.setStringList(_key, [...list, text]);
  }

  Future<void> showString(BuildContext context) async {
    final list = _preferences.getStringList(_key) ?? [];
    if (list.isEmpty) return;

    final text = list.removeAt(0);
    _preferences.setStringList(_key, list);

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(text),
    ));
  }
}
