import 'package:flutter/material.dart';

class RouteScreen extends StatelessWidget {
  final String param;

  const RouteScreen(this.param);

  @override
  Widget build(BuildContext context) {
    print("received msg: $param"); //接收第一页传递的参数
    return Scaffold(
      appBar: AppBar(
        title: const Text("Test Route Page"),
        backgroundColor: Colors.greenAccent,
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, "Hi,I'm good."); //往第一页传参
                },
                child: Text("back")),
          ],
        ),
      ),
    );
  }
}
