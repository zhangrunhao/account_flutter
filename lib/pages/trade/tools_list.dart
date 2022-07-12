import 'package:flutter/material.dart';

class ToolsList extends StatefulWidget {
  const ToolsList({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _ToolsListState();
}

class _ToolsListState extends State<ToolsList> {
  DateTime selectDate = DateTime.now();
  String accountName = "选择账户";

  Future<void> _selectDate(BuildContext content) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      locale: const Locale("zh", "ZH"),
      initialDate: selectDate,
      firstDate: DateTime(2000, 01),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectDate) {
      setState(() {
        selectDate = picked;
      });
    }
  }

  Future<int?> _selectAccount(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return ListView(
            children: [
              ListTile(
                leading: const Icon(Icons.abc_outlined),
                title: const Text("微信"),
                onTap: () {
                  setState(() {
                    accountName = "微信";
                  });
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.payment),
                title: const Text("支付宝"),
                onTap: () {
                  setState(() {
                    accountName = "支付宝";
                  });
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 40,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _buildDatePickerButton(
            _selectDate,
            context,
            '${selectDate.year.toString()}-${selectDate.month.toString()}-${selectDate.day.toString()}',
          ),
          _buildAccountPickerButton(
            _selectAccount,
            context,
            accountName,
          ),
        ],
      ),
    );
  }
}

Widget _buildDatePickerButton(
    Function pressCallback, BuildContext context, String buttonTitle) {
  return Container(
    margin: const EdgeInsets.all(5),
    child: ElevatedButton(
      onPressed: () => {pressCallback(context)},
      child: Text(buttonTitle),
    ),
  );
}

Widget _buildAccountPickerButton(
    Function pressCallback, BuildContext context, String buttonTitle) {
  return Container(
    margin: const EdgeInsets.all(5),
    child: ElevatedButton(
      onPressed: () => {pressCallback(context)},
      child: Text(buttonTitle),
    ),
  );
}
