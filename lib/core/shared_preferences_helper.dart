import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static SharedPreferences? _sharedPreferences;

  static Future<void> init() async {
    _sharedPreferences ??= await SharedPreferences.getInstance();
  }

  static setString(String key, String value) {
    _sharedPreferences!.setString(key, value);
  }

  static String? getString(String key) {
    return _sharedPreferences!.getString(key);
  }

  static setBool(String key, bool value) async {
    _sharedPreferences!.setBool(key, value);
  }

  static bool getBool(String key) {
    return _sharedPreferences?.getBool(key) ?? false;
  }

  static remove(String key) {
    return _sharedPreferences!.remove(key);
  }
}
