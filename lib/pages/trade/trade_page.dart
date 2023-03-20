import 'dart:async';

import 'package:account_flutter/api/trade_api.dart';
import 'package:account_flutter/bean/account_bean.dart';
import 'package:account_flutter/bean/trade_bean.dart';
import 'package:account_flutter/model/account_list_model.dart';
import 'package:account_flutter/model/trade_cate_list_model.dart';
import 'package:account_flutter/model/trade_list.model.dart';
import 'package:account_flutter/pages/trade/key_board.dart';
import 'package:account_flutter/pages/trade/my_tab_bar_view.dart';
import 'package:account_flutter/pages/trade/result_show.dart';
import 'package:account_flutter/pages/trade/tools_list.dart';
import 'package:account_flutter/pages/trade/trade_page_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:account_flutter/bean/trade_cate_bean.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

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
          return _TradePage(
            tabController: tabController,
            tradeOrigin: tradeOrigin,
          );
        }),
      ),
    );
  }
}

class _TradePage extends StatefulWidget {
  const _TradePage({
    required this.tabController,
    this.tradeOrigin,
  });
  final TabController tabController;
  final TradeBean? tradeOrigin;
  @override
  State<StatefulWidget> createState() => _TradePageState();
}

class _TradePageState extends State<_TradePage> {
  TradeCateBean? _selectedTradeCate;
  AccountBean? _selectAccount;
  DateTime _spendDate = DateTime.now();
  String money = "0";

  @override
  void initState() {
    super.initState();
    setDefaultCate();
    setDefaultTradeData();
    widget.tabController.addListener(() {
      if (widget.tabController.indexIsChanging) {
        setDefaultCate();
      }
    });
  }

  void setDefaultTradeData() {
    TradeBean? tradeBean = widget.tradeOrigin;
    if (tradeBean == null) return;
    // 处理账户
    AccountBean? account;
    List<AccountBean> accounts = context.read<AccountListModel>().accounts;
    for (var element in accounts) {
      if (element.id == tradeBean.accountId) {
        account = element;
      }
    }
    // 处理分类
    TradeCateBean? tradeCate;
    List<TradeCateBean> cates = context.read<TradeCateListModel>().cates;
    for (var element in cates) {
      if (element.id == tradeBean.tradeCateId) {
        tradeCate = element;
      }
    }
    if (tradeCate != null && tradeCate.operate == "Income") {
      widget.tabController.animateTo(0);
    } else if (tradeCate != null && tradeCate.operate == "Expend") {
      widget.tabController.animateTo(1);
    }
    setState(() {
      _selectedTradeCate = tradeCate;
      _selectAccount = account;
      _spendDate = tradeBean.spendDate;
      money = tradeBean.money.toString();
    });
  }

  void setDefaultCate() {
    var incomeCates = context.read<TradeCateListModel>().incomeCates;
    var expendCates = context.read<TradeCateListModel>().expendCates;
    if (incomeCates.isEmpty && expendCates.isEmpty) {
      // 递归查看是否有值了
      Timer(
        const Duration(
          milliseconds: 500,
        ),
        () {
          setDefaultCate();
        },
      );
      return;
    }
    setState(() {
      // tabController.index: 0-> income, 1->expend, 2->transfer
      _selectedTradeCate =
          widget.tabController.index == 0 ? incomeCates[0] : expendCates[0];
    });
  }

  void cateTapCallBack(TradeCateBean cate) {
    setState(() {
      _selectedTradeCate = cate;
    });
  }

  void accountSelectCallBack(AccountBean account) {
    setState(() {
      _selectAccount = account;
    });
  }

  void spendDateSelectCallBack(DateTime spendDate) {
    setState(() {
      _spendDate = spendDate;
    });
  }

  void moneyChange(String nowMoney) {
    setState(() {
      money = nowMoney;
    });
  }

  void saveTap(String money) {
    int operateIndex = widget.tabController.index;
    String? operate;
    if (operateIndex == 0) {
      operate = "Income";
    } else if (operateIndex == 1) {
      operate = "Expend";
    }
    if (_selectAccount != null &&
        _selectedTradeCate != null &&
        operate != null) {
      // TODO: 处理备注
      TradeBean trade = TradeBean(
        id: 0,
        accountName: _selectAccount!.name,
        accountId: _selectAccount!.id,
        tradeCateName: _selectedTradeCate!.name,
        tradeCateId: _selectedTradeCate!.id,
        money: int.parse(money),
        remark: "",
        spendDate: _spendDate,
        operate: operate,
      );
      // TODO: 如何区分添加还是修改?
      TradeApi.create(trade).then((value) {
        context.read<TradeListModel>().update().then(
          (value) {
            Navigator.of(context).pop();
            EasyLoading.showSuccess("添加成功");
          },
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TradePageAppBar(),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: MyTabBarView(
                tabController: widget.tabController,
                callBack: cateTapCallBack,
              ),
            ),
            ResultShow(
              cate: _selectedTradeCate,
              money: money,
            ),
            ToolsList(
              spendDate: _spendDate,
              account: _selectAccount,
              accountChange: accountSelectCallBack,
              spendDateChange: spendDateSelectCallBack,
            ),
            KeyBoard(
              money: money,
              moneyChange: moneyChange,
              onSaveTap: saveTap,
            ),
          ],
        ),
      ),
    );
  }
}
