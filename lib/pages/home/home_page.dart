import 'package:account_flutter/pages/home/account_item_card.dart';
import 'package:account_flutter/pages/home/account_list_info.dart';
import 'package:account_flutter/pages/home/top_switch.dart';
import 'package:account_flutter/widgets/bg_widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return BgWidget(
      child: Container(
        margin: const EdgeInsets.only(top: 20),
        child: const Column(
          children: [
            TopSwitch(),
            AccountListInfo(),
            AccountItemCard(),
          ],
        ),
      ),
    );
  }
}


// class _HomePageState extends State<HomePage> {
//   List<TradeBean> trades = [];
//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("首页"),
//       ),
//       body: const WalletWidget(),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           Navigator.pushNamed(context, "trade").then((value) {
//             // 更新对应账户的余额
//           });
//         },
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }
