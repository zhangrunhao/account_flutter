import 'dart:convert';

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

  static Future<AccountBean> get(int id) async {
    Response? response = await MyDio.fetch("get", "/account/$id", {});
    if (response == null) {
      return AccountBean(id: 3, name: "name", cate: "cate", icon: "icon");
    } else {
      return AccountBean.fromJson(response.data['data']);
    }
  }

  static Future<void> create(AccountBean account) async {
    await MyDio.fetch("post", "/account", jsonEncode(account));
  }

  static Future<void> update(AccountBean account) async {
    await MyDio.fetch("put", "/account/${account.id}", jsonEncode(account));
  }
}
