import 'package:account_flutter/bean/account_bean.dart';
import 'package:account_flutter/db/account_db.dart';
import 'package:account_flutter/pages/account_edit/account_edit_page.dart';
import 'package:flutter/material.dart';

class AccountList extends StatefulWidget {
  final int type;

  const AccountList({
    super.key,
    required this.type,
  });

  @override
  State<StatefulWidget> createState() {
    return _AccountListState();
  }
}

class _AccountListState extends State<AccountList> {
  final AccountDB _accountDB = AccountDB();
  List<AccountBean> accounts = [];

  @override
  void initState() {
    super.initState();
    _fetchList();
  }

  _fetchList() {
    _accountDB.queryList("type=${widget.type}").then((value) {
      setState(() {
        accounts = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (BuildContext context1, int index) {
        if (index == 0) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(widget.type == 1 ? "资产" : "负债"),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed(
                    "account_edit",
                    arguments: AccountEditPageArguments(widget.type, null),
                  )
                      .then((value) {
                    _fetchList();
                  });
                },
                child: const Icon(Icons.add),
              ),
            ],
          );
        } else {
          index -= 1;
          AccountBean account = accounts[index];
          return _buildAccountListTitle(account, context, _fetchList);
        }
      },
      separatorBuilder: ((BuildContext context, int index) {
        return const Divider(
          height: 1.0,
          color: Colors.black,
        );
      }),
      itemCount: accounts.length + 1,
    );
  }
}

Widget _buildAccountListTitle(
    AccountBean account, BuildContext context, Function fetchList) {
  return ListTile(
    leading: Image.asset("images/cate_icons/${account.icon}.png"),
    title: Text(account.name),
    subtitle: const Text("当前金额: 0元"),
    trailing: PopupMenuButton(
      onSelected: (value) {
        switch (value) {
          case 0:
            // 编辑
            Navigator.of(context)
                .pushNamed("account_edit",
                    arguments: AccountEditPageArguments(account.type, account))
                .then((value) {
              //TODO: 刷新下自己这一个就行
              fetchList();
            });
            break;
          case 1:
            Navigator.of(context)
                .pushNamed(
              "account_detail",
              arguments: account,
            )
                .then((value) {
              //TODO: 刷新下自己这一个就行
              fetchList();
            });
            break;
          case 2:
            _showDeleteConfirmDialog(context).then((bool? del) {
              if (del == null) {
              } else {
                // TODO: 其实删除以后, 不需要更新整个列表
                AccountDB().delete(account).then((value) => fetchList());
              }
            });
            break;
          default:
        }
      },
      padding: EdgeInsets.zero,
      itemBuilder: (context) {
        return const <PopupMenuItem>[
          PopupMenuItem(
            value: 0,
            child: Text("修改"),
          ),
          PopupMenuItem(
            value: 1,
            child: Text("详情"),
          ),
          PopupMenuItem(
            value: 2,
            child: Text("删除"),
          ),
        ];
      },
    ),
    onTap: () {
      Navigator.of(context)
          .pushNamed(
            "account_detail",
            arguments: account,
          )
          .then((value) => fetchList());
    },
  );
}

Future<bool?> _showDeleteConfirmDialog(BuildContext context) {
  return showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text("提示"),
        content: const Text("您确定要删除当前账户吗?"),
        actions: <Widget>[
          TextButton(
            child: const Text("取消"),
            onPressed: () => Navigator.of(context).pop(), // 关闭对话框
          ),
          TextButton(
            child: const Text("删除"),
            onPressed: () {
              //关闭对话框并返回true
              Navigator.of(context).pop(true);
            },
          ),
        ],
      );
    },
  );
}
