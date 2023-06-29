import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TradeSingle extends StatelessWidget {
  const TradeSingle({super.key});

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        extentRatio: .4,
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            label: "编辑",
            backgroundColor:const  Color(0xFFD1E0FF),
            foregroundColor: const Color(0xFF105CFB),
            onPressed: (context) {},
          ),
          SlidableAction(
            label: "删除",
            backgroundColor:const  Color(0xFFFFDBE0),
            foregroundColor: const Color(0xFFFF0000),
            onPressed: (context) {},
          ),
        ],
      ),
      child: const TradeSingleUI(),
    );
  }
}

class TradeSingleUI extends StatelessWidget {
  const TradeSingleUI({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 60,
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
