import 'dart:collection';

import 'package:account_flutter/api/trade_api.dart';
import 'package:account_flutter/bean/trade_bean.dart';
import 'package:flutter/material.dart';

class TradeListModel with ChangeNotifier {
  List<TradeBean> _trades = [];

  TradeListModel() {
    _fetch();
  }
  Future<void> _fetch() async {
    List<TradeBean> value = await TradeApi.getList();
    _trades = value;
    notifyListeners();
  }

  UnmodifiableListView<TradeBean> get trades => UnmodifiableListView(_trades);

  Future<void> update() async {
    await _fetch();
  }
}
