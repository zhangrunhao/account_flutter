import 'package:account_flutter/bean/account_bean.dart';
import 'package:account_flutter/db/database_helper.dart';
import 'package:sqflite/sqflite.dart';

class AccountDB {
  Future<List<AccountBean>> queryList(String? where) async {
    Database db = await DatabaseHelper.instance.database;
    List<Map> result = await db.query("account", where: where);
    return result.map((e) => AccountBean.fromJson(e)).toList();
  }

  Future<AccountBean> queryById(int id) async {
    Database db = await DatabaseHelper.instance.database;
    List<Map> result = await db.query("account", where: 'id=$id');
    return AccountBean.fromJson(result.first);
  }

  Future<void> insert(AccountBean account) async {
    Database db = await DatabaseHelper.instance.database;
    db.transaction((txn) async {
      int accountId = await txn.insert("account", account.toMap());
      await txn.insert("trade", {
        "account_id": accountId,
        "trade_cate_id": 1, // TODO: 此处应该是默认的初始化的分类id,
        "money": account.money,
        "spend_date": DateTime.now().toString(),
        "remark": "初始化账户",
        "sign": "add",
      });
    });
  }

  Future<void> update(AccountBean account, AccountBean preAccount) async {
    Database db = await DatabaseHelper.instance.database;

    db.transaction((txn) async {
      await txn.update("account", account.toMap(), where: "id=${account.id}");
      await txn.insert("trade", {
        "account_id": account.id,
        "trade_cate_id": 1, // TODO: 此处应该是默认的初始化的分类id,
        "money": (account.money - preAccount.money).abs(),
        "spend_date": DateTime.now().toString(),
        "remark": "初始化账户",
        "sign": preAccount.money < account.money ? "add" : "minus",
      });
    });
  }

  Future<int> delete(int id) async {
    Database db = await DatabaseHelper.instance.database;
    int count = await db.delete("account", where: "id=$id");
    return count;
  }
}
