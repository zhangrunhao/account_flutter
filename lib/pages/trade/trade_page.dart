import 'package:account_flutter/pages/trade/cate_list.dart';
import 'package:account_flutter/pages/trade/key_board.dart';
import 'package:account_flutter/pages/trade/result_show.dart';
import 'package:account_flutter/pages/trade/tools_list.dart';
import 'package:flutter/material.dart';
import 'package:account_flutter/bean/account_bean.dart';

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

List<TradeCateBean> cates1 = <TradeCateBean>[
  TradeCateBean(
    icon:
        "https://zhangrunhao.oss-cn-beijing.aliyuncs.com/account-icon/icons-ali/boots.png",
    name: "鞋子",
  ),
  TradeCateBean(
    icon:
        "https://zhangrunhao.oss-cn-beijing.aliyuncs.com/account-icon/icons-ali/car.png",
    name: "交通",
  ),
];

List<TradeCateBean> cates2 = <TradeCateBean>[
  TradeCateBean(
    icon:
        "https://zhangrunhao.oss-cn-beijing.aliyuncs.com/account-icon/icons-ali/boots.png",
    name: "鞋子",
  )
];

class TradePage extends StatefulWidget {
  const TradePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TradePageState();
}

class _TradePageState extends State<TradePage> {
  TradeCateBean _selectedTradeCate = cates1.first;
  String money = "0";

  void cateTapCallBack(TradeCateBean cate) {
    setState(() {
      _selectedTradeCate = cate;
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
            if (!tabController.indexIsChanging) {
              // debugPrint(tabController.index.toString());
            }
          });
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              leading: GestureDetector(
                onTap: (() {
                  Navigator.pop(context);
                }),
                child: const Icon(Icons.arrow_back),
              ),
              title: const TabBar(
                tabs: tabs,
              ),
            ),
            body: SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: TabBarView(controller: tabController, children: [
                      CateList(
                        cates: cates1,
                        callBack: cateTapCallBack,
                      ),
                      CateList(
                        cates: cates2,
                        callBack: cateTapCallBack,
                      ),
                      const Center(
                        child: Text(
                          "转账",
                          style: TextStyle(fontSize: 30),
                        ),
                      ),
                    ]),
                  ),
                  ResultShow(cate: _selectedTradeCate, money: money,),
                  const ToolsList(),
                  KeyBoard(money: money, callBack: (String moneyRes) => {
                    setState(() {
                      money = moneyRes;
                    })
                  }),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
