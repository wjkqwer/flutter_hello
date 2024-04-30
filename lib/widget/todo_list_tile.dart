import 'package:flutter/material.dart';
import 'package:flutter_todos/model/todos_entity.dart';

class TodoListTile extends StatelessWidget {
  final Key itemKey;
  final TodosEntity todo;
  final VoidCallback onTap;
  final Function(bool) onChanged;
  final VoidCallback onDismissed;

  const TodoListTile(
      {super.key,
      required this.itemKey,
      required this.todo,
      required this.onTap,
      required this.onChanged,
      required this.onDismissed});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
        //Dismissible滑动组件
        key: itemKey,
        onDismissed: (direction) {
          onDismissed.call();
        },
        background: Container(
          alignment: Alignment.centerRight,
          child: Icon(Icons.delete_forever, color: Colors.white),
          color: Colors.deepOrangeAccent,
        ),
        child: ListTile(
          onTap: onTap,
          leading: Checkbox(
            value: todo.isCompleted,
            onChanged: (value) {
              if (value != null) {
                onChanged.call(value);
              }
            },
          ),
          title: Text(todo.title,
              style: TextStyle(
                  decoration:
                      todo.isCompleted ? TextDecoration.lineThrough : null)),
          subtitle: Text(todo.description),
          trailing: Icon(Icons.arrow_forward_ios),
        ));
  }
}
