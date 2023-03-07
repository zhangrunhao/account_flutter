import 'package:account_flutter/api/account_api.dart';
import 'package:account_flutter/bean/account_bean.dart';
import 'package:account_flutter/model/account_list_model.dart';
import 'package:account_flutter/pages/account_edit/account_edit_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

class AccountList extends StatelessWidget {
  final List<AccountBean> accounts;
  final String cate;

  const AccountList({
    super.key,
    required this.accounts,
    required this.cate,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (BuildContext context1, int index) {
        if (index == 0) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(cate == "Debt" ? "负债" : "资产"),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    "account_edit",
                    arguments: AccountEditPageArguments(cate, null),
                  );
                },
                child: const Icon(Icons.add),
              ),
            ],
          );
        } else {
          index -= 1;
          AccountBean account = accounts[index];
          return _buildAccountListTitle(account, context);
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

Widget _buildAccountListTitle(AccountBean account, BuildContext context) {
  return ListTile(
    leading: Image.asset("images/cate_icons/${account.icon}.png"),
    title: Text(account.name),
    subtitle: const Text("当前金额: 0元"),
    trailing: PopupMenuButton(
      onSelected: (value) {
        switch (value) {
          case 0:
            Navigator.of(context).pushNamed(
              "account_edit",
              arguments: AccountEditPageArguments(
                account.cate,
                account,
              ),
            );
            break;
          case 1:
            Navigator.of(context).pushNamed(
              "account_detail",
              arguments: account,
            );
            break;
          case 2:
            showDeleteConfirmDialog(context).then((bool? del) {
              if (del == null) {
              } else {
                AccountApi.delete(account.id).then(
                  (value) {
                    AccountListModel accountListModel =
                        context.read<AccountListModel>();
                    accountListModel.update().then((value) {
                      EasyLoading.showSuccess("删除成功");
                    });
                  },
                );
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
    onTap: () {},
  );
}

// 弹出对话框
Future<bool?> showDeleteConfirmDialog(BuildContext context) {
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
