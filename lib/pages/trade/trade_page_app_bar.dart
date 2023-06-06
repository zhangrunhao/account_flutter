import 'package:flutter/material.dart';

const List<Tab> tabs = <Tab>[
  Tab(
    text: '收入',
  ),
  Tab(
    text: '支出',
  ),
];

class TradePageAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TradePageAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const TabBar(
        tabs: tabs,
      ),
      actions: [
        SizedBox(
          width: 80,
          child: GestureDetector(
            onTap: (() {
            }),
            child: const Icon(Icons.settings),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}
