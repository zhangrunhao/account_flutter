import 'dart:convert';
import 'package:account_flutter/bean/trade_cate_bean.dart';
import 'package:account_flutter/pages/trade_cate_edit/icon_list.dart';
import 'package:account_flutter/pages/trade_cate_edit/name_form.dart';
import 'package:flutter/material.dart';

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
      appBar: _buildAppBar(widget.tradeCate, widget.operate),
      body: Column(
        children: <Widget>[
          NameForm(
            formKey: _formKey,
            nameController: _nameController,
            iconName: iconName,
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

PreferredSizeWidget _buildAppBar(TradeCateBean? tradeCate, String? operate) {
  String operateCN = "";
  String behavior = "";
  if (operate is String) {
    behavior = "新增";
    operateCN = operate == "income" ? "收入" : "支出";
  } else if (tradeCate is TradeCateBean) {
    behavior = "修改";
    operateCN = tradeCate.operate == "income" ? "收入" : "支出";
  }
  return AppBar(
    title: Text("$behavior$operateCN分类"),
    actions: const <Widget>[
      SizedBox(
        width: 50,
        child: Icon(Icons.done),
      )
    ],
  );
}
