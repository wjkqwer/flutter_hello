import 'package:flutter/material.dart';
import 'package:flutter_todos/model/todos_filter_option.dart';

class TodosFilterButton extends StatelessWidget {
  final TodosFilterOption selectFilterOption;
  final Function(TodosFilterOption) onSelected;

  const TodosFilterButton(
      {super.key, required this.selectFilterOption, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        initialValue: selectFilterOption,
        onSelected: onSelected,
        itemBuilder: (context) {
          return [
            PopupMenuItem(
                value: TodosFilterOption.all,
                child: Text(TodosFilterOption.all.name)),
            PopupMenuItem(
                value: TodosFilterOption.active,
                child: Text(TodosFilterOption.active.name)),
            PopupMenuItem(
                value: TodosFilterOption.completed,
                child: Text(TodosFilterOption.completed.name))
          ];
        },
        child: const Icon(Icons.filter_list_rounded));
  }
}
