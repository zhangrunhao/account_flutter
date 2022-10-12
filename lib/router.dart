import 'package:account_flutter/pages/home/home_page.dart';
import 'package:account_flutter/pages/login/login_page.dart';
import 'package:account_flutter/pages/trade/trade_page.dart';
import 'package:account_flutter/pages/trade_cate_edit/trade_cate_edit_page.dart';
import 'package:account_flutter/pages/trade_cate_list/trade_cate_list_page.dart';
import 'package:flutter/material.dart';

class MyRouter {
  static const homePage = "app://";
  static const tradePage = "app://trade";
  static const loginPage = "app://login";
  static const tradeCateListPage = "app://trade-cate-list";
  static const tradeCateEditPage = "app://trade-cate-edit";

  Widget _getPage(String url) {
    switch (url) {
      case homePage:
        return const HomePage();
      case tradePage:
        return const TradePage();
      case loginPage:
        return const LoginPage();
      case tradeCateListPage:
        return const TradeCateListPage();
      case tradeCateEditPage:
        return const TradeCateEditPage();
      default:
        return const Text("未匹配URL");
    }
  }

  MyRouter.push(BuildContext context, String url) {
    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
      return _getPage(url);
    }));
  }
}
