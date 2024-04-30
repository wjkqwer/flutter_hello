import 'package:flutter_todos/model/todos_entity.dart';
import 'package:flutter_todos/repository/todos_api.dart';

typedef TodosChangedListener = Function(List<TodosEntity>);

class LocalRepository extends TodosApi {
  //单例写法----start---
  static final _instance = LocalRepository._();

  LocalRepository._();

  factory LocalRepository() => _instance;
  //----end---

  final List<TodosEntity> _todos = [];
  final List<TodosChangedListener> _todosChangedListeners = [];

  @override
  Future<bool> add(TodosEntity todo) async {
    _todos.add(todo);
    for (final listener in _todosChangedListeners) {
      listener.call(_todos);
    }
    return true;
  }

  @override
  Future<bool> update(TodosEntity todo) async {
    final index = _todos.indexWhere((element) => element.id == todo.id);
    if (index == -1) return false;
    _todos.removeWhere((element) => element.id == todo.id);
    if (index > _todos.length - 1) {
      _todos.add(todo);
    } else {
      _todos.insert(index, todo);
    }
    for (final listener in _todosChangedListeners) {
      listener.call(_todos);
    }
    return true;
  }

  @override
  Future<bool> clearCompleted() async {
    _todos.removeWhere((element) => element.isCompleted);
    for (final listener in _todosChangedListeners) {
      listener.call(_todos);
    }
    return true;
  }

  @override
  Future<bool> delete(String id) async {
    _todos.removeWhere((element) => element.id == id);
    for (final listener in _todosChangedListeners) {
      listener.call(_todos);
    }
    return true;
  }

  @override
  Future<List<TodosEntity>> getTodos() async {
    return _todos;
  }

  @override
  Future<bool> markAllAsCompleted() async {
    final newTodos = _todos.map((e) => e.copyWith(isCompleted: true)).toList();
    //因为_todos是final，所以先clear再addAll
    _todos.clear();
    _todos.addAll(newTodos);
    for (final listener in _todosChangedListeners) {
      listener.call(_todos);
    }
    return true;
  }

  void addTodosChangedListener(TodosChangedListener listener) {
    _todosChangedListeners.add(listener);
  }

  void removeTodosChangedListener(TodosChangedListener listener) {
    _todosChangedListeners.remove(listener);
  }
}
