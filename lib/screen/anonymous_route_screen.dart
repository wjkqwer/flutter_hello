import 'package:flutter/material.dart';

class AnonymousRouteScreen extends StatelessWidget {
  const AnonymousRouteScreen();

  static const routeName = '/AnonymousRouteScreen';

  @override
  Widget build(BuildContext context) {
    final param = ModalRoute.of(context)?.settings.arguments;
    if (param != null) {
      print("Anonymous received msg: $param"); //接收第一页传递的参数
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text("Test Anonymous Route Page"),
        backgroundColor: Colors.greenAccent,
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            Text(param == null ? "Null" : param.toString()),
            SizedBox(height: 15),
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, "Hi,I'm Anonymous."); //往第一页传参
                },
                child: Text("back")),
          ],
        ),
      ),
    );
  }
}
