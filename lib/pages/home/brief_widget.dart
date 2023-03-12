import 'package:account_flutter/api/trade_api.dart';
import 'package:account_flutter/bean/trade_bean.dart';
import 'package:flutter/material.dart';

class BriefWidget extends StatefulWidget {
  const BriefWidget({super.key});

  @override
  State<StatefulWidget> createState() => _BriefWidgetState();
}

class _BriefWidgetState extends State {
  List<TradeBean>? trades;
  @override
  void initState() {
    super.initState();
    TradeApi.getList().then((List<TradeBean> value) {
      setState(() {
        trades = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (trades == null) {
      return const Center(
        child: Text("暂无数据"),
      );
    } else {
      return ListView.builder(
        itemCount: trades?.length,
        itemBuilder: (BuildContext context, int index) {
          TradeBean trade = trades![index];
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
}
