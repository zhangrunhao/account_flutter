import 'package:account_flutter/bean/account_bean.dart';
import 'package:flutter/material.dart';

class AccountList extends StatelessWidget {
  final List<AccountBean> accounts;
  final Widget listHeader;

  const AccountList({
    super.key,
    required this.accounts,
    required this.listHeader,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (BuildContext context, int index) {
        if (index == 0) {
          return listHeader;
        } else {
          index -= 1;
          AccountBean account = accounts[index];
          return ListTile(
            leading: Image.asset("images/cate_icons/${account.icon}.png"),
            title: Text(account.name),
          );
        }
      },
      separatorBuilder: ((BuildContext context, int index) {
        return const Divider(
          height: 1.0,
          color: Colors.black,
        );
      }),
      itemCount: accounts.length + 1,
    );
  }
}
