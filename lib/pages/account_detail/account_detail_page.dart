import 'package:account_flutter/bean/account_bean.dart';
import 'package:account_flutter/pages/account_detail/account_detail.dart';
import 'package:flutter/material.dart';

class AccountDetailPage extends StatelessWidget {
  final AccountBean account;

  const AccountDetailPage({super.key, required this.account});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("账户详情"),
      ),
      body: AccountDetail(
        account: account,
      ),
    );
  }
}
