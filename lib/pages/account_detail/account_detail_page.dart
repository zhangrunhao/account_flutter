import 'package:account_flutter/pages/account_detail/account_detail.dart';
import 'package:flutter/material.dart';

class AccountDetailPage extends StatelessWidget {
  const AccountDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("账户详情"),
      ),
      body: const AccountDetail(
        id: 3,
      ),
    );
  }
}
