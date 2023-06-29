import 'package:account_flutter/pages/account_detail/trade_single.dart';
import 'package:flutter/material.dart';

class YearTradeList extends StatefulWidget {
  const YearTradeList({super.key});

  @override
  YearTradeListState createState() => YearTradeListState();
}

class YearTradeListState extends State<YearTradeList> {
  final List<MonthItem> _data = generateItems(12);

  @override
  Widget build(BuildContext context) {
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          _data[index].isExpanded = !isExpanded;
        });
      },
      elevation: 0,
      expandedHeaderPadding: const EdgeInsets.all(0),
      dividerColor: const Color(0xFFDBDCE6),
      animationDuration: const Duration(microseconds: 300),
      children: _data.map((MonthItem e) {
        return ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              title: Text(e.text),
            );
          },
          body: Column(
            children: [
              TradeSingle(),
              TradeSingle(),
              TradeSingle(),
            ],
          ),
          isExpanded: e.isExpanded,
        );
      }).toList(),
    );
  }
}

class MonthItem {
  MonthItem({
    required this.text,
    this.isExpanded = false,
  });
  String text;
  bool isExpanded;
}

List<MonthItem> generateItems(int numberOfItems) {
  return List<MonthItem>.generate(numberOfItems, (int index) {
    return MonthItem(text: '${index + 1}月');
  });
}
