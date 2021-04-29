import 'package:flutter/material.dart';

class InheritedWidgetTest extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _InheritedWidgetTestState();
  }
}

class _InheritedWidgetTestState extends State<InheritedWidgetTest> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("数据共享"),
      ),
      body: Center(
        child: ShareDataWidget(count, TestWidget()),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => setState(() => count++),
        child: Icon(Icons.add),
      ),
    );
  }
}

///子组件可以使用该组件中的数据，多个子组件可共享一个InheritedWidget的数据
class ShareDataWidget extends InheritedWidget {
  ShareDataWidget(this.data, Widget child) : super(child: child);
  final int data;

  //定义一个便捷方法，方便子树中的widget获取共享数据
  static ShareDataWidget of(BuildContext context) {
    ///该方法给子组件注册父组件依赖，因此父组件变化，可以通知到子组件
    return context.dependOnInheritedWidgetOfExactType<ShareDataWidget>()!;
    //使用下面的方法获取InheritedWidget，数据变化的时候不会调用didChangeDependencies方法
  //  return context.getElementForInheritedWidgetOfExactType<ShareDataWidget>().widget;
  }

  ///父组件数据变化的时候，是否通知子组件
  @override
  bool updateShouldNotify(covariant ShareDataWidget oldWidget) {
    //如果返回true，通知依赖本Widget的子组件，调用state.didChangeDependencies方法
    return oldWidget.data != data;
  }
}

class TestWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _TestWidgetState();
}

class _TestWidgetState extends State<TestWidget> {
  @override
  Widget build(BuildContext context) {
    return Text(ShareDataWidget.of(context).data.toString());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    //父或祖先widget中的InheritedWidget改变(updateShouldNotify返回true)时会被调用。
    //如果build中没有依赖InheritedWidget，则此回调不会被调用。
    print("Dependencies change");
  }
}
