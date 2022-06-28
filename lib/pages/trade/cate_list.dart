import 'package:flutter/material.dart';

class CateList extends StatelessWidget {
  const CateList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildCard();
  }
}

Widget _buildCard() {
  return Container(
    margin: const EdgeInsets.all(40),
    height: 210,
    child: Card(
      child: Column(
        children: [
          ListTile(
            title: const Text(
              "1625 Main Street",
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            subtitle: const Text("My City CA 99qqq8"),
            leading: Icon(
              Icons.restaurant_menu,
              color: Colors.blue[500],
            ),
          ),
          const Divider(),
          ListTile(
            title: const Text(
              "ak47",
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            leading: Icon(
              Icons.contact_phone,
              color: Colors.blue[500],
            ),
          ),
          ListTile(
            title: const Text("coasta@example.com"),
            leading: Icon(
              Icons.mail,
              color: Colors.blue[500],
            ),
          )
        ],
      ),
    ),
  );
}
