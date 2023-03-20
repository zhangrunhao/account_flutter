import 'dart:collection';

import 'package:account_flutter/api/trade_cate_api.dart';
import 'package:account_flutter/bean/trade_cate_bean.dart';
import 'package:flutter/material.dart';

class TradeCateListModel with ChangeNotifier {
  List<TradeCateBean> _incomeCates = [];
  List<TradeCateBean> _expendCates = [];
  List<TradeCateBean> _cates = [];

  TradeCateListModel() {
    _fetch();
  }

  Future<void> _fetch() async {
    List<TradeCateBean> value = await TradeCateApi.getList();
    _incomeCates =
        value.where((element) => element.operate == "Income").toList();
    _expendCates =
        value.where((element) => element.operate == "Expend").toList();
    _cates = value;
    notifyListeners();
  }

  UnmodifiableListView<TradeCateBean> get incomeCates =>
      UnmodifiableListView(_incomeCates);
  UnmodifiableListView<TradeCateBean> get expendCates =>
      UnmodifiableListView(_expendCates);
  UnmodifiableListView<TradeCateBean> get cates => UnmodifiableListView(_cates);

  Future<void> update() {
    return _fetch();
  }
}
