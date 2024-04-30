class TodosEntity {
  final String id;
  final String title;
  final String description;
  final bool isCompleted;

  const TodosEntity({
    required this.id,
    required this.title,
    required this.description,
    this.isCompleted = false,
  });

  TodosEntity copyWith(
      {String? id, String? title, String? description, bool? isCompleted}) {
    return TodosEntity(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        isCompleted: isCompleted ?? this.isCompleted);
  }
}
