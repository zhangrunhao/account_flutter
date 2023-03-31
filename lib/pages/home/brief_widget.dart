import 'package:account_flutter/bean/trade_bean.dart';
import 'package:account_flutter/model/trade_list.model.dart';
import 'package:account_flutter/widgets/trade_widget.dart';
import 'package:flutter/material.dart';
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
        return TradeWidget(trade: trade);
      },
    );
  }
}
