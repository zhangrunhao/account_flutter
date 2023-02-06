typedef EventCallback = void Function(Object arg);

class EventBus {
  // 私有函数
  EventBus._internal();

  // 保存单例
  static final EventBus _singleton = EventBus._internal();

  // 工厂构造函数
  factory EventBus() => _singleton;

  // 保存事件订阅者队列, key: 事件名(id), value: 对应事件的订阅者队列
  final _emap = <Object, List<EventCallback>?>{};

  // 添加订阅者
  void on(eventName, EventCallback f) {
    _emap[eventName] ??= <EventCallback>[];
    _emap[eventName]!.add(f);
  }

  // 移除订阅者

  // 触发事件
  void emit(eventName, [arg]) {
    var list = _emap[eventName];
    if (list == null) return;
    int len = list.length - 1;
    // 反向遍历, 防止订阅者在回调中移除自身带来的下标错位
    for (var i = len; i > -1; i--) {
      list[i](arg);
    }
  }
}
