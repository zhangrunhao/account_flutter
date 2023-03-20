import 'package:account_flutter/bean/account_bean.dart';
import 'package:account_flutter/bean/trade_bean.dart';
import 'package:account_flutter/bean/trade_cate_bean.dart';
import 'package:account_flutter/model/account_list_model.dart';
import 'package:account_flutter/model/trade_cate_list_model.dart';
import 'package:account_flutter/model/trade_list.model.dart';
import 'package:account_flutter/pages/account_detail/account_detail_page.dart';
import 'package:account_flutter/pages/account_edit/account_edit_page.dart';
import 'package:account_flutter/pages/home/home_page.dart';
import 'package:account_flutter/pages/login/login_page.dart';
// import 'package:account_flutter/pages/study/study_page.dart';
import 'package:account_flutter/pages/trade/trade_page.dart';
import 'package:account_flutter/pages/trade_cate_edit/trade_cate_edit_page.dart';
import 'package:account_flutter/pages/trade_cate_list/trade_cate_list_page.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => TradeCateListModel()),
        ChangeNotifierProvider(create: (context) => TradeListModel()),
        ChangeNotifierProvider(create: (context) => AccountListModel()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: EasyLoading.init(),
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
        // "/": (context) => const LoginPage(),
        // "/": (context) => StudyPage(),
        "login": (context) => const LoginPage(),
        "trade": (context) {
          Object? arguments = ModalRoute.of(context)?.settings.arguments;
          if (arguments is TradeBean) {
            return TradePage(
              tradeOrigin: arguments,
            );
          } else {
            return const TradePage();
          }
        },
        "trade_cate_list": (context) {
          Object? arguments = ModalRoute.of(context)?.settings.arguments;
          return TradeCateListPage(operate: arguments as String);
        },
        "trade_cate_edit": (context) {
          Object? arguments = ModalRoute.of(context)?.settings.arguments;
          if (arguments is String) {
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
        "account_detail": (context) {
          Object? arguments = ModalRoute.of(context)?.settings.arguments;
          return AccountDetailPage(account: arguments as AccountBean);
        },
        "account_edit": (context) {
          AccountEditPageArguments arguments = ModalRoute.of(context)
              ?.settings
              .arguments as AccountEditPageArguments;
          return AccountEditPage(
            arguments: arguments,
          );
        }
      },
    );
  }
}
