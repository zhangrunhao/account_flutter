import 'package:account_flutter/api/trade_cate.dart';
import 'package:account_flutter/bean/trade_cate_bean.dart';
import 'package:flutter/material.dart';

class TradeCateListPage extends StatefulWidget {
  const TradeCateListPage({super.key, required this.operate});
  final String operate; // 收入/指出

  @override
  State<StatefulWidget> createState() {
    return _TradeCateListPageState();
  }
}

List<TradeCateBean> incomeCates = [];
List<TradeCateBean> expendCates = [];

class _TradeCateListPageState extends State<TradeCateListPage> {
  List<TradeCateBean> cates = [];
  String _title = "分类列表";

  @override
  void initState() {
    super.initState();
    TradeCateApi.getList().then((value) {
      if (widget.operate == "Income") {
        setState(() {
          cates = incomeCates =
              value.where((element) => element.operate == "Income").toList();
          _title = "收入分类类表";
        });
      } else if (widget.operate == "Expend") {
        setState(() {
          cates =
              value.where((element) => element.operate == "Expend").toList();
          _title = "支出分类列表";
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(_title),
      body: Column(
        children: [Expanded(child: _buildCateList(cates, _title))],
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

PreferredSizeWidget _buildAppBar(
  String title,
) {
  return AppBar(
    title: Text(title),
  );
}

Widget _buildCateList(List<TradeCateBean> cates, String title) {
  return Column(
    children: [
      ListTile(
        title: Text(title),
      ),
      Expanded(
        child: ListView.separated(
          itemBuilder: ((BuildContext context, int index) {
            TradeCateBean cate = cates[index];
            return ListTile(
              leading: Image.asset("images/cate_icons/${cate.icon}.png"),
              title: Text(cate.name),
              trailing: ElevatedButton(
                onPressed: (() {
                  Navigator.of(context)
                      .pushNamed("trade_cate_edit", arguments: cate);
                }),
                child: const Text("修改"),
              ),
            );
          }),
          separatorBuilder: ((BuildContext context, int index) {
            return const Divider(
              height: 1.0,
              color: Colors.black,
            );
          }),
          itemCount: cates.length,
        ),
      ),
    ],
  );
}
