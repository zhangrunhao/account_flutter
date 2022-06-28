import 'package:flutter/material.dart';

class ResultShow extends StatelessWidget {
  const ResultShow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 60,
      // color: Colors.green,
      child: Row(
        children: [
          _buildCateIcon(Icons.abc_outlined),
          Expanded(child: _buildInput()),
          _buildCountResult()
        ],
      ),
    );
  }
}

Widget _buildCateIcon(IconData icon) {
  return Container(
    margin: const EdgeInsets.only(left: 10),
    width: 50,
    height: 50,
    child: Image.asset("images/aliya.jpg"),
  );
}

Widget _buildInput() {
  return Container(
    margin: const EdgeInsets.only(left: 10),
    height: 60,
    child: const TextField(
      autofocus: true,
      decoration: InputDecoration(
          fillColor: Colors.white, labelText: "备注", hintText: "请输入备注"),
    ),
  );
}

Widget _buildCountResult() {
  return Container(
    margin: const EdgeInsets.only(right: 5),
    child:  const Center(
      child: Text(
        "10.01",
        style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
      ),
    ),
  );
}
