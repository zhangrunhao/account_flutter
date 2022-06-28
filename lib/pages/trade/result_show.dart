import 'package:flutter/material.dart';

class ResultShow extends StatelessWidget {
  const ResultShow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 60,
      color: Colors.green,
      child: const Center(child: Text("result_show")),
    );
  }
}
