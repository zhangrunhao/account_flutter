import 'package:account_flutter/bean/trade_cate_bean.dart';
import 'package:flutter/material.dart';

class CateList extends StatelessWidget {
  final List<TradeCateBean> cates;
  final String title;
  final int operate;

  const CateList({
    super.key,
    required this.cates,
    required this.title,
    required this.operate,
  });

  @override
  Widget build(BuildContext context) {
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
                  trailing: PopupMenuButton<String>(
                    padding: EdgeInsets.zero,
                    itemBuilder: (context) => <PopupMenuItem<String>>[
                      PopupMenuItem<String>(
                        child: TextButton(
                          onPressed: (() {
                            Navigator.pop(context);
                            Navigator.of(context).pushNamed(
                              "trade_cate_edit",
                              arguments: cate,
                            );
                          }),
                          child: const Text("修改"),
                        ),
                      ),
                      PopupMenuItem<String>(
                        child: TextButton(
                          child: const Text("删除"),
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ));
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
}
