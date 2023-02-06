import 'package:flutter/material.dart';

class CounterModel with ChangeNotifier {
  int count;
  
  CounterModel(this.count) {
    _init();
  }

  void _init() {
    count = 100;
  }

  void increment() {
    count++;
    notifyListeners();
  }
}