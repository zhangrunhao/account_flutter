import 'package:account_flutter/api/token.dart';
import 'package:account_flutter/util/event_bus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class MyDio {
  static Dio dio = Dio(
    BaseOptions(
      contentType: "application/json",
      baseUrl: "http://127.0.0.1:3000/api",
    ),
  );

  static EventBus bus = EventBus();

  static Future<Response?> fetch(method, url, data) async {
    EasyLoading.show(status: 'loading...');
    String? token = await Token.getToken();
    dio.options.headers["Authorization"] = "Bearer $token";
    Response? response;
    try {
      switch (method) {
        case 'get':
          response = await dio.get(url);
          break;
        case 'post':
          response = await dio.post(url, data: data);
          break;
        case 'put':
          response = await dio.put(url, data: data);
          break;
        case 'delete':
          response = await dio.delete(url, data: data);
          break;
        default:
      }
    } catch (e) {
      if (e is DioError && e.response?.statusCode == 401) {
        bus.emit("toLogin");
      }
    }
    EasyLoading.dismiss();
    return response;
  }
}
