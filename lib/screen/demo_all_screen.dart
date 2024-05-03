import 'package:flutter/material.dart';
import 'package:flutter_todos/screen/demo_scroll_screen.dart';
import 'package:flutter_todos/screen/route_screen.dart';

import 'anonymous_route_screen.dart';
import 'listview_screen.dart';
import 'other_test_screen.dart';

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
                  Navigator.pushNamed(context, OtherTestScreen.routeName);
                },
                child: Text("OtherTestScreen Page")),
            const SizedBox(height: 15),
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
                  Navigator.pushNamed(context, ListviewScreen.routeName);
                },
                child: Text("Listview")),
          ],
        ),
      ),
    );
  }
}
