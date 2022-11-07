import 'dart:async';

// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../todo_filter/todo_filter_cubit.dart';
import '../todo_search/todo_search_cubit.dart';
import '../todo_list/todo_list_cubit.dart';
import '../../models/todo.dart';

part 'filtered_todos_state.dart';

class FilteredTodosCubit extends Cubit<FilteredTodosState> {
  late final StreamSubscription _todoFilterSubscription;
  late final StreamSubscription _todoSearchSubscription;
  late final StreamSubscription _todoListSubscription;
  final TodoFilterCubit todoFilterCubit;
  final TodoSearchCubit todoSearchCubit;
  final TodoListCubit todoListCubit;
  final List<Todo> initialFilteredTodos;

  FilteredTodosCubit({
    required this.todoFilterCubit,
    required this.todoSearchCubit,
    required this.todoListCubit,
    required this.initialFilteredTodos,
  }) : super(FilteredTodosState(filteredTodos: initialFilteredTodos)) {
    // when selected filter tab changes
    _todoFilterSubscription =
        todoFilterCubit.stream.listen((state) => _setFilteredTodos());

    // when search term changes
    _todoSearchSubscription =
        todoSearchCubit.stream.listen((state) => _setFilteredTodos());

    // when todo list changes like editing and deleting todos
    _todoListSubscription =
        todoListCubit.stream.listen((state) => _setFilteredTodos());
  }

  @override
  Future<void> close() {
    _todoFilterSubscription.cancel();
    _todoSearchSubscription.cancel();
    _todoListSubscription.cancel();
    return super.close();
  }

  void _setFilteredTodos() {
    final filter = todoFilterCubit.state.filter;
    final searchTerm = todoSearchCubit.state.searchTerm;
    final todos = todoListCubit.state.todos;
    List<Todo> filteredTodos = [];

    switch (filter) {
      case Filter.active:
        filteredTodos = todos.where((d) => !d.completed).toList();
        break;
      case Filter.completed:
        filteredTodos = todos.where((d) => d.completed).toList();
        break;
      case Filter.all:
      default:
        filteredTodos = todos;
    }

    if (searchTerm.trim().isNotEmpty) {
      filteredTodos = todos
          .where((d) => d.desc.toLowerCase().contains(searchTerm.toLowerCase()))
          .toList();
    }

    emit(state.copyWith(filteredTodos: filteredTodos));
  }
}
