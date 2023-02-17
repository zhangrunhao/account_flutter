import 'package:account_flutter/bean/account_bean.dart';
import 'package:account_flutter/model/account_list_model.dart';
import 'package:account_flutter/pages/home/account_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WalletWidget extends StatelessWidget {
  const WalletWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<AccountBean> debtAccounts =
        context.watch<AccountListModel>().debtAccounts;
    List<AccountBean> propertyAccounts =
        context.watch<AccountListModel>().propertyAccounts;
    return Column(
      children: [
        Expanded(
          child: AccountList(
            cate: "Property",
            accounts: propertyAccounts,
          ),
        ),
        Expanded(
          child: AccountList(
            cate: "Debt",
            accounts: debtAccounts,
          ),
        ),
      ],
    );
  }
}
