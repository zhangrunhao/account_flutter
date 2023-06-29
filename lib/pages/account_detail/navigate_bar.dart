import 'package:account_flutter/bean/account_bean.dart';
import 'package:account_flutter/pages/account_detail/year_select.dart';
import 'package:flutter/material.dart';

class NavigateBar extends StatelessWidget {
  final AccountBean accountBean;
  final List<String> years;
  const NavigateBar({super.key, required this.accountBean, required this.years});

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
          const _BackIcon(),
          _CenterInfo(
            accountBean: accountBean,
          ),
          YearSelect(
            years: years,
          ),
        ],
      ),
    );
  }
}

class _CenterInfo extends StatelessWidget {
  final AccountBean accountBean;

  const _CenterInfo({required this.accountBean});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          margin: const EdgeInsets.only(right: 5),
          child: Image.asset(
            "images/account_icons/${accountBean.icon}",
            width: 15,
            height: 15,
          ),
        ),
        Text(
          accountBean.name,
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

class _BackIcon extends StatelessWidget {
  const _BackIcon();

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
