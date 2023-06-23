import 'package:flutter/material.dart';

class AccountListInfo extends StatelessWidget {
  final int accountNum;
  const AccountListInfo({super.key, required this.accountNum});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(left: 20, top: 20, right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "我的资产(${accountNum.toString()})",
            style: const TextStyle(
              fontSize: 23,
              decoration: TextDecoration.none,
              color: Color.fromARGB(255, 4, 11, 32),
            ),
          ),
          const _AddButton(),
        ],
      ),
    );
  }
}

class _AddButton extends StatelessWidget {
  const _AddButton();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 25,
      decoration: const BoxDecoration(
        color: Color.fromRGBO(255, 255, 255, 0.2),
      ),
      child: const Padding(
        padding: EdgeInsets.only(left: 6, right: 6),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.add,
                size: 14,
              ),
              Text(
                "添加",
                style: TextStyle(
                  decoration: TextDecoration.none,
                  fontSize: 14,
                  color: Color.fromARGB(255, 4, 11, 32),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
