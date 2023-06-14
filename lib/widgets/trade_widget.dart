import 'package:account_flutter/bean/trade_bean.dart';
import 'package:account_flutter/db/trade_db.dart';
import 'package:account_flutter/util/show_dialog.dart';
import 'package:flutter/material.dart';

class TradeWidget extends StatelessWidget {
  final TradeBean trade;
  final Function updateCallback;
  final Function deleteCallback;
  final TradeDB _tradeDB = TradeDB();

  TradeWidget(
      {super.key, required this.trade, required this.updateCallback, required this.deleteCallback});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(trade.tradeCateName),
        subtitle: Text('金额:${trade.money.toString()}元 | 备注:${trade.remark}'),
        tileColor: trade.sign == "add" ? Colors.green[300] : Colors.red[300],
        trailing: PopupMenuButton<int>(
          onSelected: (value) {
            switch (value) {
              case 0:
                // 收入支出的时候, 才允许编辑
                if (trade.operate == 1 || trade.operate == 2) {
                  // 更新
                  Navigator.of(context)
                      .pushNamed(
                    "trade",
                    arguments: trade,
                  )
                      .then((value) {
                    if (value is TradeBean) updateCallback(value);
                  });
                }
                break;
              case 1:
                showDeleteConfirmDialog(context, "确定删除这个交易记录吗?").then((del)  {
                  if (del == null) {
                  } else {
                    _tradeDB.delete(trade).then((value) {
                      deleteCallback(trade.id);
                    });
                  }
                });
                break;
              default:
            }
          },
          padding: EdgeInsets.zero,
          itemBuilder: (context) => const <PopupMenuItem<int>>[
            PopupMenuItem<int>(
              value: 0,
              child: Text("修改"),
            ),
            PopupMenuItem<int>(
              value: 1,
              child: Text("删除"),
            ),
          ],
        ),
      ),
    );
  }
}
