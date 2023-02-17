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
      ),
      body: _AccountEditForm(
        cate: arguments.accountCate,
      ),
    );
  }
}

class _AccountEditForm extends StatefulWidget {
  final String cate;

  const _AccountEditForm({required this.cate});

  @override
  State<StatefulWidget> createState() {
    return _AccountEditFormState();
  }
}

class _AccountEditFormState extends State<_AccountEditForm> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _iconController = TextEditingController();
  final GlobalKey _formKey = GlobalKey<FormState>();
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
                      AccountApi.create(
                        AccountBean(
                            id: 0,
                            name: _nameController.text,
                            cate: widget.cate,
                            icon: _iconController.text),
                      ).then((value) {
                        context.read<AccountListModel>().update().then((value) {
                          Navigator.of(context).pop();
                        });
                      });
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
