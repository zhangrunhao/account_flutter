import 'dart:convert';
import 'package:account_flutter/api/trade_cate.dart';
import 'package:account_flutter/bean/trade_cate_bean.dart';
import 'package:account_flutter/model/trade_cate_list_model.dart';
import 'package:account_flutter/pages/trade_cate_edit/icon_list.dart';
import 'package:account_flutter/pages/trade_cate_edit/name_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

class TradeCateEditPage extends StatefulWidget {
  // 编辑分类, 传入tradeCate, 新增分类, 传入operate
  final TradeCateBean? tradeCate;
  final String? operate;

  const TradeCateEditPage({super.key, this.tradeCate, this.operate});

  @override
  State<StatefulWidget> createState() {
    return _TradeCateEditPageState();
  }
}

class _TradeCateEditPageState extends State<TradeCateEditPage> {
  List<String> icons = [];
  final TextEditingController _nameController = TextEditingController();
  final GlobalKey _formKey = GlobalKey<FormState>();
  String? iconName;

  @override
  void initState() {
    super.initState();
    getIconsName(context).then((value) {
      setState(() {
        icons = List<String>.from(value);
        if (widget.tradeCate != null) {
          iconName = widget.tradeCate?.icon;
          _nameController.text = widget.tradeCate!.name;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_buildAppBarTitle(widget.tradeCate, widget.operate)),
        actions: <Widget>[
          SizedBox(
            width: 50,
            child: GestureDetector(
              onTap: () {
                submitForm(context, widget.tradeCate, widget.operate,
                    _nameController.text, iconName);
              },
              child: const Icon(Icons.done),
            ),
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          NameForm(
            formKey: _formKey,
            nameController: _nameController,
            iconName: iconName,
            operateName: _buildAppBarTitle(widget.tradeCate, widget.operate),
          ),
          Expanded(
            child: IconsList(
              icons: icons,
              iconTapCallBack: ((String selectIconName) {
                setState(() {
                  iconName = selectIconName;
                });
              }),
            ),
          ),
        ],
      ),
    );
  }
}

Future<List<dynamic>> getIconsName(BuildContext context) async {
  String data = await DefaultAssetBundle.of(context)
      .loadString("json/trade_cate_icons.json");
  List<dynamic> icons = jsonDecode(data);
  return icons;
}

String _buildAppBarTitle(TradeCateBean? tradeCate, String? operate) {
  String behavior = "";
  String operateCN = "";
  if (operate is String) {
    behavior = "新增";
    operateCN = operate == "Income" ? "收入" : "支出";
  } else if (tradeCate is TradeCateBean) {
    behavior = "修改";
    operateCN = tradeCate.operate == "Income" ? "收入" : "支出";
  }
  return "$behavior$operateCN分类";
}

void submitForm(BuildContext context, TradeCateBean? tradeCate, String? operate,
    String name, String? icon) {
  TradeCateListModel tradeCateListModel = context.read<TradeCateListModel>();
  if (tradeCate is TradeCateBean && icon is String) {
    TradeCateBean newTradeCate = tradeCate;
    newTradeCate.icon = icon;
    TradeCateApi.update(newTradeCate).then((value)  {
      Navigator.pop(context);
      // TODO: 完成更新后再进行提示
      tradeCateListModel.update();
      EasyLoading.showSuccess("修改成功");
    });
  } else if (operate is String && icon is String) {
    // 新增
    TradeCateBean newTradeCate = TradeCateBean(
        name: name, icon: icon, id: 0, type: "type", operate: operate);
    TradeCateApi.create(newTradeCate).then((v) {
      Navigator.pop(context);
      tradeCateListModel.update();
      EasyLoading.showSuccess("添加成功");
    });
  }
}
