import 'package:account_flutter/bean/trade_cate_bean.dart';
import 'package:account_flutter/pages/home/home_page.dart';
import 'package:account_flutter/pages/login/login_page.dart';
import 'package:account_flutter/pages/trade/trade_page.dart';
import 'package:account_flutter/pages/trade_cate_edit/trade_cate_edit_page.dart';
import 'package:account_flutter/pages/trade_cate_list/trade_cate_list_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [Locale('zh')],
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        "/": (context) => const HomePage(),
        "login": (context) => const LoginPage(),
        "trade": (context) => const TradePage(),
        "trade_cate_list": (context) {
          Object? arguments = ModalRoute.of(context)?.settings.arguments;
          return TradeCateListPage(operate: arguments as String);
        },
        "trade_cate_edit": (context) {
          Object? arguments = ModalRoute.of(context)?.settings.arguments;
          if (arguments is String) {
            print(arguments);
            return TradeCateEditPage(
              operate: arguments,
            );
          } else if (arguments is TradeCateBean) {
            return TradeCateEditPage(
              tradeCate: arguments,
            );
          } else {
            return const TradeCateEditPage();
          }
        },
      },
    );
  }
}
