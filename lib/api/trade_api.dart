import 'package:account_flutter/api/my_dio.dart';
import 'package:account_flutter/bean/trade_bean.dart';
import 'package:dio/dio.dart';

class TradeApi {
  static Future<List<TradeBean>> getList(
    Map<String, dynamic>? queryParameters,
  ) async {
    Response? response =
        await MyDio.fetch('get', "/trade", queryParameters: queryParameters);
    if (response == null) {
      return [];
    } else {
      List<TradeBean> list = (response.data['data'] as List)
          .map((e) => TradeBean.fromJson(e))
          .toList();
      return list;
    }
  }

  static Future<void> create(TradeBean trade) async {
    await MyDio.fetch("post", "/trade", data: trade.toJson());
  }

  static Future<void> delete(TradeBean trade) async {
    await MyDio.fetch("delete", "/trade/${trade.id}");
  }

  static Future<void> update(TradeBean trade) async {
    await MyDio.fetch("put", "/trade/${trade.id}", data: trade.toJson());
  }
}
