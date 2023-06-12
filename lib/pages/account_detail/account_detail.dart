import 'package:account_flutter/bean/account_bean.dart';
import 'package:flutter/material.dart';

class AccountDetail extends StatelessWidget {
  final AccountBean account;

  const AccountDetail({super.key, required this.account});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _RowInfo(
          label: "名称",
          value: account.name,
          type: "text",
        ),
        _RowInfo(
          label: "图标",
          value: account.icon,
          type: "image",
        ),
        _RowInfo(
          label: "余额",
          value: account.money.toString(),
          type: "text",
        ),
      ],
    );
  }
}

class _RowInfo extends StatelessWidget {
  final String label;
  final String value;
  final String type;

  const _RowInfo(
      {required this.label, required this.value, required this.type});
  @override
  Widget build(BuildContext context) {
    Widget valueWidget = Container();
    switch (type) {
      case "text":
        valueWidget = Text(value);
        break;
      case "image":
        valueWidget = Image.asset("images/account_icons/$value.png");
        break;
      default:
    }
    return Column(
      children: [
        Row(
          children: [
            Text("$label: "),
            valueWidget,
          ],
        ),
      ],
    );
  }
}
