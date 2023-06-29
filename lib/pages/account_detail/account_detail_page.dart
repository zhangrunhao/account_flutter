import 'package:account_flutter/bean/account_bean.dart';
import 'package:account_flutter/pages/account_detail/account_info.dart';
import 'package:account_flutter/pages/account_detail/navigate_bar.dart';
import 'package:account_flutter/pages/account_detail/year_trade_list.dart';
import 'package:account_flutter/widgets/bg_widget.dart';
import 'package:flutter/material.dart';

class AccountDetailPage extends StatelessWidget {
  final AccountBean accountBean;
  const AccountDetailPage({super.key, required this.accountBean});
  @override
  Widget build(BuildContext context) {
    return BgWidget(
      child: Column(
        children: [
          NavigateBar(accountBean: accountBean),
          AccountInfo(accountBean: accountBean),
          const Expanded(
            child: SingleChildScrollView(
              child: YearTradeList(),
            ),
          ),
        ],
      ),
    );
  }
}
