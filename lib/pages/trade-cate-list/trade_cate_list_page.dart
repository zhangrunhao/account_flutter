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

class _TradeCateListPageState extends State<TradeCateListPage> {
  List<TradeCateBean> incomeCates = [];
  List<TradeCateBean> expendCates = [];

  @override
  void initState() {
    super.initState();
    TradeCateApi.getList().then((value) => {
          setState(() {
            incomeCates =
                value.where((element) => element.operate == "Income").toList();
            expendCates =
                value.where((element) => element.operate == "Expend").toList();
          })
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Column(
        children: [
          Expanded(child: _buildCateList(incomeCates, "收入分类")),
          Expanded(child: _buildCateList(expendCates, "支出分类")),
        ],
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

PreferredSizeWidget _buildAppBar() {
  return AppBar(
    title: const Text("分类列表"),
    actions: [
      SizedBox(
        width: 80,
        child: GestureDetector(
          onTap: (() {
            // TODO: 跳转添加分类页面
          }),
          child: const Icon(Icons.add),
        ),
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
              leading: Image.network(cate.icon),
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
