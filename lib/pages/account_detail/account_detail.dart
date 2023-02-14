import 'package:account_flutter/api/account_api.dart';
import 'package:account_flutter/bean/account_bean.dart';
import 'package:flutter/material.dart';

class AccountDetail extends StatefulWidget {
  final int id;

  const AccountDetail({super.key, required this.id});

  @override
  State<StatefulWidget> createState() {
    return _AccountDetailState();
  }
}

class _AccountDetailState extends State<AccountDetail> {
  String? name;
  String? cate;
  String? icon;

  @override
  void initState() {
    super.initState();
    AccountApi.get(widget.id).then((AccountBean accountBean) {
      setState(() {
        name = accountBean.name;
        cate = accountBean.cate;
        icon = accountBean.icon;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _RowInfo(label: "名称", value: name),
        _RowInfo(label: "类型", value: cate),
        _RowInfo(label: "图标", value: icon),
      ],
    );
  }
}

class _RowInfo extends StatelessWidget {
  final String label;
  final String? value;

  const _RowInfo({required this.label, required this.value});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text("$label: "),
        Text(value??""),
      ],
    );
  }
}
