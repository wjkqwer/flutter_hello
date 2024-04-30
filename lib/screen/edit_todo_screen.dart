import 'package:flutter/material.dart';
import 'package:flutter_todos/model/todos_entity.dart';
import 'package:flutter_todos/repository/local_repository.dart';
import 'package:uuid/uuid.dart';

class EditTodoScreen extends StatefulWidget {
  final TodosEntity? todo;

  const EditTodoScreen({super.key, this.todo});

  @override
  State<EditTodoScreen> createState() => _EditTodoScreenState();
}

class _EditTodoScreenState extends State<EditTodoScreen> {
  String? _title;
  String? _description;

  @override
  void initState() {
    super.initState();
    //编辑状态的时候，获取初始值
    final todo = widget.todo;
    _title = todo?.title;
    _description = todo?.description;
  }

  @override
  Widget build(BuildContext context) {
    //接收传递进来的todo数据
    final todo = widget.todo;
    return Scaffold(
      appBar: AppBar(
        title: todo == null ? Text("Add Task") : Text("Edit Task"),
        backgroundColor: Colors.amberAccent,
      ),
      floatingActionButton: FloatingActionButton(
        //_title不等于null的时候，才能点击
        onPressed: _title != null
            ? () {
                if (todo == null) {
                  _addTask();
                } else {
                  _editTask();
                }
              }
            : null,
        child: const Icon(Icons.done),
      ),
      body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              _TitleFiled(
                initValue: _title,
                hintText: "please fill it.",
                onChanged: (value) {
                  setState(() {
                    _title = value;
                  });
                },
              ),
              _DescFiled(
                initValue: _description,
                hintText: "please fill it.",
                onChanged: (value) {
                  setState(() {
                    _description = value;
                  });
                },
              )
            ],
          )),
    );
  }

  void _addTask() {
    final todoApi = LocalRepository();
    final newTodo = TodosEntity(
        id: Uuid().v4(), title: _title!, description: _description!);
    todoApi.add(newTodo);
    Navigator.pop(context, newTodo);
  }

  void _editTask() {
    final todo = widget.todo;
    if (todo == null) return;
    final todoApi = LocalRepository();
    final newTodo =
        todo.copyWith(title: _title, description: _description ?? "");
    todoApi.update(newTodo);
    Navigator.pop(context, newTodo);
  }
}

class _TitleFiled extends StatelessWidget {
  final String? initValue;
  final String? hintText;
  final Function(String?)? onChanged;

  const _TitleFiled({this.initValue, this.hintText, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        initialValue: initValue,
        onChanged: onChanged,
        maxLength: 50,
        maxLines: 1,
        decoration: InputDecoration(label: Text("Title"), hintText: hintText));
  }
}

class _DescFiled extends StatelessWidget {
  final String? initValue;
  final String? hintText;
  final Function(String?)? onChanged;

  const _DescFiled({this.initValue, this.hintText, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        initialValue: initValue,
        onChanged: onChanged,
        maxLength: 300,
        maxLines: 7,
        decoration:
            InputDecoration(label: Text("Description"), hintText: hintText));
  }
}
