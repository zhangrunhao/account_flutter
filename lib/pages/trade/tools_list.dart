import 'package:account_flutter/bean/account_bean.dart';
import 'package:account_flutter/model/account_list_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

  Future<void> _selectAccount(List<AccountBean> accounts) async {
    AccountBean? account = await showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return ListView.builder(
            itemBuilder: ((context, index) {
              AccountBean account = accounts[index];
              return ListTile(
                title: Text(account.name),
                onTap: () => Navigator.of(context).pop(account),
              );
            }),
            itemCount: accounts.length,
          );
        });
    if (account != null) {
      setState(() {
        accountName = account.name;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    List<AccountBean> accounts = context.watch<AccountListModel>().accounts;
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
            accounts,
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

Widget _buildAccountPickerButton(Function pressCallback,
    List<AccountBean> accounts, BuildContext context, String buttonTitle) {
  return Container(
    margin: const EdgeInsets.all(5),
    child: ElevatedButton(
      onPressed: () async {
        await pressCallback(accounts);
      },
      child: Text(buttonTitle),
    ),
  );
}
