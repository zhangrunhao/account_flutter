import 'package:flutter/material.dart';

class TopSwitch extends StatefulWidget {
  const TopSwitch({super.key});
  @override
  State<StatefulWidget> createState() => _TopSwitchState();
}

class _TopSwitchState extends State<TopSwitch> {
  int active = 0;
  @override
  Widget build(BuildContext context) {
    List<String> arr = ["资产", "负债"];
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 44,
      alignment: Alignment.center,
      child: SizedBox(
        width: 135,
        height: 35,
        child: Row(
          children: List.generate(arr.length, (index) {
            return _SwitchItem(
              isActive: !!(active == index),
              text: arr[index],
              isFirstItem: index == 0,
              isLastItem: index == arr.length - 1,
              onTap: () {
                setState(() {
                  active = index;
                });
              },
            );
          }),
        ),
      ),
    );
  }
}

class _SwitchItem extends StatelessWidget {
  final bool isFirstItem;
  final bool isLastItem;
  final bool isActive;
  final String text;
  final Function()? onTap;

  const _SwitchItem({
    required this.isActive,
    required this.text,
    required this.isFirstItem,
    required this.isLastItem,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isActive
                ? const Color.fromARGB(255, 16, 92, 251)
                : const Color.fromARGB(0, 0, 0, 0),
            borderRadius: isFirstItem
                ? const BorderRadius.only(
                    topLeft: Radius.circular(5),
                    bottomLeft: Radius.circular(5),
                  )
                : isLastItem
                    ? const BorderRadius.only(
                        topRight: Radius.circular(5),
                        bottomRight: Radius.circular(5),
                      )
                    : null,
            border: Border.all(
              color: const Color.fromARGB(255, 16, 92, 251),
              width: 1,
              style: BorderStyle.solid,
            ),
          ),
          child: Text(
            text,
            style: TextStyle(
              color: isActive ? Colors.white : Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w500,
              decoration: TextDecoration.none,
            ),
          ),
        ),
      ),
    );
  }
}
