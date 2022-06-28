import 'package:flutter/material.dart';

class KeyBoard extends StatelessWidget {
  const KeyBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 300,
      color: Colors.pinkAccent,
      child: const Center(
        child: Text("key_board"),
      ),
    );
  }
}
