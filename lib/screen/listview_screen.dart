import 'package:flutter/material.dart';

class ListviewScreen extends StatefulWidget {
  const ListviewScreen({super.key});

  static const routeName = '/ListviewScreen';

  @override
  State<ListviewScreen> createState() => _ListviewScreenState();
}

class _ListviewScreenState extends State<ListviewScreen> {
  Future<List<String>> _getWords() async {
    await Future.delayed(const Duration(seconds: 2)); //延迟两秒加载出来，模拟加载时间
    final List<String> list = [];
    for (int i = 1; i <= 4; i++) {
      list.add("value");
      list.add("upset");
      list.add("promotion");
      list.add("due");
      list.add("apparently");
      list.add("contacts");
    }
    return list;
  }

  final List<String> _englishWords = [];
  final ScrollController _scrollController = ScrollController();
  bool _isLoadingMore = false;
  bool _noMore = false;

  @override
  void initState() {
    super.initState();
    _init();
    _scrollController.addListener(() {
      //判断加载到底部
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _loadMore();
      }
    });
  }

  void _init() async {
    final words = await _getWords();
    setState(() {
      _englishWords.addAll(words);
    });
  }

  void _loadMore() async {
    if (_isLoadingMore) return;
    if (_noMore) return;
    setState(() {
      _isLoadingMore = true;
    });
    final words = await _getWords();
    setState(() {
      _englishWords.addAll(words);
      if (_englishWords.length >= 100) {
        _noMore = true;
      }
    });
    setState(() {
      _isLoadingMore = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Listview"),
        backgroundColor: Colors.orange,
      ),
      // body: ListView(
      //   children: List.generate(
      //       10,
      //           (index) => Text(
      //         "${index + 1}",
      //         style: TextStyle(fontSize: 30),
      //       )),
      // ),
      // body: ListView.builder(
      body: ListView.separated(
          itemCount: _isLoadingMore || _noMore
              ? _englishWords.length + 1
              : _englishWords.length,
          controller: _scrollController,
          shrinkWrap: true,
          //指定宽度为子组件宽度
          separatorBuilder: (context, index) {
            //可添加分割线颜色color和宽度thickness，ListView.separated才有
            return const Divider(color: Colors.orange, thickness: 5);
          },
          itemBuilder: (context, index) {
            if (index <= _englishWords.length - 1) {
              final String word = _englishWords[index];
              return Container(
                padding: EdgeInsets.all(15),
                child: Text(word),
              );
            } else if (_isLoadingMore) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (_noMore) {
              return const Center(
                child: Text("No More"),
              );
            } else {
              return const SizedBox.shrink(); //看不见的组件
            }
          }),
    );
  }
}
