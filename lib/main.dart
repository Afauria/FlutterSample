import 'package:flutter/material.dart';
import 'package:flutter_sample/pages/sample3_random_words.dart';
import 'package:flutter_sample/pages/sample2_router.dart';
import 'package:flutter_sample/pages/sample1_counter.dart';
import 'package:flutter_sample/pages/sample4_assets.dart';
import 'package:flutter_sample/pages/sample5_get_counter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // home: MyHomePage(title: 'Flutter Demo Home Page'),
      //将名为"/"的路由作为应用的home(首页)，不能和home参数一起使用
      initialRoute: "/",
      //注册路由表
      routes: {
        "/": (context) => MyHomePage(title: "Flutter Demo Home Page"),
        "sample1_counter": (context) => CounterPage(),
        "sample2_router": (context) => RouterPage(),
        "sample3_random_words": (context) => RandomWordsPage(),
        "sample4_assets": (context) => AssetsPage(),
        "sample5_get_counter": (context) => GetXCounter(),
        "router_by_named": (context) => RouterByNamed(),
        //命名路由传递参数，通过arguments参数
        "router_with_param_by_named": (context) => RouterWithParamByNamed(),
        //如果路由页面构造函数接收参数，可以在构造的时候就获取参数
        "router_with_param": (context) =>
            RouterWithParam(ModalRoute.of(context).settings.arguments),
        "router_with_result": (context) => RouterWithResult(),
      },
      onUnknownRoute: (RouteSettings settings) {
        //找不到路由时会被调用。可以用来做错误页面
        //如果使用了onGenerateRoute，该方法不会被调用
        print("onUnknownRoute: route page is null");
        return null;
      },
      onGenerateRoute: (RouteSettings settings) {
        //路由生成回调：会先从路由表中找，如果路由表中没有注册，会调用该方法生成路由
        //只对命名路由生效
        //可以在该回调中加登录检查
        return MaterialPageRoute(builder: (context) {
          //const和final修饰不可变值，const编译时就已经确定，因此无法使用
          final routerName = settings.name;
          print("onGenerateRoute: $routerName");
          if (routerName == "new_page") {
            return NewPage();
          }
          //返回null会抛异常，不会再往下调onUnknownRoute
          return null;
        });
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        /// State可以获取widget的变量值
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
            // Column is also a layout widget. It takes a list of children and
            // arranges them vertically. By default, it sizes itself to fit its
            // children horizontally, and tries to be as tall as its parent.
            //
            // Invoke "debug painting" (press "p" in the console, choose the
            // "Toggle Debug Paint" action from the Flutter Inspector in Android
            // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
            // to see the wireframe for each widget.
            //
            // Column has various properties to control how it sizes itself and
            // how it positions its children. Here we use mainAxisAlignment to
            // center the children vertically; the main axis here is the vertical
            // axis because Columns are vertical (the cross axis would be
            // horizontal).
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () =>
                      Navigator.pushNamed(context, "sample1_counter"),
                  child: Text("示例1：计数器")),
              ElevatedButton(
                  onPressed: () =>
                      Navigator.pushNamed(context, "sample2_router"),
                  child: Text("示例2：路由管理")),
              ElevatedButton(
                  onPressed: () =>
                      Navigator.pushNamed(context, "sample3_random_words"),
                  child: Text("示例3：随机单词（包管理）")),
              ElevatedButton(
                  onPressed: () =>
                      Navigator.pushNamed(context, "sample4_assets"),
                  child: Text("示例4：资源管理")),
              ElevatedButton(
                  onPressed: () =>
                      Navigator.pushNamed(context, "sample5_get_counter"),
                  child: Text("示例5：GetX示例")),
            ]),
      ),
    );
  }
}