import 'package:account_flutter/api/config.dart';
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
    String url = "${ConfigApi.baseUrl}/user/login";
    try {
      Response response = await dio.post("http://127.0.0.1:3000/api/user/login",
          data: {"email": email, "password": password},
          options: Options(contentType: "application/json"));
      UserToken userToken = UserToken.fromJson(response.data['data']);
      return await Token.setToken(userToken.token);
    } catch (e) {
      return false;
    }
  }
}
