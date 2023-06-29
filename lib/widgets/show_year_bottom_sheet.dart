import 'package:flutter/material.dart';

Future<String> showYearBottomSheet(
  BuildContext context,
  List<String> titleList, {
  int defaultIndex = 0,
}) async {
  String res = await showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.only(left: 15, right: 15),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            color: Colors.white,
          ),
          child: ListView.separated(
            itemBuilder: ((context, index) {
              return SizedBox(
                height: 65,
                child: ListTile(
                  trailing: index == defaultIndex
                      ? const Icon(
                          Icons.check,
                          size: 12,
                          color: Color(0xFF1F1F24),
                        )
                      : null,
                  title: Text(
                    titleList[index],
                    textAlign: TextAlign.left,
                  ),
                  onTap: () {
                    Navigator.of(context).pop(titleList[index]);
                  },
                ),
              );
            }),
            separatorBuilder: (context, index) {
              return const Divider(
                height: .5,
                color: Color(0xFFDBDCE6),
              );
            },
            itemCount: titleList.length,
          ),
        );
      });
  return res;
}
