import 'package:flutter/material.dart';

class AccountCreatePage extends StatelessWidget {
  const AccountCreatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("创建账户"),
      ),
      body: const Center(
        child: Text("闯将账户"),
      ),
    );
  }
}