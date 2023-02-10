import 'package:account_flutter/api/my_dio.dart';
import 'package:account_flutter/bean/account_bean.dart';
import 'package:dio/dio.dart';

class AccountApi {
  static Future<List<AccountBean>> getList() async {
    Response? response = await MyDio.fetch("get", "/account", {});
    if (response == null) {
      return [];
    } else {
      return (response.data['data'] as List)
          .map((e) => AccountBean.fromJson(e))
          .toList();
    }
  }
}
