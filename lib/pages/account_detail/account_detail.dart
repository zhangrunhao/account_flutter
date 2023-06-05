import 'package:account_flutter/bean/account_bean.dart';
import 'package:flutter/material.dart';

class AccountDetail extends StatelessWidget {
  final AccountBean? account;

  const AccountDetail({super.key, required this.account});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _RowInfo(label: "名称", value: account?.name ?? ""),
        // _RowInfo(label: "类型", value: account?.type ?? ""),
        _RowInfo(label: "图标", value: account?.icon ?? ""),
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
    return Column(
      children: [
        Row(
          children: [
            Text("$label: "),
            Text(value),
          ],
        ),
      ],
    );
  }
}
