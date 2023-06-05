// import 'package:account_flutter/api/config.dart';
import 'package:account_flutter/api/my_dio.dart';
import 'package:account_flutter/api/token.dart';
import "package:dio/dio.dart";

class UserToken {
  final String token;

  const UserToken({required this.token});

  factory UserToken.fromJson(Map<String, dynamic> json) {
    return UserToken(token: json['access_token'] as String);
  }
}

class UserApi {
  static Dio dio = Dio();

  static Future<bool> login(String email, String password) async {
    try {
      Response? response = await MyDio.fetch(
        "post",
        "/user/login",
        data: {"email": email, "password": password},
      );
      if (response != null) {
        UserToken userToken = UserToken.fromJson(response.data['data']);
        return await Token.setToken(userToken.token);
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
