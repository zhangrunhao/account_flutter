import 'package:account_flutter/bean/account_bean.dart';
import 'package:account_flutter/db/account_db.dart';
import 'package:flutter/material.dart';

typedef AccountSelectCallBack = void Function(AccountBean account);
typedef SpendDateSelectCallBack = void Function(DateTime spendDate);

class ToolsList extends StatelessWidget {
  final DateTime spendDate;
  final AccountBean? account;
  final AccountSelectCallBack accountChange;
  final SpendDateSelectCallBack spendDateChange;

  const ToolsList({
    super.key,
    required this.account,
    required this.spendDate,
    required this.accountChange,
    required this.spendDateChange,
  });

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      locale: const Locale("zh", "ZH"),
      initialDate: spendDate,
      firstDate: DateTime(2000, 01),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != spendDate) {
      spendDateChange(picked);
    }
  }

  Future<void> _selectAccount(
    BuildContext context,
  ) async {
    List<AccountBean> accounts = await AccountDB().queryList(null);
    // ignore: use_build_context_synchronously
    AccountBean? account = await showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return ListView.builder(
            itemBuilder: ((context, index) {
              AccountBean account = accounts[index];
              return ListTile(
                title: Text(account.name),
                onTap: () {
                  accountChange(account);
                  Navigator.of(context).pop(account);
                },
              );
            }),
            itemCount: accounts.length,
          );
        });
    if (account != null) {
      accountChange(account);
    }
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
            '${spendDate.year.toString()}-${spendDate.month.toString()}-${spendDate.day.toString()}',
          ),
          _buildAccountPickerButton(_selectAccount, context, account),
        ],
      ),
    );
  }
}

Widget _buildDatePickerButton(
  Function pressCallback,
  BuildContext context,
  String buttonTitle,
) {
  return Container(
    margin: const EdgeInsets.all(5),
    child: ElevatedButton(
      onPressed: () => {pressCallback(context)},
      child: Text(buttonTitle),
    ),
  );
}

Widget _buildAccountPickerButton(
  Function pressCallback,
  BuildContext context,
  AccountBean? account,
) {
  return Container(
    margin: const EdgeInsets.all(5),
    child: ElevatedButton(
      onPressed: () async {
        await pressCallback(context);
      },
      child: Text(account != null ? account.name : "选择账户"),
    ),
  );
}
