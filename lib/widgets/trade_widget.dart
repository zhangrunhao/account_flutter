import 'package:account_flutter/bean/trade_bean.dart';
import 'package:flutter/material.dart';

class TradeWidget extends StatelessWidget {
  final TradeBean trade;

  const TradeWidget({super.key, required this.trade});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(trade.tradeCateName),
        subtitle: Text('金额:${trade.money.toString()}元 | 备注:${trade.remark}'),
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
                // TradeApi.delete(trade).then((value) {
                //   tradesModule.update().then((value) {
                //     EasyLoading.showSuccess("删除成功");
                //   });
                // });
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
