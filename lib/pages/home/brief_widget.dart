import 'package:account_flutter/bean/trade_bean.dart';
import 'package:account_flutter/model/trade_list.model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BriefWidget extends StatelessWidget {
  const BriefWidget({super.key});

  @override
  Widget build(BuildContext context) {
    List<TradeBean> trades = context.watch<TradeListModel>().trades;
    return ListView.builder(
      itemCount: trades.length,
      itemBuilder: (BuildContext context, int index) {
        TradeBean trade = trades[index];
        String moneyStr = trade.money.toString();
        return Card(
          child: ListTile(
            title: Text(trade.tradeCateName),
            subtitle: Text('金额: $moneyStr ${trade.remark}'),
            trailing: PopupMenuButton<String>(
              padding: EdgeInsets.zero,
              itemBuilder: (context) => const <PopupMenuItem<String>>[
                PopupMenuItem<String>(
                  child: Text("修改"),
                ),
                PopupMenuItem<String>(
                  child: Text("删除"),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
