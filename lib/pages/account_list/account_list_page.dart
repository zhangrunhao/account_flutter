import 'package:account_flutter/bean/account_bean.dart';
import 'package:account_flutter/db/account_db.dart';
import 'package:account_flutter/pages/account_list/account_card_list.dart';
import 'package:account_flutter/pages/account_list/account_list_info.dart';
import 'package:account_flutter/pages/account_list/top_switch.dart';
import 'package:account_flutter/widgets/bg_widget.dart';
import 'package:flutter/material.dart';

class AccountListPage extends StatefulWidget {
  const AccountListPage({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _AccountListPageState();
  }
}

class _AccountListPageState extends State<AccountListPage> {
  final AccountDB _accountDB = AccountDB();
  List<AccountBean> accounts = [];
  String accountListName = "我的资产";

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
                setState(() {
                  accountListName = "我的资产";
                });
              } else if (index == 1) {
                // 负债
                _fetchList(2);
                setState(() {
                  accountListName = "我的负债";
                });
              }
            },
          ),
          AccountListInfo(
            accountListName: accountListName,
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


