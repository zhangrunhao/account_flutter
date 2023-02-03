import 'dart:convert';

// import 'package:account_flutter/api/request.dart';
import 'package:account_flutter/api/token.dart';
import 'package:account_flutter/bean/trade_cate_bean.dart';
import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class TradeCateApi {
  static Dio dio = Dio(BaseOptions(contentType: "application/json"));

  static Future<List<TradeCateBean>> getList() async {
    String? token = await Token.getToken();
    dio.options.headers["Authorization"] = "Bearer $token";
    Response? response;
    try {
      response = await dio.get("http://127.0.0.1:3000/api/trade-cate");
    } catch (e) {
      if (e is DioError && e.response?.statusCode == 401) {

      }
    }
    return (response?.data['data'] as List)
        .map((e) => TradeCateBean.fromJson(e))
        .toList();
  }

  static Future<void> create(TradeCateBean tradeCate) async {
    EasyLoading.show(status: 'loading...');
    String? token = await Token.getToken();
    dio.options.headers["Authorization"] = "Bearer $token";
    await dio.post(
      "http://127.0.0.1:3000/api/trade-cate",
      data: jsonEncode(tradeCate),
    );
    EasyLoading.dismiss();
  }

  static Future<void> update(TradeCateBean tradeCate) async {
    EasyLoading.show(status: 'loading...');
    String? token = await Token.getToken();
    dio.options.headers["Authorization"] = "Bearer $token";
    await dio.put(
      "http://127.0.0.1:3000/api/trade-cate/${tradeCate.id}",
      data: jsonEncode(tradeCate),
    );
    EasyLoading.dismiss();
  }
}
