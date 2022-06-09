import 'package:account_flutter/router.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("首页"),
      ),
      body: const Text("首页"),
      floatingActionButton: FloatingActionButton(
        onPressed: (() => MyRouter.push(context, "app://about")),
        child: const Icon(Icons.backpack),
      ),
    );
  }
}