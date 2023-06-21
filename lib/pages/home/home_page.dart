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
            _AccountCard(),
          ],
        ),
      ),
    );
  }
}

class _AccountCard extends StatelessWidget {
  const _AccountCard();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 130,
      margin: const EdgeInsets.only(top: 20),
      child: Center(
        child: Container(
          width: 335,
          height: 130,
          decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
              Color.fromARGB(255, 16, 92, 251),
              Color.fromARGB(255, 10, 171, 255)
            ]),
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          child: Stack(
            children: [
              const Positioned(
                top: 20.5,
                left: 20,
                child: Text(
                  "当前余额:",
                  style: TextStyle(
                    fontSize: 12,
                    decoration: TextDecoration.none,
                    color: Colors.white60,
                  ),
                ),
              ),
              const Positioned(
                top: 14,
                right: 14,
                child: Icon(
                  Icons.keyboard_arrow_right,
                  size: 18,
                  color: Colors.white,
                ),
              ),
              const Positioned(
                bottom: 20,
                left: 20,
                child: Text(
                  "889888",
                  style: TextStyle(
                    fontSize: 28,
                    decoration: TextDecoration.none,
                    color: Colors.white,
                  ),
                ),
              ),
              Positioned(
                bottom: 20,
                right: 20,
                child: Container(
                  width: 40,
                  height: 40,
                  color: Colors.white,
                  child: Image.asset(
                    "images/account_icons/zhifubao.png",
                    width: 40,
                    height: 40,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      // child: Stack(
      //   alignment: Alignment.center,
      //   children: [
      //
      //   ],
      // ),
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
