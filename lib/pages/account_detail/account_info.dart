import 'package:account_flutter/bean/account_bean.dart';
import 'package:flutter/material.dart';

class AccountInfo extends StatelessWidget {
  final AccountBean accountBean;
  const AccountInfo({super.key, required this.accountBean});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 115.5,
      padding: const EdgeInsets.only(top: 20, bottom: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            accountBean.money.toString(),
            style: const TextStyle(
              fontSize: 28,
              color: Color(0xFF105CFB),
              decoration: TextDecoration.none,
            ),
          ),
          const Text(
            "当前余额(¥)",
            style: TextStyle(
              fontSize: 12,
              color: Color(0xff84868f),
              decoration: TextDecoration.none,
            ),
          )
        ],
      ),
    );
  }
}
