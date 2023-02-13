import 'dart:collection';

import 'package:account_flutter/api/account_api.dart';
import 'package:account_flutter/bean/account_bean.dart';
import 'package:flutter/material.dart';

class AccountListModel with ChangeNotifier {
  List<AccountBean> _accounts = [];
  List<AccountBean> _debtAccounts = [];
  List<AccountBean> _propertyAccounts = [];

  AccountListModel() {
    _fetch();
  }
  Future<void> _fetch() async {
    List<AccountBean> accounts = await AccountApi.getList();
    _accounts = accounts;
    _debtAccounts = accounts.where((e) => e.cate == "Debt").toList();
    _propertyAccounts = accounts.where((e) => e.cate == "Property").toList();
    notifyListeners();
  }

  UnmodifiableListView<AccountBean> get accounts =>
      UnmodifiableListView(_accounts);
  UnmodifiableListView<AccountBean> get propertyAccounts =>
      UnmodifiableListView(_propertyAccounts);
  UnmodifiableListView<AccountBean> get debtAccounts =>
      UnmodifiableListView(_debtAccounts);

  Future<void> update() async {
    await _fetch();
  }
}
