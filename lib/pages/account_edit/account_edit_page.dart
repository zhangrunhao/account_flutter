import 'package:account_flutter/api/account_api.dart';
import 'package:account_flutter/bean/account_bean.dart';
import 'package:account_flutter/model/account_list_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AccountEditPageArguments {
  final String accountCate;
  final AccountBean? account; // 有就是更新, 没有就是新增
  AccountEditPageArguments(this.accountCate, this.account);
}

class AccountEditPage extends StatelessWidget {
  final AccountEditPageArguments arguments;
  const AccountEditPage({super.key, required this.arguments});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            "${arguments.account == null ? "新建" : "更新"}${arguments.accountCate}账户"),
        leading: IconButton(
          icon: const Icon(Icons.chevron_left),
          onPressed: () {
            AccountBean result = AccountBean(
              id: arguments.account?.id ?? 0,
              name: arguments.account?.name ?? "",
              cate: arguments.accountCate,
              icon: arguments.account?.icon ?? "",
            );
            Navigator.of(context).pop(result);
          },
        ),
      ),
      body: _AccountEditForm(
        cate: arguments.accountCate,
        account: arguments.account,
      ),
    );
  }
}

class _AccountEditForm extends StatefulWidget {
  final String cate;
  final AccountBean? account;

  const _AccountEditForm({
    required this.cate,
    this.account,
  });

  @override
  State<StatefulWidget> createState() {
    return _AccountEditFormState();
  }
}

class _AccountEditFormState extends State<_AccountEditForm> with RouteAware {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _iconController = TextEditingController();
  final GlobalKey _formKey = GlobalKey<FormState>();


  @override
  void initState() {
    super.initState();
    if (widget.account != null) {
      setState(() {
        _nameController.text = widget.account?.name ?? "";
        _iconController.text = widget.account?.icon ?? "";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            autofocus: true,
            controller: _nameController,
            decoration: const InputDecoration(
              labelText: "账户名称",
              hintText: "需要创建或修改的账户名称",
              prefixIcon: Icon(Icons.account_balance),
            ),
            validator: (v) {
              return v!.trim().isNotEmpty ? null : "账户名称不能为空";
            },
          ),
          TextFormField(
            controller: _iconController,
            decoration: const InputDecoration(
              labelText: "账户图标",
              hintText: "需要创建或账户的图标",
              prefixIcon: Icon(Icons.image),
            ),
            validator: (v) {
              return v!.trim().isNotEmpty ? null : "图标不能为空";
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Builder(builder: (ctx) {
                return ElevatedButton(
                  child: const Text("确认"),
                  onPressed: () {
                    if (Form.of(ctx).validate()) {
                      if (widget.account == null) {
                        _createAccount(
                          AccountBean(
                            id: 0,
                            name: _nameController.text,
                            cate: widget.cate,
                            icon: _iconController.text,
                          ),
                          context,
                        );
                      } else {
                        _updateAccount(
                            AccountBean(
                              id: widget.account!.id,
                              name: _nameController.text,
                              cate: widget.cate,
                              icon: _iconController.text,
                            ),
                            context);
                      }
                    }
                  },
                );
              }),
              ElevatedButton(
                child: const Text("重置"),
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}

void _createAccount(AccountBean account, BuildContext context) {
  AccountApi.create(
    account,
  ).then((value) {
    context.read<AccountListModel>().update().then(
      (value) {
        Navigator.of(context).pop();
      },
    );
  });
}

void _updateAccount(AccountBean account, BuildContext context) {
  AccountApi.update(
    account,
  ).then((value) {
    context.read<AccountListModel>().update().then(
      (value) {
        Navigator.of(context).pop(account);
      },
    );
  });
}
