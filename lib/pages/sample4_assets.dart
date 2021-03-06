import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AssetsPage extends StatelessWidget {
  Future<String> loadAssets({BuildContext? context}) async {
    if (context == null) {
      print("loadAssets with rootBundle");
      //service一般用于保存全局单例
      return await rootBundle.loadString("assets/config.json");
    }
    print("loadAssets with DefaultAssetBundle");
    return await DefaultAssetBundle.of(context)
        .loadString("assets/config.json");
  }

  @override
  Widget build(BuildContext context) {
    String config = "资源管理";
    loadAssets(context: context).then((value) {
      print(value);
      // 需要使用setState刷新
      //或者使用FutureBuilder，见Sample7，继承StatefulWidget，内部监听了future调用setState
    });

    return Scaffold(
      appBar: AppBar(title: Text("资源管理")),
      body: Column(children: [
        Text(config),
        Image.asset("assets/ic_launcher.png"),
        //两种方式加载资源图片
        Image(image: AssetImage("assets/ic_launcher.png"))
      ]),
    );
  }
}
