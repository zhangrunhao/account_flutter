import 'dart:collection';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class Request {
  static Dio dio = Dio(BaseOptions(contentType: "application/json"));

  static String baseUrl = 'http://127.0.0.1:3000/api';

  static Future<T> get<T>(String url, BuildContext context) async {
    Response? response;
    try {
      response = await dio.get("$baseUrl/trade-cate");
    } catch (e) {
      if (e is DioError && e.response?.statusCode == 401) {
        Navigator.of(context).pushNamed("login");
      }
    }
    return response?.data['data'] as T;
  }
}
