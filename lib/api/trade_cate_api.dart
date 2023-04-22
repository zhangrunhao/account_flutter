
import 'package:account_flutter/api/my_dio.dart';
import 'package:account_flutter/bean/trade_cate_bean.dart';
import 'package:dio/dio.dart';

class TradeCateApi {
  static Future<List<TradeCateBean>> getList() async {
    Response? response = await MyDio.fetch('get', "/trade-cate");
    if (response == null) {
      return [];
    } else {
      return (response.data['data'] as List)
          .map((e) => TradeCateBean.fromJson(e))
          .toList();
    }
  }

  static Future<void> create(TradeCateBean tradeCate) async {
    await MyDio.fetch(
      "post",
      "/trade-cate",
      data: tradeCate.toJson,
    );
  }

  static Future<void> update(TradeCateBean tradeCate) async {
    await MyDio.fetch("put", "/trade-cate/${tradeCate.id}",
        data: tradeCate.toJson());
  }

  static Future<void> delete(TradeCateBean tradeCate) async {
    await MyDio.fetch("delete", "/trade-cate/${tradeCate.id}");
  }
}
