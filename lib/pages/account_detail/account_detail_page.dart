import 'package:account_flutter/bean/account_bean.dart';
import 'package:account_flutter/bean/trade_bean.dart';
import 'package:account_flutter/db/trade_db.dart';
import 'package:account_flutter/pages/account_detail/account_detail.dart';
import 'package:account_flutter/pages/account_detail/trade_list.dart';
import 'package:account_flutter/pages/account_edit/account_edit_page.dart';
import 'package:flutter/material.dart';

class AccountDetailPage extends StatefulWidget {
  final AccountBean account;
  const AccountDetailPage({super.key, required this.account});
  @override
  State<StatefulWidget> createState() => _AccountDetailState();
}

class _AccountDetailState extends State<AccountDetailPage> {
  AccountBean? account;
  List<TradeBean> trades = [];
  TradeDB _tradeDB = TradeDB();

  @override
  void initState() {
    super.initState();
    account = widget.account;
    _fetch();
  }

  _fetch() async {
    List<TradeBean> result = await _tradeDB.queryList(null);
    setState(() {
      trades = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("账户详情"),
        leading: IconButton(
          icon: const Icon(Icons.chevron_left),
          onPressed: () {
            Navigator.of(context).pop("aaa");
          },
        ),
        actions: [
          GestureDetector(
            onTap: () {
              // 编辑
              Navigator.of(context)
                  .pushNamed(
                "account_edit",
                arguments: AccountEditPageArguments(account!.type, account),
              )
                  .then((value) {
                setState(() {
                  account = value as AccountBean?;
                });
              });
            },
            child: const Icon(Icons.edit),
          )
        ],
      ),
      body: Column(
        children: [
          AccountDetail(
            account: account,
          ),
          TradeList(trades: trades, tradeUpdateCallBack: () {
            _fetch();
          })
        ],
      ),
    );
  }
}
