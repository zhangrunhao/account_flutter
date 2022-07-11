import 'package:flutter/material.dart';

class KeyBoard extends StatelessWidget {
  const KeyBoard({Key? key}) : super(key: key);

  void _handleNumberTap(String key) {
    print(key);
  }

  void _handleDeleteTap(String key) {
    print("delete");
  }

  void _handleAddTap(String key) {
    print("add");
  }

  void _handleSubtractTap(String key) {
    print("subtract");
  }

  void _handleAgainTap(String key) {
    print("again");
  }

  void _handlePointTap(String key) {
    print("point");
  }

  void _handleSaveTap(String key) {
    print("save");
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
                  child: _buildKeyButton("+", "add", _handleAddTap),
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
                  child: _buildKeyButton("-", "subtract", _handleSubtractTap),
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

// Widget _buildKeyButton(String text, String key, Function onTap) {
//   return GestureDetector(
//     onTap: () {
//       onTap(key);
//     },
//     child: Container(
//       margin: const EdgeInsets.all(2),
//       decoration: BoxDecoration(
//         border: Border.all(
//           color: Colors.black,
//           width: 2,
//         ),
//         color: Colors.grey[400],
//       ),
//       child: Center(
//         child: Text(text),
//       ),
//     ),
//   );
// }
