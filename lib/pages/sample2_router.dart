import 'package:flutter/material.dart';

class RouterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("示例2：路由管理")),
      body: Center(
        child: Column(
          children: [
            TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    //builder传入一个函数作为参数，buildContent的时候调用该函数，相当于重写buildContent，返回新页面Widget
                    MaterialPageRoute(builder: (context) {
                      return NewPage();
                    }),
                  );
                },
                child: Text("直接创建路由")),
            TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, "router_by_named");
                },
                child: Text("使用命名路由")),
            TextButton(
                onPressed: () {
                  //new_page未注册到路由表中
                  Navigator.pushNamed(context, "new_page");
                },
                child: Text("使用命名路由启动未注册的路由页面")),
            TextButton(
                onPressed: () {
                  //接收返回值，相当于startActivityForResult，通过Future异步获取返回值
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      //路由传值
                      return RouterWithParam("跳转参数");
                    }),
                  );
                },
                child: Text("直接创建路由，构造方法传递参数")),
            TextButton(
                onPressed: () {
                  //{arguments}为可选命名参数，需要指定参数名称
                  //[]为可选位置参数，不需要指定参数名称，只需要按顺序填入即可
                  Navigator.pushNamed(context, "router_with_param_by_named",
                      arguments: "命名路由参数");
                },
                child: Text("使用命名路由，argument传递参数")),
            TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, "router_with_param", arguments: "命名路由参数传给构造方法");
                },
                child: Text("命名路由传递参数，并传给构造方法")),
            TextButton(
                onPressed: () async {
                  var result =
                      await Navigator.pushNamed(context, "router_with_result");
                  print(result);
                },
                child: Text("获取路由页面返回结果")),
          ],
        ),
      ),
    );
  }
}

class NewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("普通路由")),
        body: Center(child: Text("普通路由页面")));
  }
}

/// 命名路由
class RouterByNamed extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("命名路由")),
        body: Center(child: Text("命名路由页面")));
  }
}

/// 构造方法传递参数
class RouterWithParam extends StatelessWidget {
  RouterWithParam(this.param);

  final String param;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("路由传递参数")),
        body: Center(child: Text(param)));
  }
}

/// 命名路由，argument传递参数
class RouterWithParamByNamed extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var param = ModalRoute.of(context).settings.arguments;
    return Scaffold(
        appBar: AppBar(title: Text("命名路由传递参数")),
        body: Center(child: Text(param)));
  }
}

/// 路由页面返回结果
class RouterWithResult extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("路由页面返回结果")),
        body: Center(
            child: Column(children: [
          Text("路由页面返回结果"),
          ElevatedButton(
            //[result]为可选位置参数，不需要指定参数名称，只需要按顺序填入即可
            onPressed: () => Navigator.pop(context, "路由返回结果"),
            child: Text("返回"),
          )
        ])));
  }
}
