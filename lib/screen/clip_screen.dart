import 'package:flutter/material.dart';
import 'package:flutter_todos/widget/my_clipper.dart';
import 'package:flutter_todos/widget/my_clipper2.dart';

class ClipScreen extends StatefulWidget {
  const ClipScreen({super.key});

  static const routeName = '/ClipScreen';

  @override
  State<ClipScreen> createState() => _StatsScreenState();
}

class _StatsScreenState extends State<ClipScreen> {
  final photo = Image.asset(
    "images/example_image.jpg",
    width: 200,
    height: 100,
    fit: BoxFit.cover,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Clip"),
        backgroundColor: Colors.greenAccent,
      ),
      body: Center(
        child: Column(
          children: [
            photo,
            const SizedBox(height: 20),
            Align(
                alignment: Alignment.topCenter,
                heightFactor: 0.5, //heightFactor表示高度是子组件的0.5倍
                child: photo),
            const SizedBox(height: 70), //这里用70是因为高度溢出，不太明白，之后查资料
            ClipRRect(
                //带圆角的裁剪
                borderRadius: BorderRadius.all(Radius.circular(15)),
                child: photo),
            const SizedBox(height: 20),
            ClipOval(
              child: photo,
            ),
            const SizedBox(height: 20),
            ClipPath(child: photo, clipper: MyClipper()), //自定义路径
            const SizedBox(height: 20),
            ClipRect(
              child: Align(
                  alignment: Alignment.topCenter,
                  heightFactor: 0.5, //heightFactor表示高度是子组件的0.5倍
                  child: photo),
            ), //自定义路径裁剪
            const SizedBox(height: 20),
            ClipRect(
              child: photo,
              clipper: MyClipper2(),
            ), //自定义路径裁剪
          ],
        ),
      ),
    );
  }
}
