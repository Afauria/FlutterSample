import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Controller extends GetxController {
  var count = 0.obs;

  increment() => count++;
}

class GetXCounter extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // 使用Get.put()实例化你的类，使其对当下的所有子路由可用。
    final Controller c = Get.put(Controller());

    return Scaffold(
      appBar: AppBar(
        title: Text("示例5：get实现计数器"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(() => Text(
                  '${c.count}',
                  style: Theme.of(context).textTheme.headline4,
                )),
            ElevatedButton(
              //使用Get进行路由跳转，需要GetMaterialApp
              onPressed: () => Get.to(Other()),
              child: Text("GetX 路由跳转"),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: c.increment,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}

class Other extends StatelessWidget {
  final Controller c = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("GetX路由跳转")),
      body: Center(
        child: Text("${c.count}"),
      ),
    );
  }
}
