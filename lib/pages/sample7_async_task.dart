import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AsyncTaskPage extends StatelessWidget {
  Future<String> loadAssets({BuildContext? context}) async {
    if (context == null) {
      print("loadAssets with rootBundle");
      return await rootBundle.loadString("assets/config.json");
    }
    print("loadAssets with DefaultAssetBundle");
    return await DefaultAssetBundle.of(context)
        .loadString("assets/config.json");
  }

  @override
  Widget build(BuildContext context) {
    Future<String> task = loadAssets();
    // 使用FutureBuilder，继承StatefulWidget，内部监听了future调用setState
    FutureBuilder<String> builder = FutureBuilder(
        future: task,
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          return Text(snapshot.data.toString());
        });
    //periodic流是无限的
    //使用take和takeWhile可以限制元素的数量
    Stream<String> stream = Stream.periodic(Duration(seconds: 1), (i) {
      return i.toString();
    }).take(5);
    StreamBuilder<String> streamBuilder = StreamBuilder(
        initialData: "-1",
        stream: stream,
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (snapshot.hasError) {
            return Text("error: ${snapshot.error}");
          }
          var text = "";
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              text = "没有stream";
              break;
            case ConnectionState.waiting:
              text = "等待数据";
              break;
            case ConnectionState.active:
              text = "激活状态：${snapshot.data}";
              break;
            case ConnectionState.done:
              text = "Stream关闭";
              break;
          }
          return Text(text);
        });
    return Scaffold(
      appBar: AppBar(
        title: Text("异步任务和异步流"),
      ),
      body: Center(
        child: Column(
          children: [
            builder,
            streamBuilder,
          ],
        ),
      ),
    );
  }
}
