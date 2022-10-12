import 'dart:convert';

import 'package:flutter/material.dart';

class TradeCateEditPage extends StatefulWidget {
  const TradeCateEditPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _TradeCateEditPageState();
  }
}

Future<List<dynamic>> getIconsName(BuildContext context) async {
  String data = await DefaultAssetBundle.of(context)
      .loadString("json/trade_cate_icons.json");
  List<dynamic> icons = jsonDecode(data);
  return icons;
}

class _TradeCateEditPageState extends State<TradeCateEditPage> {
  final String _title = "编辑分类";
  List<String> icons = [];

  @override
  void initState() {
    super.initState();
    getIconsName(context).then((value) {
      setState(() {
        icons = List<String>.from(value);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(_title),
      body: ListView.builder(
          itemCount: icons.length,
          itemBuilder: ((context, index) {
            return Image.asset("images/cate_icons/${icons[index]}.png");
          })),
    );
  }
}

PreferredSizeWidget _buildAppBar(String title) {
  return AppBar(
    title: Text(title),
  );
}
