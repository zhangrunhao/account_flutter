import 'package:account_flutter/pages/home/account_list.dart';
import 'package:flutter/material.dart';

class WalletWidget extends StatelessWidget {
  const WalletWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Expanded(
          child: AccountList(
            type: 1,
          ),
        ),
        Expanded(
          child: AccountList(
            type: 2,
          ),
        ),
      ],
    );
  }
}


