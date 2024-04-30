import 'package:flutter/material.dart';

import '../model/todos_option.dart';

class TodosOptionButton extends StatelessWidget {
  final Function(TodosOption) onSelected;

  const TodosOptionButton({super.key, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        onSelected: onSelected,
        itemBuilder: (context) {
          return const [
            PopupMenuItem(
                value: TodosOption.markAll,
                child: Text("Mark all as completed")),
            PopupMenuItem(
                value: TodosOption.clearCompleted,
                child: Text("Clear completed"))
          ];
        });
  }
}
