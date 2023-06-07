import 'dart:convert';
import 'package:account_flutter/bean/trade_cate_bean.dart';
import 'package:account_flutter/db/trade_cate_db.dart';
import 'package:account_flutter/pages/trade_cate_edit/icon_list.dart';
import 'package:account_flutter/pages/trade_cate_edit/name_form.dart';
import 'package:flutter/material.dart';

class TradeCateEditPage extends StatefulWidget {
  // 编辑分类, 传入tradeCate, 新增分类, 传入operate
  final TradeCateBean? tradeCate;
  final int operate;

  const TradeCateEditPage({super.key, this.tradeCate, required this.operate});

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
  final TradeCateDB _tradeCateDB = TradeCateDB();

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
                submitForm(
                  context,
                  widget.tradeCate,
                  widget.operate,
                  _nameController.text,
                  iconName,
                  _tradeCateDB,
                ).then((value) => Navigator.of(context).pop());
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

String _buildAppBarTitle(TradeCateBean? tradeCate, int operate) {
  String behavior = "";
  String operateCN = "";
  if (tradeCate is TradeCateBean) {
    behavior = "修改";
  } else {
    behavior = "新增";
  }
  switch (operate) {
    case 1:
      operateCN = "收入";
      break;
    case 2:
      operateCN = "支出";
      break;
    default:
  }
  return "$behavior$operateCN分类";
}

Future<void> submitForm(
  BuildContext context,
  TradeCateBean? tradeCate,
  int operate,
  String name,
  String? icon,
  TradeCateDB tradeCateDB,
) async {
  if (tradeCate is TradeCateBean && icon is String) {
    // 修改
    await tradeCateDB.update(TradeCateBean(
      id: tradeCate.id,
      name: name,
      icon: icon,
      type: 2,
      operate: operate,
    ));
  } else if (icon is String) {
    // 新增
    TradeCateBean newTradeCate = TradeCateBean(
      name: name,
      icon: icon,
      id: 0,
      type: 2,
      operate: operate,
    );
    await tradeCateDB.insert(newTradeCate);
  }
}
