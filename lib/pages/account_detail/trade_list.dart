import 'package:account_flutter/bean/trade_bean.dart';
import 'package:account_flutter/widgets/trade_widget.dart';
import 'package:flutter/material.dart';

class TradeList extends StatelessWidget {
  final List<TradeBean> trades;

  const TradeList({super.key, required this.trades});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: trades.length,
      itemBuilder: (context, index) {
        TradeBean trade = trades[index];
        return TradeWidget(
          trade: trade,
          callback: () {},
        );
      },
    );
  }
}
