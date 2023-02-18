import 'package:account_flutter/bean/account_bean.dart';
import 'package:account_flutter/pages/account_detail/account_detail.dart';
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

  @override
  void initState() {
    super.initState();
    account = widget.account;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("账户详情"),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .pushNamed(
                "account_edit",
                arguments: AccountEditPageArguments(
                  account == null ? "" : account!.cate,
                  account,
                ),
              )
                  .then(
                (value) {
                  setState(
                    () {
                      account = value as AccountBean?;
                    },
                  );
                },
              );
            },
            child: const Icon(Icons.edit),
          )
        ],
      ),
      body: AccountDetail(
        account: account,
      ),
    );
  }
}
