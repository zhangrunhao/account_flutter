import 'package:account_flutter/api/trade_cate.dart';
import 'package:account_flutter/bean/trade_cate_bean.dart';
import 'package:flutter/material.dart';

class TradeCateListPage extends StatefulWidget {
  const TradeCateListPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _TradeCateListPageState();
  }
}

List<TradeCateBean> incomeCates = [];
List<TradeCateBean> expendCates = [];

class _TradeCateListPageState extends State<TradeCateListPage> {
  String _selectedMenu = "";
  List<TradeCateBean> cates = [];
  String _title = "分类列表";

  void onSelectedMenu(String value) {
    setState(() {
      _selectedMenu = value;
    });
    if (value == "expend") {
      setState(() {
        cates = expendCates;
        _selectedMenu = "expend";
        _title = "支出分类类表";
      });
    } else {
      setState(() {
        cates = incomeCates;
        _selectedMenu = "income";
        _title = "收入分类类表";
      });
    }
  }

  @override
  void initState() {
    super.initState();
    TradeCateApi.getList().then((value) {
      incomeCates =
          value.where((element) => element.operate == "Income").toList();
      expendCates =
          value.where((element) => element.operate == "Expend").toList();
      setState(() {
        cates = incomeCates;
        _selectedMenu = "income";
        _title = "收入分类类表";
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(_selectedMenu, onSelectedMenu),
      body: Column(
        children: [Expanded(child: _buildCateList(cates, _title))],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (() {
          // TODO: 跳转添加分类页面
        }),
        child: const Text("添加"),
      ),
    );
  }
}

PreferredSizeWidget _buildAppBar(
  String _selectMenu,
  onSelectedMenu,
) {
  return AppBar(
    title: const Text("分类列表"),
    actions: [
      PopupMenuButton(
        onSelected: ((value) {
          onSelectedMenu(value);
        }),
        itemBuilder: (BuildContext context) {
          return [
            const PopupMenuItem(
              value: "income",
              child: Text("收入"),
            ),
            const PopupMenuItem(
              value: "expend",
              child: Text("支出"),
            ),
          ];
        },
      ),
    ],
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
