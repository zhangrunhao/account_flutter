import 'package:flutter/material.dart';

class YearTradeList extends StatefulWidget {
  const YearTradeList();

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
              _TradeWidget(),
              _TradeWidget(),
              _TradeWidget(),
              _TradeWidget(),
              _TradeWidget(),
              _TradeWidget(),
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

class _TradeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 60,
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Colors.black,
            style: BorderStyle.solid,
            width: 1,
          ),
        ),
      ),
      padding: const EdgeInsets.only(left: 16.5, right: 5),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _TradeIcon(),
          Expanded(child: _TradeInfo()),
          Align(
            alignment: Alignment.centerRight,
            child: _AccountMoney(),
          ),
        ],
      ),
    );
  }
}

class _TradeIcon extends StatelessWidget {
  const _TradeIcon();
  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 23,
      child: Icon(Icons.access_alarms, size: 23),
    );
  }
}

class _TradeInfo extends StatelessWidget {
  const _TradeInfo();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 8, bottom: 9, left: 11.5),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "餐饮日常",
            style: TextStyle(
              fontSize: 15,
              color: Color(0xff1f1f24),
              fontWeight: FontWeight.w600,
              decoration: TextDecoration.none,
            ),
          ),
          Text(
            "充电宝 01/01 12:20",
            style: TextStyle(
                fontSize: 12,
                color: Color(0xff84868f),
                decoration: TextDecoration.none),
          ),
        ],
      ),
    );
  }
}

class _AccountMoney extends StatelessWidget {
  const _AccountMoney();
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          "50.01",
          style: TextStyle(
            color: Color(0xff1f1f24),
            fontSize: 18,
            fontWeight: FontWeight.w600,
            decoration: TextDecoration.none,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 13),
          width: 2,
          height: 10,
          color: const Color(0xFFCBCFDE),
        ),
      ],
    );
  }
}
