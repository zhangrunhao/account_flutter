import 'package:flutter/material.dart';

class NameForm extends StatelessWidget {
  final GlobalKey formKey;
  final TextEditingController nameController;
  final String? iconName;
  final String operateName;

  const NameForm(
      {super.key,
      required this.formKey,
      required this.nameController,
      required this.operateName,
      this.iconName});

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: <Widget>[
          TextFormField(
            key: formKey,
            controller: nameController,
            decoration: InputDecoration(
              labelText: operateName,
              hintText: "请输入$operateName",
              prefixIcon: _PrefixIcon(iconName),
            ),
          ),
        ],
      ),
    );
  }
}

class _PrefixIcon extends StatelessWidget {
  final String? iconName;

  const _PrefixIcon(this.iconName);

  @override
  Widget build(BuildContext context) {
    if (iconName == null) {
      return const Icon(Icons.emoji_emotions);
    } else {
      return Container(
        padding: const EdgeInsets.all(5),
        height: 30,
        width: 30,
        child: Image.asset("images/cate_icons/$iconName.png"),
      );
    }
  }
}
