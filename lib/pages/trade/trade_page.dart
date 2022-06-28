import 'package:flutter/material.dart';

class TradePage extends StatelessWidget {
  const TradePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter layout demo"),
      ),
      body: SizedBox.expand(
        child: Container(
          color: Colors.blue,
          child: Column(
            children: const [
              Text("Hello"),
              Text("World"),
            ],
          ),
        ),
      ),
    );
  }
}

// Row的子级被包裹了Expended以后, 便不能自己决定自身宽度了.
// Row会根据所有Expended的元素来极选其宽度.
// 一旦使用Expended, 子元素自身的宽度无关紧要. 会直接忽略掉
// 每个Expanded大小都会和Flex因子成比例.
// Flexible会强制子元素具有和Flexible相同或者更小的宽度.
// Expanded会强制其子元素具有和Expanded相同的宽度.
// Expanded和Flexible在决定子级大小时, 会忽略宽度.
Widget box25 = Row(
  children: [
    Flexible(
      child: Container(
        color: Colors.red,
        child: const Text(
          "This is a very long text that wont't fit the line",
          style: TextStyle(
            fontSize: 30,
          ),
        ),
      ),
    ),
    Flexible(
      child: Container(
        color: Colors.green,
        child: const Text(
          "GoodBye!",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 30,
          ),
        ),
      ),
    ),
  ],
);

// 1. Row不会对子元素添加任何约束, 让它门成为所需要的任意大小
// 并排放, 多余的部分保持空白
// Row如果子元素超过了本身宽度, 会报错
Widget box23 = Row(
  children: [
    Container(
      color: Colors.red,
      child: const Text(
        'This is a very long Text that won\'t fit the line',
        style: TextStyle(fontSize: 30),
      ),
    ),
    Container(
      color: Colors.green,
      child: const Text(
        "Goodbye",
        style: TextStyle(fontSize: 30),
      ),
    )
  ],
);

// FittedBox只能在有限制的宽高总对子Widget进行缩放.
// 否则不会渲染任何内容.
// 并且会在控制台看到错误.
Widget box22 = FittedBox(
  child: Container(height: 20, width: double.infinity, color: Colors.red),
);

// 只有center的话, Text会从屏幕获取最大宽度, 并在合适的地方换行
Widget box21 = const Center(
  child: Text(
    "This is some very very very large text that is too big to fit a regular screen in a single line...  a long",
    style: TextStyle(
      fontWeight: FontWeight.w700,
      fontSize: 30,
    ),
  ),
);

// FittedBox会尝试根据Text大小调整大小.
// 但不能大于屏幕大小.
// 然后假定屏幕大小, 病调整Text的大小也以使其适合屏幕.
Widget box20 = const Center(
  child: FittedBox(
    child: Text(
      "This is some very very very large text that is too big to fit a regular screen in a single line...  a long",
      style: TextStyle(fontWeight: FontWeight.w700, fontSize: 30),
    ),
  ),
);

// Center将会让FittedBox能够变为任意大小, 取决于屏幕大小.
// FittedBox然后会根据Text调整自己的大小.
// 然后让Text可以变为所需的任意大小,
// 二者具有同一大小, 不会发生缩放.
Widget box19 = const Center(
  child: FittedBox(
    child: Text("Some Example Text"),
  ),
);

// 首先强制FittedBox和屏幕一样大.
// Text则是有一个自然宽度. 取决于文本数量, 字体大小等
// FittedBox让Text可以变为任意大小.
// Text告诉FittedBox其大小后, FittedBox缩放文本直到填满所有可用宽度
Widget box18 = const FittedBox(
  child: Text("Some Example Text"),
);

// LimitedBox限制了大小
// LimitedBox仅仅在UnconstrainedBox下才有用
Widget box17 = UnconstrainedBox(
  child: LimitedBox(
    maxWidth: 100,
    child: Container(
      color: Colors.red,
      width: double.infinity,
      height: 100,
    ),
  ),
);

// 子Container决定自己成为无限宽
// Flutter无法渲染无限宽
Widget box16 = UnconstrainedBox(
  child: Container(
    color: Colors.red,
    width: double.infinity,
    height: 100,
  ),
);

// OverflowBox允许子元素超出空间, 不会显示警告
Widget example15 = OverflowBox(
  minWidth: 0,
  minHeight: 0,
  maxWidth: double.infinity,
  maxHeight: double.infinity,
  child: Container(
    color: Colors.red,
    width: 4000,
    height: 50,
  ),
);

// 子Container过大, 无法容纳在UnconstrainedBox中
// 显示溢出警告
Widget example14 = UnconstrainedBox(
  child: Container(
    color: Colors.red,
    width: 2000,
    height: 50,
  ),
);

// UnconstrainedBox允许子Container可以变为任意大小
Widget example13 = UnconstrainedBox(
  child: Container(
    color: Colors.red,
    width: 20,
    height: 50,
  ),
);

// Center允许ConstrainedBox屏幕限制内的任意大小
// 所以约束生效, 最小70
Widget example10 = Center(
  child: ConstrainedBox(
    constraints: const BoxConstraints(
      minWidth: 70,
      minHeight: 70,
      maxWidth: 150,
      maxHeight: 150,
    ),
    child: Container(
      color: Colors.red,
      width: 10,
      height: 10,
    ),
  ),
);

// ConstrainedBox仅对其从其父级接受到的约束下施加其他约束.
// 上层的约束强迫屏幕大小. 所以, 当前约束被忽略
Widget example9 = ConstrainedBox(
  constraints: const BoxConstraints(
    minWidth: 70,
    minHeight: 70,
    maxWidth: 150,
    maxHeight: 150,
  ),
  child: Container(
    color: Colors.red,
    width: 10,
    height: 10,
  ),
);

// padding带入约束计算中
Widget example8 = Center(
  child: Container(
    padding: const EdgeInsets.all(20),
    color: Colors.red,
    child: Container(
      width: 50,
      height: 50,
      color: Colors.green,
    ),
  ),
);

// Center告诉红Container不能超过屏幕
// 红Container没有固定大小, 所以跟随自己大小,
// 红Container告诉绿Container可以任意大小, 但不能超过屏幕
// 绿Container想要一个50*50的, 所以红色也就是50*50
// 绿色覆盖了红色
Widget example7 = Center(
  child: Container(
    color: Colors.red,
    child: Container(
      width: 50,
      height: 50,
      color: Colors.green,
    ),
  ),
);

// Container没有子元素, 没有固定大小, 所以决定有多大就有多大
Widget example6 = Center(
  child: Container(color: Colors.red),
);

// Center和屏幕一样大
// Center告诉Container可以任意大小, 但不能超过屏幕
// Container宽高想要无限大, 所以充满屏幕
Widget example5 = Center(
  child: Container(
    width: double.infinity,
    height: double.infinity,
    color: Colors.red,
  ),
);

// 3同理
Widget example4 = Align(
  alignment: Alignment.bottomRight,
  child: Container(
    width: 100,
    height: 100,
    color: Colors.red,
  ),
);

// Center变得和屏幕一样大.
// Center告诉Container可以改变大小, 但不能超过屏幕
Widget example3 = Center(
  child: Container(
    width: 100,
    height: 100,
    color: Colors.red,
  ),
);

// 父组件强制example变为这么大
Widget example2 = Container(
  width: 100,
  height: 100,
  color: Colors.red,
);

// 整个屏幕作为Container, 并强制Container和屏幕一样大
Widget example1 = Container(
  color: Colors.red,
);
