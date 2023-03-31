import 'package:account_flutter/api/trade_api.dart';
import 'package:account_flutter/bean/trade_bean.dart';
import 'package:account_flutter/model/trade_list.model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

class BriefWidget extends StatelessWidget {
  const BriefWidget({super.key});

  @override
  Widget build(BuildContext context) {
    TradeListModel tradesModule = context.watch<TradeListModel>();
    List<TradeBean> trades = tradesModule.trades;
    return ListView.builder(
      itemCount: trades.length,
      itemBuilder: (BuildContext context, int index) {
        TradeBean trade = trades[index];
        String moneyStr = trade.money.toString();
        return Card(
          child: ListTile(
            title: Text(trade.tradeCateName),
            subtitle: Text('金额:$moneyStr元 | 备注:${trade.remark}'),
            trailing: PopupMenuButton<int>(
              onSelected: (value) {
                switch (value) {
                  case 0:
                    Navigator.of(context).pushNamed(
                      "trade",
                      arguments: trade,
                    );
                    break;
                  case 1:
                    TradeApi.delete(trade).then((value) {
                      tradesModule.update().then((value) {
                        EasyLoading.showSuccess("删除成功");
                      });
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
      },
    );
  }
}
