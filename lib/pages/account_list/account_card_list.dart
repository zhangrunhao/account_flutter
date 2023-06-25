import 'package:account_flutter/bean/account_bean.dart';
import 'package:account_flutter/pages/account_list/account_item_card.dart';
import 'package:flutter/material.dart';

class AccountCardList extends StatelessWidget {
  final List<AccountBean> accounts;
  const AccountCardList({super.key, required this.accounts});
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(top: 20),
        child: ListView.builder(
          itemCount: accounts.length,
          itemBuilder: (context, index) {
            return AccountItemCard(
              accountBean: accounts[index],
            );
          },
        ),
      ),
    );
  }
}
