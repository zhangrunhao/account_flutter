import 'package:account_flutter/bean/account_bean.dart';
import 'package:account_flutter/pages/account_detail/account_info.dart';
import 'package:account_flutter/pages/account_detail/navigate_bar.dart';
import 'package:account_flutter/widgets/bg_widget.dart';
import 'package:flutter/material.dart';

class AccountDetailPage extends StatelessWidget {
  final AccountBean accountBean;
  const AccountDetailPage({super.key, required this.accountBean});
  @override
  Widget build(BuildContext context) {
    return BgWidget(
      child: Column(
        children: [
          NavigateBar(accountBean: accountBean),
          AccountInfo(accountBean: accountBean),
          _YearTradeList(),
        ],
      ),
    );
  }
}

class _YearTradeList extends StatefulWidget {
  const _YearTradeList();

  @override
  _YearTradeListState createState() => _YearTradeListState();
}

class _YearTradeListState extends State<_YearTradeList> {
  @override
  Widget build(BuildContext context) {
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {},
      elevation: 0,
      expandedHeaderPadding: const EdgeInsets.all(0),
      dividerColor: const Color(0xFFDBDCE6),
      animationDuration: const Duration(microseconds: 300),
      children: [
        ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return GestureDetector(
              onTap: () {},
              child: const ListTile(
                title: Text('01月'),
              ),
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
          isExpanded: true,
        ),
        ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return GestureDetector(
              onTap: () {},
              child: const ListTile(
                title: Text('01月'),
              ),
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
          isExpanded: true,
        ),
        ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return GestureDetector(
              onTap: () {},
              child: const ListTile(
                title: Text('01月'),
              ),
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
          isExpanded: true,
        ),
      ],
    );
  }
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
