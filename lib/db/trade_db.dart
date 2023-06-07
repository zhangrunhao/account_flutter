import 'package:account_flutter/bean/trade_bean.dart';
import 'package:account_flutter/db/database_helper.dart';
import 'package:sqflite/sqflite.dart';

class TradeDB {
  static String tableName = "trade";

  Future queryList(String? where) async {
    Database db = await DatabaseHelper.instance.database;
    List result = await db.query("v_trade", where: where);
    return result.map((e) => TradeBean.fromJson(e)).toList();
  }

  Future<int> insert(TradeBean trade) async {
    Database db = await DatabaseHelper.instance.database;
    int id = await db.insert(tableName, trade.toMap());
    return id;
  }
}
