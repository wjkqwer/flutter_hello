import 'package:flutter/material.dart';
import 'package:flutter_todos/screen/demo_scroll_screen.dart';
import 'package:flutter_todos/screen/route_screen.dart';

import 'anonymous_route_screen.dart';

class DemoAllScreen extends StatefulWidget {
  const DemoAllScreen({super.key});

  @override
  State<DemoAllScreen> createState() => _StatsScreenState();
}

class _StatsScreenState extends State<DemoAllScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("All Demo"),
        backgroundColor: Colors.greenAccent,
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return DemoScrollScreen();
                  }));
                },
                child: Text("SingleChildScrollView Page")),
            const SizedBox(height: 15),
            ElevatedButton(
                onPressed: () async {
                  //要使用异步async和await来处理接收消息，value是返回值
                  final value = await Navigator.push(context,
                      MaterialPageRoute(builder: (context) {
                    //MaterialPageRoute会根据不同平台，使用不同的跳转动画
                    return RouteScreen("Hello Route");
                  })) as String?;
                  if (value != null) {
                    print("received the Route page msg: $value");
                  }
                },
                child: Text("Route Page")),
            const SizedBox(height: 15),
            ElevatedButton(
                onPressed: () async {
                  final value = await Navigator.pushNamed(
                      context, AnonymousRouteScreen.routeName,
                      arguments: "Hello Anonymous Route");
                  if (value != null) {
                    print("received Anonymous Route page msg: $value");
                  }
                },
                child: Text("Anonymous Route Page")),
            const SizedBox(height: 15),
            ElevatedButton(
                onPressed: () {
                  _delayedTest();
                },
                child: Text("delayed test")),
            const SizedBox(height: 15),
            ElevatedButton(
                onPressed: () {
                  //捕获异常
                  // _asyncTest().catchError((e) {
                  //   print("Error $e");
                  //   return e.toString();
                  // });
                  _asyncTest();
                },
                child: Text("async test")),
          ],
        ),
      ),
    );
  }

  //延迟执行
  void _delayedTest() {
    Future.delayed(Duration(seconds: 5), () {
      print("this is delayed");
    });
  }

  //等待执行，async表示是个异步函数，添加await表示后面的逻辑需要等待我执行完成，才能开始
  Future<String> _asyncTest() async {
    await Future.delayed(const Duration(seconds: 5), () {
      print("this is delayed 1");
    });
    Future.delayed(const Duration(seconds: 3), () {
      print("this is delayed 2");
    });
    final value = await Future.delayed(const Duration(seconds: 2), () {
      return "delayed 4";
    });
    print("this is delayed 3 $value");
    return "0";
  }
}
