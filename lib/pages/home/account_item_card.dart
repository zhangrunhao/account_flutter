import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class AccountItemCard extends StatelessWidget {
  const AccountItemCard({super.key});
  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: const ActionPane(
        extentRatio: .25,
        motion: ScrollMotion(),
        children: [
          _OperationUI(),
        ],
      ),
      child: _AccountItemCardUI(),
    );
  }
}

class _OperationUI extends StatelessWidget {
  const _OperationUI();
  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _OperationItemUI(
          bgColor: Color.fromARGB(255, 209, 224, 255),
          iconData: Icons.edit,
          title: "编辑",
          iconColor: Color.fromARGB(255, 16, 92, 251),
        ),
        _OperationItemUI(
          bgColor: Color.fromARGB(255, 255, 219, 224),
          iconData: Icons.delete,
          title: "删除",
          iconColor: Color.fromARGB(255, 255, 0, 0),
        ),
      ],
    );
  }
}

class _OperationItemUI extends StatelessWidget {
  final Color bgColor;
  final IconData iconData;
  final String title;
  final Color iconColor;
  const _OperationItemUI({
    required this.bgColor,
    required this.iconData,
    required this.title,
    required this.iconColor,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 75,
      height: 58,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        color: bgColor,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Icon(
            iconData,
            color: iconColor,
          ),
          Text(
            title,
            style: TextStyle(color: iconColor),
          ),
        ],
      ),
    );
  }
}

class _AccountItemCardUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 130,
      child: Center(
        child: Container(
          width: 335,
          height: 130,
          decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
              Color.fromARGB(255, 16, 92, 251),
              Color.fromARGB(255, 10, 171, 255)
            ]),
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Positioned(
              //   right: 8,
              //   child: Container(
              //     width: 4,
              //     height: 20,
              //     color: const Color.fromARGB(255, 203, 207, 222),
              //   ),
              // ),
              const Positioned(
                top: 20.5,
                left: 20,
                child: Text(
                  "当前余额:",
                  style: TextStyle(
                    fontSize: 12,
                    decoration: TextDecoration.none,
                    color: Colors.white60,
                  ),
                ),
              ),
              const Positioned(
                top: 14,
                right: 14,
                child: Icon(
                  Icons.keyboard_arrow_right,
                  size: 18,
                  color: Colors.white,
                ),
              ),
              const Positioned(
                bottom: 20,
                left: 20,
                child: Text(
                  "889888",
                  style: TextStyle(
                    fontSize: 28,
                    decoration: TextDecoration.none,
                    color: Colors.white,
                  ),
                ),
              ),
              Positioned(
                bottom: 20,
                right: 20,
                child: Container(
                  width: 40,
                  height: 40,
                  color: Colors.white,
                  child: Image.asset(
                    "images/account_icons/zhifubao.png",
                    width: 40,
                    height: 40,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
