import 'package:account_flutter/bean/account_bean.dart';
import 'package:account_flutter/db/account_db.dart';
import 'package:account_flutter/pages/account_edit/account_edit_page.dart';
import 'package:account_flutter/util/show_dialog.dart';
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
    leading: Image.asset("images/account_icons/${account.icon}.png"),
    title: Text(account.name),
    subtitle: Text("当前金额: ${account.money.toString()}元"),
    trailing: PopupMenuButton(
      onSelected: (value) {
        switch (value) {
          case 0:
            // 编辑
            Navigator.of(context)
                .pushNamed("account_edit",
                    arguments: AccountEditPageArguments(account.type, account))
                .then((value) {
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
              fetchList();
            });
            break;
          case 2:
            showDeleteConfirmDialog(context, "确定要删除该账户吗?").then((bool? del) {
              if (del == null) {
              } else {
                AccountDB().delete(account.id).then((value) => fetchList());
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
