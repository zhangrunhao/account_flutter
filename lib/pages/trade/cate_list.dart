import 'package:account_flutter/bean/account_bean.dart';
import 'package:flutter/material.dart';

typedef TapCallBack = void Function(TradeCateBean cate);

class CateList extends StatelessWidget {
  const CateList({
    Key? key,
    required this.cates,
    required this.callBack,
  }) : super(key: key);

  final List<TradeCateBean> cates;
  final TapCallBack callBack;

  List<Widget> _buildCateList() {
    return cates.map((TradeCateBean cate) => _buildCateOption(cate)).toList();
  }

  Widget _buildCateOption(TradeCateBean cate) {
    return GestureDetector(
      onTap: () {
        callBack(cate);
      },
      child: Card(
        color: Colors.grey[300],
        child: Column(
          children: [
            Expanded(child: Image.network(cate.icon)),
            Center(
              child: Text(cate.name),
            ),
          ],
        ),
      ),
    );
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
          children: _buildCateList(),
        ));
  }
}
