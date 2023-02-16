import 'package:account_flutter/bean/account_bean.dart';
import 'package:flutter/material.dart';

class AccountList extends StatelessWidget {
  final List<AccountBean> accounts;
  final String type;

  const AccountList({
    super.key,
    required this.accounts,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (BuildContext context, int index) {
        if (index == 0) {
          return  Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(type == "Debt" ? "负债" : "资产"),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed("account_edit");
                  },
                  child: const Icon(Icons.add),
                ),
              ],
            );
        } else {
          index -= 1;
          AccountBean account = accounts[index];
          return ListTile(
            leading: Image.asset("images/cate_icons/${account.icon}.png"),
            title: Text(account.name),
            onTap: () {
              Navigator.pushNamed(context, "account_detail", arguments: account);
            },
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
