import 'package:flutter/material.dart';

class ToolsList extends StatelessWidget {
  const ToolsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 40,
      color: Colors.blue,
      child: const Center(
        child: Text("tools_list"),
      ),
    );
  }
}
