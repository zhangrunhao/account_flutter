import 'package:account_flutter/api/trade_cate.dart';
import 'package:account_flutter/bean/trade_cate_bean.dart';
import 'package:account_flutter/model/trade_cate_list_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

class CateList extends StatelessWidget {
  final List<TradeCateBean> cates;
  final String title;
  final String operate;

  const CateList(
      {super.key,
      required this.cates,
      required this.title,
      required this.operate});

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
                            Navigator.of(context)
                                .pushNamed("trade_cate_edit", arguments: cate);
                          }),
                          child: const Text("修改"),
                        ),
                      ),
                      PopupMenuItem<String>(
                        child: TextButton(
                          child: const Text("删除"),
                          onPressed: () {
                            TradeCateApi.delete(cate).then((value) {
                              context
                                  .read<TradeCateListModel>()
                                  .update()
                                  .then((value) {
                                EasyLoading.showSuccess("删除成功");
                              });
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
