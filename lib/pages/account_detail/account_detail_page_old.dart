import 'package:account_flutter/bean/account_bean.dart';
import 'package:account_flutter/bean/trade_bean.dart';
import 'package:account_flutter/db/account_db.dart';
import 'package:account_flutter/db/trade_db.dart';
// import 'package:account_flutter/pages/account_detail/account_detail.dart';
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
  List<TradeBean> trades = [];
  final TradeDB _tradeDB = TradeDB();
  final AccountDB _accountDB = AccountDB();
  AccountBean? account;

  @override
  void initState() {
    super.initState();
    account = widget.account;
    _fetchTradeList();
  }

  _fetchTradeList() async {
    List<TradeBean> result =
        await _tradeDB.queryList("account_id=${widget.account.id}");
    setState(() {
      trades = result;
    });
  }

  _fetchAccountDetail() async {
    AccountBean resAccount = await _accountDB.queryById(account!.id);
    setState(() {
      account = resAccount;
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
            Navigator.of(context).pop();
          },
        ),
        actions: [
          GestureDetector(
            onTap: () {
              // 编辑
              Navigator.of(context)
                  .pushNamed(
                "account_edit",
                arguments: AccountEditPageArguments(
                  widget.account.type,
                  widget.account,
                ),
              )
                  .then((value) {
                if (value is AccountBean) {
                  setState(() {
                    account = value;
                  });
                }
              });
            },
            child: const Icon(Icons.edit),
          )
        ],
      ),
      body: Column(
        children: [
          // AccountDetail(
          //   account: account!,
          // ),
          TradeList(
            trades: trades,
            tradeUpdateCallBack: (TradeBean trade) {
              List<TradeBean> newTradeList = trades.map((e) {
                if (e.id == trade.id) {
                  if (trade.accountId == account!.id) {
                    _fetchAccountDetail();
                  }
                  return trade;
                } else {
                  return e;
                }
              }).toList();
              setState(() {
                trades = newTradeList;
              });
            },
            tradeDeleteCallBack: (int id) {
              setState(() {
                trades.removeWhere((element) => element.id == id);
              });
            },
          ),
          ElevatedButton(
            child: const Text("添加一条"),
            onPressed: () {
              Navigator.of(context)
                  .pushNamed(
                "trade",
                arguments: account,
              )
                  .then((value) {
                _fetchAccountDetail();
                setState(() {
                  TradeBean tradeResult = value as TradeBean;
                  if (tradeResult.accountId == account!.id) {
                    trades.add(tradeResult);
                  }
                });
              });
            },
          )
        ],
      ),
    );
  }
}
