import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static SharedPreferences? sharedPreferences;
  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }
  static Future<bool> putBool({
    required String key,
    required var value,
  }) async {
    return await sharedPreferences!.setBool(key, value);
  }

  static bool? getBool({
    required String key,
  }) {
    return sharedPreferences!.getBool(key);
  }

  static Future<bool> putDouble({
    required String key,
    required dynamic value,
  }) async {
    return await sharedPreferences!.setDouble(key, value);
  }

 static double? getDouble({
    required String key,
  }) {
    return sharedPreferences!.getDouble(key);
  }
}
