class Todo {
  final int id;
  final String todo;

  Todo({required this.id, required this.todo});

  factory Todo.fromJson(Map map) {
    return Todo(id: map['id'], todo: map['todo']);
  }
}
