import 'package:account_flutter/bean/trade_cate_bean.dart';
import 'package:account_flutter/db/database_helper.dart';
import 'package:sqflite/sqflite.dart';

class TradeCateDB {
  static String tableName = "trade_cate";

  Future<List<TradeCateBean>> queryList(String? where) async {
    Database db = await DatabaseHelper.instance.database;
    List<Map> result = await db.query(tableName, where: where);
    return result.map((e) => TradeCateBean.fromJson(e)).toList();
  }

  Future<int> insert(TradeCateBean tradeCate) async {
    Database db = await DatabaseHelper.instance.database;
    int id = await db.insert(tableName, tradeCate.toMap());
    return id;
  }

  Future<int> update(TradeCateBean tradeCate) async {
    Database db = await DatabaseHelper.instance.database;
    int count = await db.update(tableName, tradeCate.toMap(), where: 'id=${tradeCate.id}');
    return count;
  }

  Future<int> delete(int id) async {
    Database db = await DatabaseHelper.instance.database;
    int count = await db.delete(tableName, where: 'id=$id');
    return count;
  }
}
