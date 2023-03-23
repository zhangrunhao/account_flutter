import 'package:account_flutter/api/my_dio.dart';
import 'package:account_flutter/bean/trade_bean.dart';
import 'package:dio/dio.dart';

class TradeApi {
  static Future<List<TradeBean>> getList() async {
    Response? response = await MyDio.fetch('get', "/trade", {});
    if (response == null) {
      return [];
    } else {
      return (response.data['data'] as List)
          .map((e) => TradeBean.fromJson(e))
          .toList();
    }
  }

  static Future<void> create(TradeBean trade) async {
    await MyDio.fetch("post", "/trade", trade.toJson());
  }

  static Future<void> delete(TradeBean trade) async {
    await MyDio.fetch("delete", "/trade/${trade.id}", {});
  }

  static Future<void> update(TradeBean trade) async {
    await MyDio.fetch("put", "/trade/${trade.id}", trade.toJson());
  }
}
