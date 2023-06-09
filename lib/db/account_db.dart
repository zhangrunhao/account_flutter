import 'package:account_flutter/bean/account_bean.dart';
import 'package:account_flutter/db/database_helper.dart';
import 'package:sqflite/sqflite.dart';

class AccountDB {
  static String tableName = "account";
  Future<List<AccountBean>> queryList(String? where) async {
    Database db = await DatabaseHelper.instance.database;
    List<Map> result = await db.query(tableName, where: where);
    return result.map((e) => AccountBean.fromJson(e)).toList();
  }

  Future<int> insert(AccountBean account) async {
    Database db = await DatabaseHelper.instance.database;
    // TODO: 新建账户的时候, 应该加入一个余额
    int id = await db.insert(tableName, account.toMap());
    return id;
  }

  Future<int> update(AccountBean account) async {
    Database db = await DatabaseHelper.instance.database;
    int count =
        await db.update(tableName, account.toMap(), where: "id=${account.id}");
    // TODO: 更新账户的时候, 也应该有平帐这个事 
    return count;
  }

  Future<int> delete(int id) async {
    Database db = await DatabaseHelper.instance.database;
    int count = await db.delete(tableName, where: "id=$id");
    return count;
  }
}
