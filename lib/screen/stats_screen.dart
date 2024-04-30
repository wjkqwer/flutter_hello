import 'package:flutter/material.dart';

import '../model/todos_entity.dart';
import '../repository/local_repository.dart';

class StatsScreen extends StatefulWidget {
  const StatsScreen({super.key});

  @override
  State<StatsScreen> createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  final _todosApi = LocalRepository();
  TodosChangedListener? _todosChangedListener;
  List<TodosEntity> _todos = [];

  @override
  void initState() {
    _init();
    super.initState();
  }

  void _init() async {
    final todos = await _todosApi.getTodos();
    setState(() {
      _todos = todos;
    });
    //监听
    _todosChangedListener = (todos) {
      setState(() {
        _todos = todos;
      });
    };
    _todosApi.addTodosChangedListener(_todosChangedListener!);
  }

  @override
  Widget build(BuildContext context) {
    final completedCount =
        _todos.where((element) => element.isCompleted).length;
    final activeCount = _todos.length - completedCount;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Count"),
        backgroundColor: Colors.greenAccent,
      ),
      body: Column(
        children: [
          _StatItem(
              icon: const Icon(Icons.done),
              title: "Completed Task",
              value: completedCount),
          _StatItem(
              icon: const Icon(Icons.circle_outlined),
              title: "Active Task",
              value: activeCount),
        ],
      ),
    );
  }

  @override
  void dispose() {
    if (_todosChangedListener != null) {
      _todosApi.removeTodosChangedListener(_todosChangedListener!);
      _todosChangedListener = null;
    }
    super.dispose();
  }
}

class _StatItem extends StatelessWidget {
  final Icon icon;
  final String title;
  final int value;

  const _StatItem({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Row(
        children: [
          const SizedBox(width: 15),
          icon,
          const SizedBox(width: 10),
          Text(title),
          const Spacer(),
          Text(
            value.toString(),
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
          ),
          const SizedBox(width: 15)
        ], //Spacer()占满中间空白，作用是把最后一个Text挤到右边
      ),
    );
  }
}
