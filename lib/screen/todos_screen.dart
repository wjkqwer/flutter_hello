import 'package:flutter/material.dart';
import 'package:flutter_todos/model/todos_filter_option.dart';
import 'package:flutter_todos/model/todos_option.dart';
import 'package:flutter_todos/repository/local_repository.dart';
import 'package:flutter_todos/screen/edit_todo_screen.dart';
import 'package:flutter_todos/widget/todo_list_tile.dart';
import 'package:flutter_todos/widget/todos_filter_button.dart';
import 'package:flutter_todos/widget/todos_option_button.dart';

import '../model/todos_entity.dart';

class TodosScreen extends StatefulWidget {
  const TodosScreen({super.key});

  @override
  State<TodosScreen> createState() => _TodosScreenState();
}

class _TodosScreenState extends State<TodosScreen> {
  final List<TodosEntity> _todos = [];
  final _todosApi = LocalRepository();
  TodosChangedListener? _todosChangedListener;
  TodosFilterOption _filterOption = TodosFilterOption.all;

  @override
  void initState() {
    super.initState();
    _init();
  }

  void _init() async {
    final todos = await _todosApi.getTodos();
    setState(() {
      _todos.addAll(todos);
    });
    //监听
    _todosChangedListener = (todos) {
      setState(() {
        _todos.clear();
        _todos.addAll(todos);
      });
    };
    _todosApi.addTodosChangedListener(_todosChangedListener!);
  }

  List<TodosEntity> _filterTodos(List<TodosEntity> todos) {
    switch (_filterOption) {
      case TodosFilterOption.all:
        return todos;
      case TodosFilterOption.active:
        return todos.where((element) => !element.isCompleted).toList();
      case TodosFilterOption.completed:
        return todos.where((element) => element.isCompleted).toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    final todos = _filterTodos(_todos);
    return Scaffold(
      appBar: AppBar(
        title: Text("Task List"),
        backgroundColor: Colors.amberAccent,
        actions: [
          TodosFilterButton(
            selectFilterOption: _filterOption,
            onSelected: (value) {
              setState(() {
                _filterOption = value;
              });
            },
          ),
          TodosOptionButton(
            onSelected: (option) {
              setState(() {
                _onOptionSelected(option);
              });
            },
          )
        ],
      ),
      body: ListView.builder(
          itemCount: todos.length,
          itemBuilder: (context, index) {
            final itemTodo = todos[index];
            return TodoListTile(
                itemKey: Key(itemTodo.id),
                todo: itemTodo,
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return EditTodoScreen(todo: itemTodo);
                  }));
                },
                onDismissed: () {
                  _todosApi.delete(itemTodo.id);
                },
                onChanged: (value) {
                  _updateTodoCompleteStatus(itemTodo, value);
                });
          }),
    );
  }

  void _onOptionSelected(TodosOption option) {
    if (option == TodosOption.markAll) {
      _todosApi.markAllAsCompleted();
    } else if (option == TodosOption.clearCompleted) {
      _todosApi.clearCompleted();
    }
  }

  void _updateTodoCompleteStatus(TodosEntity todo, bool isCompleted) {
    final newTodo = todo.copyWith(isCompleted: isCompleted);
    _todosApi.update(newTodo);
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
