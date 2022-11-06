// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';
import '../../models/todo.dart';

part 'todo_list_state.dart';

const uuid = Uuid();

class TodoListCubit extends Cubit<TodoListState> {
  TodoListCubit() : super(TodoListState.initial());

  void addTodo(Todo todo) {
    final todos = [...state.todos, todo];

    emit(state.copyWith(todos: todos));
  }

  void editTodo(Todo todo) {
    final todos = state.todos.map((d) => d.id == todo.id ? todo : d).toList();

    emit(state.copyWith(todos: todos));
  }

  void toggleComplete(String id) {
    final todos = state.todos
        .map((d) => d.id == id ? d.copyWith(completed: !d.completed) : d)
        .toList();

    emit(state.copyWith(todos: todos));
  }

  void removeTodo(String id) {
    final todos = state.todos.where((d) => d.id != id).toList();

    emit(state.copyWith(todos: todos));
  }
}
