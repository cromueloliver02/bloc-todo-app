part of 'todo_list_bloc.dart';

class TodoListState extends Equatable {
  final List<Todo> todos;

  const TodoListState({required this.todos});

  factory TodoListState.initial() {
    return TodoListState(
      todos: [
        Todo(id: uuid.v4(), desc: 'Clean the room'),
        Todo(id: uuid.v4(), desc: 'Wash the dish'),
        Todo(id: uuid.v4(), desc: 'Do homework'),
      ],
    );
  }

  @override
  List<Object> get props => [todos];

  @override
  String toString() => 'TodoListState(todos: we we$todos)';

  TodoListState copyWith({
    List<Todo>? todos,
  }) {
    return TodoListState(
      todos: todos ?? this.todos,
    );
  }
}
