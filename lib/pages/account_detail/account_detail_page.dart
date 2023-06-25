import 'package:account_flutter/bean/account_bean.dart';
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
          NavigateBar(
            accountIcon: Image.asset(
              "images/account_icons/${accountBean.icon}",
              width: 15,
              height: 15,
            ),
            accountName: accountBean.name,
          ),
        ],
      ),
    );
  }
}

class NavigateBar extends StatelessWidget {
  final Image accountIcon;
  final String accountName;
  const NavigateBar(
      {super.key, required this.accountIcon, required this.accountName});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.center,
      height: 44,
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const BackIcon(),
          CenterInfo(accountIcon: accountIcon, accountName: accountName),
          Container(
            width: 64,
            height: 25,
            color: Colors.amber,
          )
        ],
      ),
    );
  }
}

class CenterInfo extends StatelessWidget {
  final Image accountIcon;

  final String accountName;

  const CenterInfo(
      {super.key, required this.accountIcon, required this.accountName});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          margin: const EdgeInsets.only(right: 5),
          child: accountIcon,
        ),
        Text(
          accountName,
          style: const TextStyle(
            fontSize: 18,
            decoration: TextDecoration.none,
          ),
          strutStyle: const StrutStyle(leading: 2.1),
        ),
      ],
    );
  }
}

class BackIcon extends StatelessWidget {
  const BackIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: const SizedBox(
        width: 44,
        height: 44,
        child: Center(
          child: Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black87,
            size: 18,
          ),
        ),
      ),
    );
  }
}
