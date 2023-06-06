import 'package:account_flutter/bean/trade_cate_bean.dart';
import 'package:flutter/material.dart';

typedef TapCateListCallBack = void Function(TradeCateBean cate);

TradeCateBean settingCate = TradeCateBean(
  name: "编辑",
  icon: "images/setting.png",
  id: 0,
  type: 1,
  operate: 1,
);

class CateList extends StatelessWidget {
  const CateList({
    Key? key,
    required this.operate,
    required this.callBack,
  }) : super(key: key);

  final String operate;
  final TapCateListCallBack callBack;

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
          children: _buildCateList(callBack, context, operate),
        ));
  }
}

List<Widget> _buildCateList(
    TapCateListCallBack callBack, BuildContext context, String operate) {
  List<TradeCateBean> cates0 = [];
  if (operate == "Income") {
    // cates0 = context.watch<TradeCateListModel>().incomeCates;
    cates0 = [];
  } else {
    // cates0 = context.watch<TradeCateListModel>().expendCates;
    cates0 = [];
  }
  List<TradeCateBean> cates = [...cates0, settingCate];
  return cates
      .map((TradeCateBean cate) =>
          _buildCateOption(cate, callBack, context, operate))
      .toList();
}

Widget _buildCateOption(TradeCateBean cate, TapCateListCallBack callBack,
    BuildContext context, String operate) {
  return GestureDetector(
    onTap: () {
      if (cate.id == 0) {
        // 跳转cate设置页面
        Navigator.pushNamed(context, "trade_cate_list", arguments: operate);
      } else {
        callBack(cate);
      }
    },
    child: Card(
      color: Colors.grey[300],
      child: Column(
        children: [
          Expanded(
            child: BuildIconImage(cate: cate),
          ),
          Center(
            child: Text(cate.name),
          ),
        ],
      ),
    ),
  );
}

class BuildIconImage extends StatelessWidget {
  const BuildIconImage({
    super.key,
    required this.cate,
  });
  final TradeCateBean cate;

  @override
  Widget build(BuildContext context) {
    if (cate.id == 0) {
      return Image.asset(cate.icon);
    } else {
      return Image.asset("images/cate_icons/${cate.icon}.png");
    }
  }
}
