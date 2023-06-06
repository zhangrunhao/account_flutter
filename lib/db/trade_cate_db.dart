import 'package:account_flutter/bean/account_bean.dart';
import 'package:account_flutter/db/database_helper.dart';
import 'package:sqflite/sqflite.dart';

class TradeCateDB {
  static String tableName = "trade_cate";

  Future<List<AccountBean>> queryList(String? where) async {
    Database db = await DatabaseHelper.instance.database;
    List<Map> result = await db.query(tableName, where: where);
    return result.map((e) => AccountBean.fromJson(e)).toList();
  }
}
