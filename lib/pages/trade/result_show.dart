import 'package:account_flutter/bean/account_bean.dart';
import 'package:flutter/material.dart';

class ResultShow extends StatelessWidget {
  const ResultShow({Key? key, required this.cate, required this.money})
      : super(key: key);

  final TradeCateBean cate;

  final String money;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: Row(
        children: [
          _buildCateIcon(cate),
          Expanded(child: _buildInput()),
          ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 110
            ),
            child: _buildCountResult(money),
          )
        ],
      ),
    );
  }
}

Widget _buildCateIcon(TradeCateBean cate) {
  return Container(
    margin: const EdgeInsets.only(left: 10),
    width: 50,
    height: 50,
    child: Image.network(cate.icon),
  );
}

Widget _buildInput() {
  return Container(
    margin: const EdgeInsets.only(left: 10),
    height: 60,
    child: const TextField(
      decoration: InputDecoration(
          fillColor: Colors.white, labelText: "备注", hintText: "请输入备注"),
    ),
  );
}

Widget _buildCountResult(String money) {
  return Container(
    margin: const EdgeInsets.only(right: 5),
    child: Center(
      child: FittedBox(
        child: Text(
          money,
          style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w600),
        ),
      ),
    ),
  );
}
