import 'package:account_flutter/bean/trade_bean.dart';
import 'package:account_flutter/pages/home/wallet_widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  List<TradeBean> trades = [];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("首页"),
      ),
      body: const WalletWidget(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, "trade").then((value) {
            // 更新对应账户的余额
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
