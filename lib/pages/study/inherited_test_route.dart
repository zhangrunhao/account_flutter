import 'package:flutter/material.dart';

class InheritedWidgetTestRoute extends StatefulWidget {
  const InheritedWidgetTestRoute({super.key});

  @override
  State<StatefulWidget> createState() {
    return InheritedWidgetTestRouteState();
  }
}

class InheritedWidgetTestRouteState extends State {
  int data = 0;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SharedDataWidget(
        data,
        child: Column(
          children: [
            _TestWidget(),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  data = data + 1;
                });
              },
              child: const Text("点击"),
            ),
          ],
        ),
      ),
    );
  }
}

class SharedDataWidget extends InheritedWidget {
  
  const SharedDataWidget(this.data, {super.key, required super.child});

  final int data; // 需要在子树中共享的数据

  // 定义一个便捷方法, 方便子树中的widget获取数据
  static SharedDataWidget? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<SharedDataWidget>();
    // return  context.getElementForInheritedWidgetOfExactType<SharedDataWidget>().widget;
  }

  // 该回调决定当data变化时, 是否通知子树中依赖data的widget是否变化
  @override
  bool updateShouldNotify(SharedDataWidget oldWidget) {
    return oldWidget.data != data;
  }
}

class _TestWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TestWidgetState();
  }
}

class _TestWidgetState extends State {
  @override
  Widget build(BuildContext context) {
    // 使用inheritedWidget获取数据
    int data = SharedDataWidget.of(context)?.data ?? 0;
    return Text(
      data.toString(),
      style: const TextStyle(
        fontSize: 30,
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    debugPrint("dependencies change");
  }
}
