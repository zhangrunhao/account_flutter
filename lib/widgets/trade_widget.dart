import 'package:account_flutter/bean/trade_bean.dart';
import 'package:flutter/material.dart';

class TradeWidget extends StatelessWidget {
  final TradeBean trade;
  final Function updateCallback;

  const TradeWidget(
      {super.key, required this.trade, required this.updateCallback});

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
                // 删除
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
