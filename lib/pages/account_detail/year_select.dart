import 'package:account_flutter/widgets/show_year_bottom_sheet.dart';
import 'package:flutter/material.dart';

class YearSelect extends StatefulWidget {
  final List<String> years;

  const YearSelect({super.key, required this.years});

  @override
  State<StatefulWidget> createState() => _YearSelectState();
}

class _YearSelectState extends State<YearSelect> {
  String year = "";

  Future<String> _selectYear(BuildContext context) async {
    return await showYearBottomSheet(context, widget.years);
  }

  @override
  void initState() {
    super.initState();
    String year = widget.years.isNotEmpty
        ? widget.years[0]
        : DateTime.now().year.toString();
    setState(() {
      this.year = year;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        String year = await _selectYear(context);
        setState(() {
          this.year = year;
        });
      },
      child: Container(
        width: 64,
        height: 25,
        color: Colors.white24,
        padding: const EdgeInsets.only(right: 5, left: 6),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                year,
                style: const TextStyle(
                  fontSize: 14,
                  color: Color.fromARGB(255, 4, 11, 32),
                  decoration: TextDecoration.none,
                ),
              ),
              const Icon(Icons.keyboard_arrow_down_outlined, size: 14),
            ],
          ),
        ),
      ),
    );
  }
}
