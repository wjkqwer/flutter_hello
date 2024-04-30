import 'package:flutter/material.dart';

class DemoScrollScreen extends StatefulWidget {
  const DemoScrollScreen({super.key});

  @override
  State<DemoScrollScreen> createState() => _DemoScrollScreenState();
}

class _DemoScrollScreenState extends State<DemoScrollScreen> {
  final _urls = [
    "https://picx.zhimg.com/80/v2-7df1c9ce05fea89f5afd784dee89e5b4_720w.webp?source=1def8aca",
    "https://img1.baidu.com/it/u=903829763,2925435307&fm=253&fmt=auto&app=138&f=JPEG?w=889&h=500",
    "https://img0.baidu.com/it/u=1751808597,1886318187&fm=253&fmt=auto&app=138&f=JPEG?w=750&h=500",
    "https://img0.baidu.com/it/u=3476293439,478517026&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=889",
    "https://picx.zhimg.com/v2-dce01d1ad9c3c280f6dc3d21747cdb22_r.jpg?source=1def8aca"
  ];

  final _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SingleChildScrollView"),
        backgroundColor: Colors.orange,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          _controller.animateTo(500,
              duration: Duration(milliseconds: 500), curve: Curves.bounceIn);
        },
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(), //滑动到终点时的回弹效果
        controller: _controller,
        child: Column(
            children: List.generate(
                _urls.length,
                (index) => Card(
                    margin: EdgeInsets.all(15),
                    clipBehavior: Clip.antiAlias, //裁剪圆角
                    child: Image.network(_urls[index])))),
      ),
    );
  }
}
