import 'package:flutter/material.dart';
import 'package:flutter_sample/common/event_bus.dart';

class EventBusPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bus.on("onClick", (arg) => print(arg));
    return Scaffold(
      appBar: AppBar(
        title: Text("时间总线案例"),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
                onPressed: () => bus.emit("onClick", "Hello"), child: Text("按钮1"))
          ],
        ),
      ),
    );
  }
}
