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
    // TODO: 插入交易记录的时候, 变更账户余额
    return id;
  }

  Future<int> update(TradeBean trade) async {
    Database db = await DatabaseHelper.instance.database;
    int count =
        await db.update(tableName, trade.toMap(), where: "id=${trade.id}");
    // TODO: 更新交易记录的时候, 要注意处理前后的账户余额
    return count;
  }
}
