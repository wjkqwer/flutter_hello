import 'package:flutter_todos/model/todos_entity.dart';

abstract class TodosApi {
  Future<bool> add(TodosEntity todo);

  Future<bool> update(TodosEntity todo);

  Future<bool> delete(String id);

  Future<bool> markAllAsCompleted();

  Future<bool> clearCompleted();

  Future<List<TodosEntity>> getTodos();
}
