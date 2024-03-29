import 'package:account_flutter/bean/account_bean.dart';
import 'package:account_flutter/bean/trade_bean.dart';
import 'package:account_flutter/db/database_helper.dart';
import 'package:sqflite/sqflite.dart';

class TradeDB {
  Future queryList(String? where) async {
    Database db = await DatabaseHelper.instance.database;
    List result = await db.query("v_trade", where: where);
    return result.map((e) => TradeBean.fromJson(e)).toList();
  }

  Future<int> insert(TradeBean trade) async {
    Database db = await DatabaseHelper.instance.database;
    return await db.transaction((Transaction txn) async {
      // 查询当前账户
      List accounts =
          await txn.query("account", where: "id=${trade.accountId}");
      AccountBean account = AccountBean.fromJson(accounts.first);
      // 根据操作, 判断加减
      if (trade.sign == 'add') {
        // 收入
        account.money = account.money + trade.money;
      } else if (trade.sign == 'minus') {
        // 支出
        account.money = account.money - trade.money;
      }
      // 更新账户
      await txn.update("account", account.toMap(),
          where: 'id=${trade.accountId}');
      // 插入记录
      return await txn.insert("trade", trade.toMap());
    });
  }

  Future<void> update(TradeBean trade, TradeBean preTrade) async {
    Database db = await DatabaseHelper.instance.database;
    await db.transaction((txn) async {
      // 针对上一个账户的操作
      List preAccounts =
          await txn.query("account", where: 'id=${preTrade.accountId}');
      if (preAccounts.isNotEmpty) {
        // 存在上一个账户
        AccountBean preAccount = AccountBean.fromJson(preAccounts.first);
        if (preTrade.sign == "add") {
          preAccount.money = preTrade.money - trade.money;
        } else if (preTrade.sign == 'minus') {
          preAccount.money = preTrade.money + trade.money;
        }
        await txn.update("account", preAccount.toMap(),
            where: "id=${preAccount.id}");
      }

      // 针对当前账户的操作, 当前账户一定是存在的
      List nowAccounts =
          await txn.query("account", where: 'id=${trade.accountId}');
      AccountBean nowAccount = AccountBean.fromJson(nowAccounts.first);
      if (preTrade.sign == "add") {
        nowAccount.money = nowAccount.money + trade.money;
      } else if (preTrade.sign == 'minus') {
        nowAccount.money = nowAccount.money - trade.money;
      }
      await txn.update("account", nowAccount.toMap(),
          where: "id=${nowAccount.id}");
      await txn.update("trade", trade.toMap(), where: "id=${trade.id}");
    });
  }

  Future<void> delete(TradeBean trade) async {
    Database db = await DatabaseHelper.instance.database;
    await db.transaction((txn) async {
      List accounts =
          await txn.query("account", where: 'id=${trade.accountId}');
      if (accounts.isNotEmpty) {
        // 之前的账户可能不存在
        AccountBean account = AccountBean.fromJson(accounts.first);
        if (trade.sign == "add") {
          account.money = account.money + trade.money;
        } else if (trade.sign == 'minus') {
          account.money = account.money - trade.money;
        }
        await txn.update("account", account.toMap(),
            where: "id=${trade.accountId}");
      }
      await txn.update("trade", trade.toMap(), where: "id=${trade.id}");
    });
  }
}
