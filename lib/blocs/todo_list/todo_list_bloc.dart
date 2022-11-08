// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../models/todo.dart';

part 'todo_list_event.dart';
part 'todo_list_state.dart';

class TodoListBloc extends Bloc<TodoListEvent, TodoListState> {
  TodoListBloc() : super(TodoListState.initial()) {
    on<AddTodoEvent>(_addTodo);
    on<EditTodoEvent>(_editTodo);
    on<ToggleCompleteEvent>(_toggleComplete);
    on<RemoveTodoEvent>(_removeTodo);
  }

  void _addTodo(AddTodoEvent event, Emitter<TodoListState> emit) {
    final todos = [...state.todos, event.todo];

    emit(state.copyWith(todos: todos));
  }

  void _editTodo(EditTodoEvent event, Emitter<TodoListState> emit) {
    final todos = state.todos
        .map((d) => d.id == event.id ? d.copyWith(desc: event.desc) : d)
        .toList();

    emit(state.copyWith(todos: todos));
  }

  void _toggleComplete(ToggleCompleteEvent event, Emitter<TodoListState> emit) {
    final todos = state.todos
        .map((d) => d.id == event.id ? d.copyWith(completed: !d.completed) : d)
        .toList();

    emit(state.copyWith(todos: todos));
  }

  void _removeTodo(RemoveTodoEvent event, Emitter<TodoListState> emit) {
    final todos = state.todos.where((d) => d.id != event.id).toList();

    emit(state.copyWith(todos: todos));
  }
}
