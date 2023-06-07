import 'package:account_flutter/bean/trade_bean.dart';
import 'package:account_flutter/db/database_helper.dart';
import 'package:sqflite/sqflite.dart';

class TradeDB {
  static String tableName = "trade";

  Future<int> insert(TradeBean trade) async {
    Database db = await DatabaseHelper.instance.database;
    int id = await db.insert(tableName, trade.insertToMap());
    return id;
  }
}
