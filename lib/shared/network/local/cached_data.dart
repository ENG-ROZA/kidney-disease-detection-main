import 'package:shared_preferences/shared_preferences.dart';

class CachedData {
  static late SharedPreferences sharedPreferences;
  static Future cacheInitialization() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> insertToCache(
      {required String key, required String value}) async {
    return await sharedPreferences.setString(key, value);
  }

  static String getFromCache(String key) {
    return sharedPreferences.getString(key) ?? ""; //? If
  }

  static Future<bool> deleteFromCache(String key) async {
    return await sharedPreferences.remove(key);
  }
}
