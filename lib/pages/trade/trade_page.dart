import 'package:account_flutter/pages/trade/key_board.dart';
import 'package:account_flutter/pages/trade/my_tab_bar_view.dart';
import 'package:account_flutter/pages/trade/result_show.dart';
import 'package:account_flutter/pages/trade/tools_list.dart';
import 'package:account_flutter/pages/trade/trade_page_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:account_flutter/bean/trade_cate_bean.dart';

class TradePage extends StatefulWidget {
  const TradePage({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _TradePageState();
}

class _TradePageState extends State<TradePage> {
  TradeCateBean? _selectedTradeCate;
  String money = "0";

  void cateTapCallBack(TradeCateBean cate) {
    setState(() {
      _selectedTradeCate = cate;
    });
  }

  void moneyChangeCallBack(String nowMoney) {
    setState(() {
      money = nowMoney;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Builder(
        builder: ((context) {
          final TabController tabController = DefaultTabController.of(context);
          tabController.addListener(() {
            // TODO: 切换tab后, 切换选中的图标
            if (!tabController.indexIsChanging) {
              // tabController.index: 0-> income, 1->expend, 2->transfer
            }
          });
          return Scaffold(
            appBar: const TradePageAppBar(),
            body: SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: MyTabBarView(
                      tabController: tabController,
                      callBack: cateTapCallBack,
                    ),
                  ),
                  ResultShow(
                    cate: _selectedTradeCate,
                    money: money,
                  ),
                  const ToolsList(),
                  KeyBoard(money: money, callBack: moneyChangeCallBack),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
