import 'dart:async';

import 'package:account_flutter/api/trade_api.dart';
import 'package:account_flutter/bean/account_bean.dart';
import 'package:account_flutter/bean/trade_bean.dart';
import 'package:account_flutter/bean/trade_cate_bean.dart';
import 'package:account_flutter/model/account_list_model.dart';
import 'package:account_flutter/model/trade_cate_list_model.dart';
import 'package:account_flutter/model/trade_list.model.dart';
import 'package:account_flutter/pages/trade/key_board.dart';
import 'package:account_flutter/pages/trade/my_tab_bar_view.dart';
import 'package:account_flutter/pages/trade/result_show.dart';
import 'package:account_flutter/pages/trade/tools_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

class TradePageInner extends StatefulWidget {
  const TradePageInner({
    super.key,
    required this.tabController,
    this.tradeOrigin,
  });
  final TabController tabController;
  final TradeBean? tradeOrigin;
  @override
  State<StatefulWidget> createState() => _TradePageState();
}

class _TradePageState extends State<TradePageInner>
    with WidgetsBindingObserver {
  TradeCateBean? _selectedTradeCate;
  AccountBean? _selectAccount;
  DateTime _spendDate = DateTime.now();
  String money = "0";
  TextEditingController remarkController = TextEditingController();

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
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (MediaQuery.of(context).viewInsets.bottom == 0) {
        print("键盘收回");
      } else {
        print("键盘谈起");
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
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
      TradeBean trade = TradeBean(
        id: widget.tradeOrigin == null ? 0 : widget.tradeOrigin!.id,
        accountName: _selectAccount!.name,
        accountId: _selectAccount!.id,
        tradeCateName: _selectedTradeCate!.name,
        tradeCateId: _selectedTradeCate!.id,
        money: int.parse(money),
        remark: remarkController.text,
        spendDate: _spendDate,
        operate: operate,
      );

      if (widget.tradeOrigin == null) {
        TradeApi.create(trade).then((value) {
          context.read<TradeListModel>().update().then(
            (value) {
              Navigator.of(context).pop();
              EasyLoading.showSuccess("添加成功");
            },
          );
        });
      } else {
        TradeApi.update(trade).then((value) {
          context.read<TradeListModel>().update().then(
            (value) {
              Navigator.of(context).pop();
              EasyLoading.showSuccess("修改成功");
            },
          );
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
          remarkController: remarkController,
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
    );
  }
}
