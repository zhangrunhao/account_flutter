import 'package:account_flutter/bean/trade_cate_bean.dart';
import 'package:flutter/material.dart';

class ResultShow extends StatelessWidget {
  const ResultShow({Key? key, required this.cate, required this.money, required this.remarkController})
      : super(key: key);

  final TradeCateBean? cate;

  final String money;

  final TextEditingController remarkController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.only(left: 10),
            width: 50,
            height: 50,
            child: _buildCateImage(cate),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(left: 10),
              height: 60,
              child: TextField(
                controller: remarkController,
                decoration: const InputDecoration(
                    fillColor: Colors.white,
                    labelText: "备注",
                    hintText: "请输入备注"),
              ),
            ),
          ),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 110),
            child: Container(
              margin: const EdgeInsets.only(right: 5),
              child: Center(
                child: FittedBox(
                  child: Text(
                    money,
                    style: const TextStyle(
                        fontSize: 30, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

Widget _buildCateImage(TradeCateBean? cate) {
  if (cate != null) {
    if (cate.id == 0) {
      return Image.asset(cate.icon);
    } else {
      return Image.asset("images/cate_icons/${cate.icon}.png");
    }
  } else {
    return Container();
  }
}
