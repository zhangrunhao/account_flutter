import 'package:account_flutter/bean/trade_bean.dart';
import 'package:account_flutter/pages/trade/trade_page_app_bar.dart';
import 'package:account_flutter/pages/trade/trade_page_inner.dart';
import 'package:flutter/material.dart';

class TradePage extends StatelessWidget {
  const TradePage({super.key, this.tradeOrigin});

  final TradeBean? tradeOrigin; // 传过来的trade, 如果有, 就是更新, 没有就是新增

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Builder(
        builder: ((context) {
          final TabController tabController = DefaultTabController.of(context);
          return Scaffold(
            appBar: const TradePageAppBar(),
            body: SafeArea(
              child: TradePageInner(
                tabController: tabController,
                tradeOrigin: tradeOrigin,
              ),
            ),
          );
        }),
      ),
    );
  }
}
