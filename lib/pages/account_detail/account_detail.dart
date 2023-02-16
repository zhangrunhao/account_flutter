import 'package:account_flutter/bean/account_bean.dart';
import 'package:flutter/material.dart';

class AccountDetail extends StatefulWidget {
  final AccountBean account;

  const AccountDetail({super.key, required this.account});

  @override
  State<StatefulWidget> createState() {
    return _AccountDetailState();
  }
}

class _AccountDetailState extends State<AccountDetail> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _RowInfo(label: "名称", value: widget.account.name),
        _RowInfo(label: "类型", value: widget.account.cate),
        _RowInfo(label: "图标", value: widget.account.icon),
      ],
    );
  }
}

class _RowInfo extends StatelessWidget {
  final String label;
  final String value;

  const _RowInfo({required this.label, required this.value});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text("$label: "),
        Text(value),
      ],
    );
  }
}
