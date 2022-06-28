import 'package:account_flutter/pages/trade/cate_list.dart';
import 'package:account_flutter/pages/trade/key_board.dart';
import 'package:account_flutter/pages/trade/result_show.dart';
import 'package:account_flutter/pages/trade/tools_list.dart';
import 'package:flutter/material.dart';

class TradePage extends StatelessWidget {
  const TradePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Trade"),
      ),
      body: SafeArea(
        child: Column(
          children: const [
            Expanded(child: CateList()),
            ResultShow(),
            ToolsList(),
            KeyBoard(),
          ],
        ),
      ),
    );
  }
}
