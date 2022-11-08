part of 'todo_list_bloc.dart';

abstract class TodoListEvent extends Equatable {
  const TodoListEvent();

  @override
  List<Object> get props => [];
}

class AddTodoEvent extends TodoListEvent {
  final Todo todo;

  const AddTodoEvent({
    required this.todo,
  });

  @override
  List<Object> get props => [todo];

  @override
  String toString() => 'AddTodo(todo: $todo)';
}

class EditTodoEvent extends TodoListEvent {
  final String id;
  final String desc;

  const EditTodoEvent({
    required this.id,
    required this.desc,
  });

  @override
  List<Object> get props => [id, desc];

  @override
  String toString() => 'EditTodoEvent(id: $id, desc: $desc)';
}

class ToggleCompleteEvent extends TodoListEvent {
  final String id;

  const ToggleCompleteEvent({
    required this.id,
  });

  @override
  List<Object> get props => [id];

  @override
  String toString() => 'ToggleCompleteEvent(id: $id)';
}

class RemoveTodoEvent extends TodoListEvent {
  final String id;

  const RemoveTodoEvent({
    required this.id,
  });

  @override
  List<Object> get props => [id];

  @override
  String toString() => 'RemoveTodoEvent(id: $id)';
}
