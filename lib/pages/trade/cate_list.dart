import 'package:account_flutter/bean/trade_cate_bean.dart';
import 'package:account_flutter/db/trade_cate_db.dart';
import 'package:flutter/material.dart';

typedef TapCateListCallBack = void Function(TradeCateBean cate);

TradeCateBean settingCate = TradeCateBean(
  name: "编辑",
  icon: "setting",
  id: 0,
  type: 1,
  operate: 0,
);

class CateList extends StatefulWidget {
  const CateList({
    Key? key,
    required this.operate,
    required this.callBack,
  }) : super(key: key);

  final int operate;
  final TapCateListCallBack callBack;

  @override
  State<StatefulWidget> createState() {
    return _CateListState();
  }
}

class _CateListState extends State<CateList> {
  List<TradeCateBean> cates = [];
  final TradeCateDB _tradeCateDB = TradeCateDB();

  @override
  void initState() {
    super.initState();
    _fetch();
  }

  void _fetch() {
    _tradeCateDB.queryList("operate=${widget.operate}").then((value) {
      setState(() {
        cates = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: GridView.count(
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        crossAxisCount: 5,
        padding: const EdgeInsets.all(15),
        children: [...cates, settingCate]
            .map((e) => _CateOption(
                  cate: e,
                  callBack: widget.callBack,
                  operate: widget.operate,
                  fetch: _fetch,
                ))
            .toList(),
      ),
    );
  }
}

class _CateOption extends StatelessWidget {
  const _CateOption({
    Key? key,
    required this.cate,
    required this.callBack,
    required this.operate,
    required this.fetch,
  }) : super(key: key);

  final TradeCateBean cate;
  final TapCateListCallBack callBack;
  final int operate;
  final Function fetch;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (cate.id == 0) {
          Navigator.pushNamed(
            context,
            "trade_cate_list",
            arguments: operate,
          ).then((value) => fetch());
        } else {
          callBack(cate);
        }
      },
      child: Card(
        color: Colors.grey[300],
        child: Column(
          children: [
            Expanded(
              child: Image.asset("images/cate_icons/${cate.icon}.png"),
            ),
            Center(
              child: Text(cate.name),
            ),
          ],
        ),
      ),
    );
  }
}
