import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static SharedPreferences? sharedPreferences;

  // Initialize SharedPreferences instance
  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  // Save data in local database
  static Future<bool> saveData({
    required String key,
    required dynamic value,
  }) async {
    if (value is String) return await sharedPreferences!.setString(key, value);
    if (value is int) return await sharedPreferences!.setInt(key, value);
    if (value is bool) return await sharedPreferences!.setBool(key, value);
    if (value is double) return await sharedPreferences!.setDouble(key, value);
    return false;
  }

  // Get data already saved in local database
  static dynamic getData(String key) {
    return sharedPreferences!.get(key);
  }

  // Delete data
  static Future<bool> removeData(String key) async {
    return await sharedPreferences!.remove(key);
  }

  // Clear all saved data (for logout or reset)
  static Future<bool> clearData() async {
    return await sharedPreferences!.clear();
  }
}
