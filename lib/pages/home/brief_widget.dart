import 'package:flutter/material.dart';

class BriefWidget extends StatelessWidget {
  const BriefWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 30,
      itemBuilder: (BuildContext context, int index) {
        return Card(
            child: ListTile(
          // leading: Image.network(
          //     "https://zhangrunhao.oss-cn-beijing.aliyuncs.com/account-icon/icons-ali/boots.png"),
          title: const Text("鞋子"),
          subtitle: const Text("从来没有过的耐克"),
          trailing: PopupMenuButton<String>(
            padding: EdgeInsets.zero,
            itemBuilder: (context) => const <PopupMenuItem<String>>[
              PopupMenuItem<String>(
                child: Text("修改"),
              ),
              PopupMenuItem<String>(
                child: Text("删除"),
              ),
            ],
          ),
        ));
      },
    );
  }
}
