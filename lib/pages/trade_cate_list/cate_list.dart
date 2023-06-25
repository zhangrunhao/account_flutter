import 'package:account_flutter/bean/trade_cate_bean.dart';
import 'package:account_flutter/db/trade_cate_db.dart';
import 'package:account_flutter/widgets/show_delete_dialog.dart';
import 'package:flutter/material.dart';

class CateList extends StatelessWidget {
  final List<TradeCateBean> cates;
  final String title;
  final int operate;
  final Function fetchList;

  const CateList({
    super.key,
    required this.cates,
    required this.title,
    required this.operate,
    required this.fetchList,
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
                  leading: Image.asset("images/cates/${cate.icon}"),
                  title: Text(cate.name),
                  trailing: PopupMenuButton<String>(
                    padding: EdgeInsets.zero,
                    itemBuilder: (context) => <PopupMenuItem<String>>[
                      PopupMenuItem<String>(
                        child: TextButton(
                          onPressed: (() {
                            Navigator.pop(context); // 关闭弹框
                            Navigator.of(context)
                                .pushNamed(
                                  "trade_cate_edit",
                                  arguments: cate,
                                )
                                .then((value) => fetchList());
                          }),
                          child: const Text("修改"),
                        ),
                      ),
                      PopupMenuItem<String>(
                        child: TextButton(
                          child: const Text("删除"),
                          onPressed: () {
                            Navigator.pop(context); // 关闭弹框
                            showDeleteConfirmDialog(context, "确定要删除这个分类吗")
                                .then((bool? del) {
                              if (del == null) {
                              } else {
                                TradeCateDB()
                                    .delete(cate.id)
                                    .then((value) => fetchList());
                              }
                            });
                          },
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
