import 'package:account_flutter/pages/about/about_page.dart';
import 'package:account_flutter/pages/home/home_page.dart';
import 'package:flutter/material.dart';

class MyRouter {
  static const homePage = "app://";
  static const aboutPage = "app://about";

  Widget _getPage(String url) {
    switch (url) {
      case homePage:
        return HomePage();
      case aboutPage:
        return AboutPage();
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
