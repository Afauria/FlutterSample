import 'package:flutter/material.dart';

class CounterPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => CounterState();
}

class CounterState extends State {
  int _counter = 0;

  void _incrementCounter() {
    _counter++;
    //setState用于重新触发build
    setState(() {
      //变量改变放在里面和外面一样
      // _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("示例1：计数器")),
      body: Center(
        child: Text(
          '$_counter',
          style: Theme.of(context).textTheme.headline4,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), //使用逗号结尾，能使自动化格式更合适
    );
  }
}
