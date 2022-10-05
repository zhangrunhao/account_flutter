import 'package:flutter/material.dart';
import 'package:decimal/decimal.dart';

typedef MoneyChangeCallBack = void Function(String money);

Decimal d (String s) => Decimal.parse(s);

class KeyBoard extends StatelessWidget {
  const KeyBoard({Key? key, required this.money, required this.callBack})
      : super(key: key);

  final String money;
  final MoneyChangeCallBack callBack;
  

  void _handleNumberTap(String key) {

    if ( // 只有一个 . , 没有+ 和 -的情况下, 小数点后面只能有两位
      money.contains('.') &&
      !money.contains('+') &&
      !money.contains('-') &&
      money.substring(money.indexOf('.')).length > 2
    ) {
      return;
    }

    if (
      money.contains('.') &&
      money.contains('+') &&
      money.lastIndexOf('.') > money.lastIndexOf('+') && // . 比 + 更靠后
      money.substring(money.lastIndexOf('.')).length > 2 // . 后面最多有两问
    ) {
      return;
    }

    if (
      money.contains('.') &&
      money.contains('-') &&
      money.lastIndexOf('.') > money.lastIndexOf('-') && // . 比 - 更靠后
      money.substring(money.lastIndexOf('.')).length > 2 // . 后面最多有两问
    ) {
      return;
    }

    if (money == "0") {
      callBack(key);
      return;
    }
    callBack(money + key);
  }

  void _handleDeleteTap(String key) {
    String res = money.substring(0, money.length - 1);
    res.isEmpty ? callBack('0') : callBack(res);
  }

  void _handlePulsTap(String key) {
    callBack("${_handleSymbolicOperation()}+");
  }

  String _handleSymbolicOperation() {
    Decimal res;
    if (money.contains('-') && money.lastIndexOf("-") < money.length - 1) {
      //如果存在 - , 先计算
      List<String> arr = money.split('-');
      res = d(arr[0]) - d(arr[1]);
      if (res < d('0')) res = d('0');
    } else if (money.contains('+') && money.lastIndexOf("+") < money.length - 1) {
      //如果存在 + , 先计算
      List<String> arr = money.split('+');
      res = d(arr[0]) + d(arr[1]);
    } else if (money.lastIndexOf('+') + 1 == money.length || money.lastIndexOf('-') + 1 == money.length ) {
      res = d(money.substring(0, money.length - 1));
    } else {
      res = d(money);
    }
    return res.toString(); 
  }

  void _handleMinusTap(String key) {
    callBack("${_handleSymbolicOperation()}-");
  }

  void _handleAgainTap(String key) {
  }

  void _handlePointTap(String key) {
    if ( // 存在 . , 但是不存在 + 或 -
      money.contains('.') && 
      !money.contains('+') && 
      !money.contains('-')
    ) {
      return;
    }

    if ( // 最后一个 . , 在最后一个 + 后面
        money.contains('.') &&
            money.contains('+') &&
            money.lastIndexOf('.') > money.lastIndexOf('+')) {
      return;
    }

    if ( // 最后一个 . , 在最后一个 - 后面
        money.contains('.') &&
            money.contains('-') &&
            money.lastIndexOf('.') > money.lastIndexOf('-')) {
      return;
    }

    if (
      money.contains('+') &&
      money.length == money.lastIndexOf('+') + 1 // 最后一位是 +
    ) {
      callBack('${money}0.');
      return;
    }

    if (
      money.contains('-') &&
      money.length == money.lastIndexOf('-') + 1 // 最后一位是 -
    ) {
      callBack('${money}0.');
      return;
    }

    callBack('$money.');
  }

  void _handleSaveTap(String key) {
    callBack(_handleSymbolicOperation());
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 300,
      child: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(child: _buildKeyButton("1", "1", _handleNumberTap)),
                Expanded(child: _buildKeyButton("2", "2", _handleNumberTap)),
                Expanded(child: _buildKeyButton("3", "3", _handleNumberTap)),
                Expanded(
                  child: _buildKeyButton("删除", "delete", _handleDeleteTap),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(child: _buildKeyButton("4", "4", _handleNumberTap)),
                Expanded(child: _buildKeyButton("5", "5", _handleNumberTap)),
                Expanded(child: _buildKeyButton("6", "6", _handleNumberTap)),
                Expanded(
                  child: _buildKeyButton("+", "plus", _handlePulsTap),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(child: _buildKeyButton("7", "7", _handleNumberTap)),
                Expanded(child: _buildKeyButton("8", "8", _handleNumberTap)),
                Expanded(child: _buildKeyButton("9", "9", _handleNumberTap)),
                Expanded(
                  child: _buildKeyButton("-", "minus", _handleMinusTap),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: _buildKeyButton("再记", "again", _handleAgainTap),
                ),
                Expanded(child: _buildKeyButton("0", "0", _handleNumberTap)),
                Expanded(child: _buildKeyButton(".", "point", _handlePointTap)),
                Expanded(
                  child: _buildKeyButton("保存", "save", _handleSaveTap),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildKeyButton(String text, String key, Function onTap) {
  return FittedBox(
    child: TextButton(
      onPressed: () {
        onTap(key);
      },
      child: Text(text),
    ),
  );
}

