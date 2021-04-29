typedef void EventCallback(arg);

class EventBus {
  //构造函数私有
  EventBus._internal();

  //单例
  static EventBus _singleton = new EventBus._internal();

  //工厂构造函数：当执行构造函数并不总是创建这个类的一个新实例时，则使用 factory 关键字
  factory EventBus() => _singleton;

  var _emap = new Map<Object, List<EventCallback>>();

  void on(Object eventName, EventCallback f) {
    //空安全检查，使用IDE自动fix
    //无法使用：new List<EventCallback>()
    _emap[eventName] ??= <EventCallback>[];
    _emap[eventName]!.add(f);
  }

  void off(Object eventName, [EventCallback? f]) {
    if (_emap[eventName] == null) {
      return;
    }
    if (f == null) {
      _emap[eventName]!.clear();
    } else {
      _emap[eventName]!.remove(f);
    }
  }

  void emit(Object eventName, [arg]) {
    final list = _emap[eventName];
    if (list == null) {
      return;
    }
    int len = list.length - 1;
    //反向遍历，防止订阅者在回调中移除自身导致下标错位
    for (var i = len; i >= 0; --i) {
      list[i](arg);
    }
  }
}
var bus = new EventBus();