import 'dart:collection';

import 'package:account_flutter/api/trade_cate.dart';
import 'package:account_flutter/bean/trade_cate_bean.dart';
import 'package:flutter/material.dart';

class TradeCateListModel with ChangeNotifier {
  List<TradeCateBean> _incomeCates = [];
  List<TradeCateBean> _expendCates = [];

  TradeCateListModel() {
    _fetch();
  }

  Future<void> _fetch() async {
    List<TradeCateBean> value = await TradeCateApi.getList();
    _incomeCates =
        value.where((element) => element.operate == "Income").toList();
    _expendCates =
        value.where((element) => element.operate == "Expend").toList();
    notifyListeners();
  }

  UnmodifiableListView<TradeCateBean> get incomeCates =>
      UnmodifiableListView(_incomeCates);
  UnmodifiableListView<TradeCateBean> get expendCates =>
      UnmodifiableListView(_expendCates);

  Future<void> update() {
    return _fetch();
  }
}
