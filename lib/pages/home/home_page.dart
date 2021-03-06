import 'package:account_flutter/pages/home/brief_page.dart';
import 'package:account_flutter/pages/home/wallet_widget.dart';
import 'package:account_flutter/router.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  int _selectIndex = 0;
  static const List<Widget> _pageWidget = <Widget>[BriefWidget(), WalletWidget()];

  void _onItemTapped(int index) {
    setState(() {
      _selectIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("首页"),
      ),      
      body: _pageWidget.elementAt(_selectIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '摘要',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.wallet),
            label: '钱包',
          ),
        ],
        onTap: _onItemTapped,
        currentIndex: _selectIndex,
        selectedItemColor: Colors.amber[800],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (() => MyRouter.push(context, "app://trade")),
        child: const Icon(Icons.add),
      ),
    );
  }
}
