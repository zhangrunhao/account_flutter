import 'package:account_flutter/bean/trade_cate_bean.dart';
import 'package:account_flutter/router.dart';
import 'package:flutter/material.dart';

typedef TapCateListCallBack = void Function(TradeCateBean cate);

class CateList extends StatelessWidget {
  const CateList({
    Key? key,
    required this.cates,
    required this.callBack,
  }) : super(key: key);

  final List<TradeCateBean> cates;
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
          children: _buildCateList(cates, callBack, context),
        ));
  }
}

List<Widget> _buildCateList(List<TradeCateBean> cates,
    TapCateListCallBack callBack, BuildContext context) {
  return cates
      .map((TradeCateBean cate) => _buildCateOption(cate, callBack, context))
      .toList();
}

Widget _buildCateOption(
    TradeCateBean cate, TapCateListCallBack callBack, BuildContext context) {
  return GestureDetector(
    onTap: () {
      if (cate.id == 0) {
        // 跳转cate设置页面
        MyRouter.push(context, "app://trade-cate-list");
      } else {
        callBack(cate);
      }
    },
    child: Card(
      color: Colors.grey[300],
      child: Column(
        children: [
          Expanded(child: _buildIconImage(cate)),
          Center(
            child: Text(cate.name),
          ),
        ],
      ),
    ),
  );
}

Widget _buildIconImage(TradeCateBean cate) {
  if (cate.id == 0) {
    return Image.asset(cate.icon);
  } else {
    return Image.asset("images/cate_icons/${cate.icon}.png");
  }
}
