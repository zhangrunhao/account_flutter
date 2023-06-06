import 'package:account_flutter/bean/trade_cate_bean.dart';
import 'package:account_flutter/pages/trade/cate_list.dart';
import 'package:flutter/material.dart';

typedef TapCateListCallBack = void Function(TradeCateBean cate);

class MyTabBarView extends StatelessWidget {
  const MyTabBarView({
    super.key,
    required this.tabController,
    required this.callBack,
  });
  final TabController tabController;
  final TapCateListCallBack callBack;

  @override
  Widget build(BuildContext context) {
    return TabBarView(controller: tabController, children: [
      CateList(
        operate: "Income",
        callBack: callBack,
      ),
      CateList(
        operate: "Expend",
        callBack: callBack,
      ),
    ]);
  }
}