import 'package:flutter/material.dart';

class CateList extends StatelessWidget {
  const CateList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.grey,
      child: const Center(child: Text("cate_list")),
    );
  }
}