import 'package:account_flutter/api/trade_api.dart';
import 'package:account_flutter/bean/trade_bean.dart';
import 'package:account_flutter/widgets/trade_widget.dart';
import 'package:flutter/material.dart';

class BriefWidget extends StatefulWidget {
  const BriefWidget({super.key});

  @override
  State<StatefulWidget> createState() {
    return _BriefWidgetState();
  }
}

class _BriefWidgetState extends State with RouteAware {
  List<TradeBean> trades = [];

  void _fetch() {
    TradeApi.getList({}).then((value) {
      setState(() {
        trades = value;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _fetch();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: trades.length,
      itemBuilder: (BuildContext context, int index) {
        TradeBean trade = trades[index];
        return TradeWidget(
          trade: trade,
          updateCallback: () {
            _fetch();
          },
        );
      },
    );
  }
}
