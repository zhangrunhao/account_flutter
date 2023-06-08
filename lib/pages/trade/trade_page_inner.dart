import 'dart:async';
import 'package:account_flutter/bean/account_bean.dart';
import 'package:account_flutter/bean/trade_bean.dart';
import 'package:account_flutter/bean/trade_cate_bean.dart';
import 'package:account_flutter/db/account_db.dart';
import 'package:account_flutter/db/trade_db.dart';
import 'package:account_flutter/db/trade_cate_db.dart';
import 'package:account_flutter/pages/trade/key_board.dart';
import 'package:account_flutter/pages/trade/my_tab_bar_view.dart';
import 'package:account_flutter/pages/trade/result_show.dart';
import 'package:account_flutter/pages/trade/tools_list.dart';
import 'package:flutter/material.dart';

class TradePageInner extends StatefulWidget {
  const TradePageInner({
    super.key,
    required this.tabController,
    this.tradeOrigin,
    this.accountOrigin,
  });
  final TabController tabController;
  final TradeBean? tradeOrigin;
  final AccountBean? accountOrigin;

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
  final AccountDB _accountDB = AccountDB();
  final TradeCateDB _tradeCateDB = TradeCateDB();
  final TradeDB _tradeDB = TradeDB();

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

  // @override
  // void didChangeMetrics() {
  //   super.didChangeMetrics();
  //   WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
  //     if (MediaQuery.of(context).viewInsets.bottom == 0) {
  //       // print("键盘收回");
  //     } else {
  //       // print("键盘谈起");
  //     }
  //   });
  // }

  // @override
  // void dispose() {
  //   super.dispose();
  //   WidgetsBinding.instance.removeObserver(this);
  // }

  void setDefaultTradeData() async {
    TradeBean? tradeOrigin = widget.tradeOrigin;
    AccountBean? accountOrigin = widget.accountOrigin;
    if (tradeOrigin != null) {
      // 处理账户
      AccountBean? account;
      List<AccountBean> accounts = await _accountDB.queryList(null);
      for (var element in accounts) {
        if (element.id == tradeOrigin.accountId) {
          account = element;
        }
      }
      // 处理分类
      TradeCateBean? tradeCate;
      List<TradeCateBean> cates = await _tradeCateDB.queryList(null);
      for (var element in cates) {
        if (element.id == tradeOrigin.tradeCateId) {
          tradeCate = element;
        }
      }
      if (tradeCate != null && tradeCate.operate == 1) {
        widget.tabController.animateTo(0);
      } else if (tradeCate != null && tradeCate.operate == 2) {
        widget.tabController.animateTo(1);
      }
      // 处理备注
      remarkController.text =
          widget.tradeOrigin == null ? "" : widget.tradeOrigin!.remark;

      // 一起设置状态
      setState(() {
        _selectedTradeCate = tradeCate;
        _selectAccount = account;
        _spendDate = tradeOrigin.spendDate;
        money = tradeOrigin.money.toString();
      });
    } else if (accountOrigin != null) {
      setState(() {
        _selectAccount = accountOrigin;
      });
    }
  }

  void setDefaultCate() async {
    var incomeCates = await _tradeCateDB.queryList("operate=1");
    var expendCates = await _tradeCateDB.queryList("operate=2");
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
    // 第一个时是收入, 第二个是指出
    int operate = operateIndex == 0 ? 1 : 2;
    if (_selectAccount != null && _selectedTradeCate != null) {
      TradeBean trade = TradeBean(
        id: widget.tradeOrigin == null ? 0 : widget.tradeOrigin!.id,
        accountName: _selectAccount!.name,
        accountId: _selectAccount!.id,
        tradeCateName: _selectedTradeCate!.name,
        tradeCateId: _selectedTradeCate!.id,
        money: double.parse(money),
        remark: remarkController.text,
        spendDate: _spendDate,
        operate: operate,
      );
      if (widget.tradeOrigin == null) {
        _tradeDB.insert(trade).then((value) => Navigator.of(context).pop());
      } else {
        _tradeDB.update(trade).then((value) => Navigator.of(context).pop());
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
