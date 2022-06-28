import 'dart:ffi';

import 'package:flutter/material.dart';

class CateList extends StatelessWidget {
  const CateList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.grey,
      child: GridView.count(
        mainAxisSpacing: 15,
        crossAxisSpacing: 15,
        crossAxisCount: 5,
        padding: const EdgeInsets.all(10),
        children: _buildCateList(32),
      )
    );
  }
}

List<Container> _buildCateList(int count) {
  return List.generate(count, (index) => _buildCateOption("交通", Icons.home));
}

Container _buildCateOption(String title, IconData icon) {
  return Container(
    color: Colors.amber,
    child: Column(
      children: [
        Expanded(child: Image.asset("images/aliya.jpg")),
        Center(child: Text(title),),
      ],
    ),
  );
}