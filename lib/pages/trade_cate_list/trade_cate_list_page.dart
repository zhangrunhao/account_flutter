import 'package:account_flutter/bean/trade_cate_bean.dart';
import 'package:account_flutter/pages/trade_cate_list/cate_list.dart';
import 'package:flutter/material.dart';

class TradeCateListPage extends StatefulWidget {
  const TradeCateListPage({super.key, required this.operate});
  final String operate; // 收入/指出

  @override
  State<StatefulWidget> createState() {
    return _TradeCateListPageState();
  }
}

class _TradeCateListPageState extends State<TradeCateListPage> {
  @override
  Widget build(BuildContext context) {
    List<TradeCateBean> cates;
    String title;
    if (widget.operate == "Income") {
      title = "收入分类类表";
      cates = [];
    } else {
      title = "支出分类列表";
      cates = [];
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Column(
        children: [
          Expanded(
            child: CateList(
              cates: cates,
              title: title,
              operate: widget.operate,
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (() {
          Navigator.of(context).pushNamed(
            "trade_cate_edit",
            arguments: widget.operate,
          );
        }),
        child: const Text("添加"),
      ),
    );
  }
}
