import 'dart:convert';

import 'package:account_flutter/api/token.dart';
import 'package:account_flutter/bean/trade_cate_bean.dart';
import 'package:dio/dio.dart';

class TradeCateApi {
  static Dio dio = Dio(BaseOptions(contentType: "application/json"));

  static Future<List<TradeCateBean>> getList() async {
    String? token = await Token.getToken();
    dio.options.headers["Authorization"] = "Bearer $token";
    Response response = await dio.get("http://127.0.0.1:3000/api/trade-cate");
    return (response.data['data'] as List)
        .map((e) => TradeCateBean.fromJson(e))
        .toList();
  }
}
