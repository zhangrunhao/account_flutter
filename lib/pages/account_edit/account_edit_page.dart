import 'package:account_flutter/bean/account_bean.dart';
import 'package:account_flutter/db/account_db.dart';
import 'package:flutter/material.dart';

class AccountEditPageArguments {
  final int accountType;
  final AccountBean? account; // 有就是更新, 没有就是新增
  AccountEditPageArguments(this.accountType, this.account);
}

class AccountEditPage extends StatelessWidget {
  final AccountEditPageArguments arguments;
  const AccountEditPage({super.key, required this.arguments});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${arguments.account == null ? "新建" : "更新"}${arguments.accountType == 1 ? "资产" : "负债"}账户",
        ),
        leading: IconButton(
          icon: const Icon(Icons.chevron_left),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: _AccountEditForm(
        type: arguments.accountType,
        account: arguments.account,
      ),
    );
  }
}

class _AccountEditForm extends StatefulWidget {
  final int type;
  final AccountBean? account;

  const _AccountEditForm({
    required this.type,
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
  final TextEditingController _moneyController = TextEditingController();
  final GlobalKey _formKey = GlobalKey<FormState>();
  final AccountDB _accountDB = AccountDB();

  @override
  void initState() {
    super.initState();
    if (widget.account != null) {
      setState(() {
        _nameController.text = widget.account?.name ?? "";
        _iconController.text = widget.account?.icon ?? "";
        _moneyController.text = widget.account!.money.toString();
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
          TextFormField(
            controller: _moneyController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: "余额",
              hintText: "请输入当前余额",
              prefixIcon: Icon(Icons.balance),
            ),
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
                        // 新增
                        _accountDB
                            .insert(AccountBean(
                              id: 0,
                              name: _nameController.text,
                              type: widget.type,
                              icon: _iconController.text,
                              money: num.parse(_moneyController.text),
                            ))
                            .then((value) => Navigator.of(context).pop());
                      } else {
                        //  更新
                        AccountBean result = AccountBean(
                          id: widget.account!.id,
                          name: _nameController.text,
                          type: widget.type,
                          icon: _iconController.text,
                          money: _moneyController.text == "" ? 0 : num.parse(_moneyController.text),
                        );
                        _accountDB
                            .update(result)
                            .then((value) => Navigator.of(context).pop(result));
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
