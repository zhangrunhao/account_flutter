import 'package:account_flutter/bean/account_bean.dart';
import 'package:account_flutter/db/account_db.dart';
import 'package:account_flutter/pages/home/account_card_list.dart';
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
  final AccountDB _accountDB = AccountDB();
  List<AccountBean> accounts = [];

  @override
  void initState() {
    super.initState();
    _fetchList("1");
  }

  void _fetchList(type) {
    _accountDB.queryList("type=$type").then((value) {
      setState(() {
        accounts = value;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return BgWidget(
      child: Column(
        children: [
          TopSwitch(
            onChange: (index) {
              if (index == 0) {
                // 资产
                _fetchList(1);
              } else if (index == 1) {
                // 负债
                _fetchList(2);
              }
            },
          ),
          AccountListInfo(
            accountNum: accounts.length,
          ),
          AccountCardList(
            accounts: accounts,
          ),
        ],
      ),
    );
  }
}


