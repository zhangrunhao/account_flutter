import 'package:flutter/material.dart';
import 'package:decimal/decimal.dart';

typedef MoneyChange = void Function(String money);

Decimal d(String s) => Decimal.parse(s);

class KeyBoard extends StatelessWidget {
  const KeyBoard({
    Key? key,
    required this.money,
    required this.moneyChange,
    required this.onSaveTap,
  }) : super(key: key);

  final String money;
  final MoneyChange moneyChange;
  final Function onSaveTap;

  String _handleSymbolicOperation() {
    Decimal res;
    if (money.contains('-') && money.lastIndexOf("-") < money.length - 1) {
      //如果存在 - , 先计算
      List<String> arr = money.split('-');
      res = d(arr[0]) - d(arr[1]);
      if (res < d('0')) res = d('0');
    } else if (money.contains('+') &&
        money.lastIndexOf("+") < money.length - 1) {
      //如果存在 + , 先计算
      List<String> arr = money.split('+');
      res = d(arr[0]) + d(arr[1]);
    } else if (money.lastIndexOf('+') + 1 == money.length ||
        money.lastIndexOf('-') + 1 == money.length) {
      res = d(money.substring(0, money.length - 1));
    } else {
      res = d(money);
    }
    return res.toString();
  }

  void _handleNumberTap(String key) {
    if ( // 只有一个 . , 没有+ 和 -的情况下, 小数点后面只能有两位
        money.contains('.') &&
            !money.contains('+') &&
            !money.contains('-') &&
            money.substring(money.indexOf('.')).length > 2) {
      return;
    }

    if (money.contains('.') &&
            money.contains('+') &&
            money.lastIndexOf('.') > money.lastIndexOf('+') && // . 比 + 更靠后
            money.substring(money.lastIndexOf('.')).length > 2 // . 后面最多有两问
        ) {
      return;
    }

    if (money.contains('.') &&
            money.contains('-') &&
            money.lastIndexOf('.') > money.lastIndexOf('-') && // . 比 - 更靠后
            money.substring(money.lastIndexOf('.')).length > 2 // . 后面最多有两问
        ) {
      return;
    }

    if (money == "0") {
      moneyChange(key);
      return;
    }
    moneyChange(money + key);
  }

  void _handleDeleteTap(String key) {
    String res = money.substring(0, money.length - 1);
    res.isEmpty ? moneyChange('0') : moneyChange(res);
  }

  void _handlePulsTap(String key) {
    moneyChange("${_handleSymbolicOperation()}+");
  }

  void _handleMinusTap(String key) {
    moneyChange("${_handleSymbolicOperation()}-");
  }

  void _handleAgainTap(String key) {}

  void _handlePointTap(String key) {
    if ( // 存在 . , 但是不存在 + 或 -
        money.contains('.') && !money.contains('+') && !money.contains('-')) {
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

    if (money.contains('+') &&
            money.length == money.lastIndexOf('+') + 1 // 最后一位是 +
        ) {
      moneyChange('${money}0.');
      return;
    }

    if (money.contains('-') &&
            money.length == money.lastIndexOf('-') + 1 // 最后一位是 -
        ) {
      moneyChange('${money}0.');
      return;
    }

    moneyChange('$money.');
  }

  void _handleSaveTap(String key) {
    onSaveTap(_handleSymbolicOperation());
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
                _KeyButton(text: "1", buttonKey: "1", onTap: _handleNumberTap),
                _KeyButton(text: "2", buttonKey: "2", onTap: _handleNumberTap),
                _KeyButton(text: "3", buttonKey: "3", onTap: _handleNumberTap),
                _KeyButton(
                    text: "删除", buttonKey: "delete", onTap: _handleDeleteTap),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                _KeyButton(text: "4", buttonKey: "4", onTap: _handleNumberTap),
                _KeyButton(text: "5", buttonKey: "5", onTap: _handleNumberTap),
                _KeyButton(text: "6", buttonKey: "6", onTap: _handleNumberTap),
                _KeyButton(text: "+", buttonKey: "plus", onTap: _handlePulsTap),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                _KeyButton(text: "7", buttonKey: "7", onTap: _handleNumberTap),
                _KeyButton(text: "8", buttonKey: "8", onTap: _handleNumberTap),
                _KeyButton(text: "9", buttonKey: "9", onTap: _handleNumberTap),
                _KeyButton(
                    text: "-", buttonKey: "minus", onTap: _handleMinusTap)
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                _KeyButton(
                    text: "再记", buttonKey: "again", onTap: _handleAgainTap),
                _KeyButton(text: "0", buttonKey: "0", onTap: _handleNumberTap),
                _KeyButton(
                    text: ".", buttonKey: "point", onTap: _handlePointTap),
                _KeyButton(
                    text: "保存", buttonKey: "save", onTap: _handleSaveTap),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _KeyButton extends StatelessWidget {
  final String text;
  final String buttonKey;
  final Function onTap;

  const _KeyButton({
    required this.text,
    required this.buttonKey,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FittedBox(
        child: TextButton(
          onPressed: () {
            onTap(buttonKey);
          },
          child: Text(text),
        ),
      ),
    );
  }
}
