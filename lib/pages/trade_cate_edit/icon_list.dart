import 'package:flutter/material.dart';

typedef IconTap = void Function(String iconName);

class IconsList extends StatelessWidget {
  final List<String> icons;
  final IconTap iconTapCallBack;

  const IconsList(
      {super.key, required this.icons, required this.iconTapCallBack});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      crossAxisCount: 5,
      padding: const EdgeInsets.all(5),
      children: icons
          .map((String iconName) => GestureDetector(
                onTap: (() {
                  iconTapCallBack(iconName);
                }),
                child: Card(
                  color: Colors.grey[300],
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    child: Center(
                        child: Image.asset("images/cates/$iconName")),
                  ),
                ),
              ))
          .toList(),
    );
  }
}
