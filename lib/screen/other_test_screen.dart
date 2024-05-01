import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_todos/model/address.dart';
import 'package:flutter_todos/model/user.dart';

class OtherTestScreen extends StatefulWidget {
  const OtherTestScreen({super.key});

  static const routeName = '/OtherTestScreen';

  @override
  State<OtherTestScreen> createState() => _OtherTestScreenState();
}

class _OtherTestScreenState extends State<OtherTestScreen> {
  String _text_content = "Null";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Other Test"),
        backgroundColor: Colors.greenAccent,
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          Text(_text_content),
          const SizedBox(height: 10),
          ElevatedButton(
              onPressed: () {
                setState(() {
                  _text_content = "Null";
                });
              },
              child: Text("clear")),
          const SizedBox(height: 10),
          ElevatedButton(
              onPressed: () {
                _delayedTest();
              },
              child: Text("delayed test")),
          const SizedBox(height: 10),
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
          const SizedBox(height: 10),
          ElevatedButton(
              onPressed: () {
                _testJson();
              },
              child: Text("json to map")),
        ],
      ),
    );
  }

  //延迟执行
  void _delayedTest() {
    Future.delayed(Duration(seconds: 5), () {
      setState(() {
        _text_content = "this is delayed";
      });
    });
  }

  //等待执行，async表示是个异步函数，添加await表示后面的逻辑需要等待我执行完成，才能开始
  Future<String> _asyncTest() async {
    _text_content = "";
    await Future.delayed(const Duration(seconds: 5), () {
      setState(() {
        _text_content = "${_text_content}\nthis is await delayed 1";
      });
    });
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        _text_content = "${_text_content}\nthis is await delayed 2";
      });
    });
    final value = await Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _text_content = "${_text_content}\nthis is await delayed 3";
      });
      return "return 3";
    });
    setState(() {
      _text_content = "${_text_content}\nthis is await delayed 4 $value";
    });
    return "0";
  }

  // final _json = """{
  //   "name": "taylor",
  //   "email": "aaa@qq.com",
  //   "address":"{"country":"China","city":"FZ"}"
  // }""";

  final _json =
      '{"name": "taylor", "email": "aaa@qq.com", "address": {"country": "China", "city": "FZ"}}';

  void _testJson() {
    //json转map
    final Map<String, dynamic> map = jsonDecode(_json);
    print(map);
    //map转json
    print(jsonEncode(map));
    //map转对象(不推荐)
    // final user = User(map["name"], map["email"]);
    // print("user:" + user.name + "--" + user.email);
    /**
     * map转对象(使用json_serializable，执行下面一句，添加依赖)
     * flutter pub add json_annotation dev:build_runner dev:json_serializable
     * 在User类中添加 part 'user.g.dart';  @JsonSerializable()
     * 如果user类中还有子对象，使用@JsonSerializable(explicitToJson: true)，否则子对象字段会有问题
     * 执行：flutter pub run build_runner build --delete-conflicting-outputs 生成user.g.dart
     */
    final user1 = User.fromJson(map);
    print("user1:" + user1.name + "--" + user1.email);

    final userBean = User("taylor", "aaa@qq.com", Address("China", "Fuzhou"));
    print(userBean.toJson());
  }
}
