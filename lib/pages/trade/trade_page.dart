import 'package:account_flutter/api/trade_cate.dart';
import 'package:account_flutter/pages/trade/cate_list.dart';
import 'package:account_flutter/pages/trade/key_board.dart';
import 'package:account_flutter/pages/trade/result_show.dart';
import 'package:account_flutter/pages/trade/tools_list.dart';
import 'package:flutter/material.dart';
import 'package:account_flutter/bean/trade_cate_bean.dart';

const List<Tab> tabs = <Tab>[
  Tab(
    text: '收入',
  ),
  Tab(
    text: '支出',
  ),
  Tab(
    text: '转帐',
  ),
];

TradeCateBean settingCate = TradeCateBean(
    name: "编辑",
    icon: "images/setting.png",
    id: 0,
    type: "",
    operate: "operate");

class TradePage extends StatefulWidget {
  const TradePage({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _TradePageState();
}

class _TradePageState extends State<TradePage> {
  List<TradeCateBean> incomeCates = [];
  List<TradeCateBean> expendCates = [];
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
  void initState() {
    super.initState();
    TradeCateApi.getList().then((value) => {
          setState(() {
            incomeCates =
                value.where((element) => element.operate == "Income").toList();
            expendCates =
                value.where((element) => element.operate == "Expend").toList();
            incomeCates.add(settingCate);
            expendCates.add(settingCate);

            _selectedTradeCate = incomeCates[0];
          })
        });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Builder(
        builder: ((context) {
          final TabController tabController = DefaultTabController.of(context)!;
          tabController.addListener(() {
            if (!tabController.indexIsChanging &&
                incomeCates.length > 1 &&
                expendCates.length > 1) {
              // index: 0-> income, 1->expend, 2->transfer
              if (tabController.index == 0) {
                setState(() {
                  _selectedTradeCate = incomeCates[0];
                });
              } else if (tabController.index == 1) {
                setState(() {
                  _selectedTradeCate = expendCates[0];
                });
              }
            }
          });
          return Scaffold(
            appBar: _buildAppBar(context),
            body: SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: _buildTabBarView(tabController, incomeCates,
                        expendCates, cateTapCallBack),
                  ),
                  ResultShow(
                    cate: _selectedTradeCate,
                    money: money,
                  ),
                  const ToolsList(),
                  _buildKeyBoard(money, moneyChangeCallBack),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

Widget _buildTabBarView(
    TabController tabController,
    List<TradeCateBean> incomeCates,
    List<TradeCateBean> expendCates,
    TapCateListCallBack callBack) {
  return TabBarView(controller: tabController, children: [
    CateList(
      cates: incomeCates,
      callBack: callBack,
    ),
    CateList(
      cates: expendCates,
      callBack: callBack,
    ),
    const Center(
      child: Text(
        "转账",
        style: TextStyle(fontSize: 30),
      ),
    ),
  ]);
}

PreferredSizeWidget _buildAppBar(BuildContext context) {
  return AppBar(
    title: const TabBar(
      tabs: tabs,
    ),
    actions: [
      SizedBox(
        width: 80,
        child: GestureDetector(
          onTap: (() {
            print("设置");
          }),
          child: const Icon(Icons.settings),
        ),
      ),
    ],
  );
}

Widget _buildKeyBoard(String money, MoneyChangeCallBack callBack) {
  return KeyBoard(money: money, callBack: callBack);
}
