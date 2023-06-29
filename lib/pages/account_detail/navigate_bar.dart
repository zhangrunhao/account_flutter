import 'package:account_flutter/bean/account_bean.dart';
import 'package:account_flutter/widgets/show_year_bottom_sheet.dart';
import 'package:flutter/material.dart';

class NavigateBar extends StatelessWidget {
  final AccountBean accountBean;
  const NavigateBar({super.key, required this.accountBean});

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
          const _YearSelect(),
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

class _YearSelect extends StatelessWidget {
  const _YearSelect();

  Future<String> _selectYear(BuildContext context) async {
    List<String> arr = ["1992", "2001", "2002", "2012", "2013", "1992", "2001"];
    return await showYearBottomSheet(context, arr);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        String year = await _selectYear(context);
        print(year);
      },
      child: Container(
        width: 64,
        height: 25,
        color: Colors.white24,
        padding: const EdgeInsets.only(right: 5, left: 6),
        child: const Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "2023",
                style: TextStyle(
                  fontSize: 14,
                  color: Color.fromARGB(255, 4, 11, 32),
                  decoration: TextDecoration.none,
                ),
              ),
              Icon(Icons.keyboard_arrow_down_outlined, size: 14),
            ],
          ),
        ),
      ),
    );
  }
}
