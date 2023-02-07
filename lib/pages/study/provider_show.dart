import 'package:account_flutter/model/counter_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProviderShow extends StatelessWidget {
  const ProviderShow({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          _ShowNumber(),
          _PressClick(),
        ],
      ),
    );
  }
}

class _ShowNumber extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final int data = context.watch<CounterModel>().count;
    return Text(data.toString());
  }
}

class _PressClick extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        context.read<CounterModel>().increment();
      },
      child: const Text('增加'),
    );
  }
}
