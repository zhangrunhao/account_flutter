import 'package:account_flutter/bean/trade_cate_bean.dart';
import 'package:account_flutter/db/trade_cate_db.dart';
import 'package:account_flutter/pages/trade_cate_list/cate_list.dart';
import 'package:flutter/material.dart';

class TradeCateListPage extends StatefulWidget {
  const TradeCateListPage({super.key, required this.operate});
  final int operate; // 收入/指出

  @override
  State<StatefulWidget> createState() {
    return _TradeCateListPageState();
  }
}

class _TradeCateListPageState extends State<TradeCateListPage> {
  List<TradeCateBean> cates = [];
  final TradeCateDB _tradeCateDB = TradeCateDB();

  @override
  void initState() {
    super.initState();
    _fetchList();
  }

  void _fetchList() {
    _tradeCateDB.queryList("operate=${widget.operate}").then((value) {
      setState(() {
        cates = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    String title;
    if (widget.operate == 1) {
      title = "收入分类类表";
    } else {
      title = "支出分类列表";
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
          Navigator.of(context)
              .pushNamed(
                "trade_cate_edit",
                arguments: widget.operate,
              )
              .then((value) => _fetchList());
        }),
        child: const Text("添加"),
      ),
    );
  }
}
