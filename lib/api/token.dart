import 'package:shared_preferences/shared_preferences.dart';

class Token {
  static const String tokenHeader = "user_token";
  static Future<bool> setToken(String token) async {
    final SharedPreferences perfs = await SharedPreferences.getInstance();
    return await perfs.setString(Token.tokenHeader, token);
  }

  static Future<String?> getToken() async {
    final SharedPreferences perfs = await SharedPreferences.getInstance();
    return perfs.getString(Token.tokenHeader);
  }

  static Future<bool> remove() async {
    final SharedPreferences perfs = await SharedPreferences.getInstance();
    return await perfs.remove(Token.tokenHeader);
  }
}
