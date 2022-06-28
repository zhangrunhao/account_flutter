import 'package:flutter/material.dart';

class ToolsList extends StatelessWidget {
  const ToolsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 40,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: _buildToolBtn(10),
      ),
    );
  }
}

List<Widget> _buildToolBtn(int count) {
  return List.generate(
    count,
    (index) => Container(
      margin: const EdgeInsets.all(5),
      child: ElevatedButton(onPressed: () => {}, child: const Text("时间")),
    ),
  );
}
