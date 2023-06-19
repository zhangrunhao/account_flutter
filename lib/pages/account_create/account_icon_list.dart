import 'package:flutter/material.dart';

class IconOption {
  final Text title;
  final Image leading;

  const IconOption({
    required this.title,
    required this.leading,
  });
}

class AccountIconList extends StatelessWidget {
  final String title;
  final List<IconOption> icons;

  const AccountIconList({
    super.key,
    required this.title,
    required this.icons,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Center(
            child: Text(title),
          ),
          ListView.builder(
            itemBuilder: ((context, index) {
              IconOption i = icons[index];
              return ListTile(
                title: i.title,
                leading: i.leading,
              );
            }),
            itemCount: icons.length,
          )
        ],
      ),
    );
  }
}
