import 'dart:async';

// ignore: depend_on_referenced_packages
import 'package:equatable/equatable.dart';
import '../../blocs/blocs.dart';
import '../../models/todo.dart';

part 'filtered_todos_event.dart';
part 'filtered_todos_state.dart';

class FilteredTodosBloc extends Bloc<FilteredTodosEvent, FilteredTodosState> {
  late final StreamSubscription todoFilterSubscription;
  late final StreamSubscription todoSearchSubscription;
  late final StreamSubscription todoListSubscription;
  final TodoFilterBloc todoFilterBloc;
  final TodoSearchBloc todoSearchBloc;
  final TodoListBloc todoListBloc;
  final List<Todo> initialFilteredTodos;

  FilteredTodosBloc({
    required this.todoFilterBloc,
    required this.todoSearchBloc,
    required this.todoListBloc,
    required this.initialFilteredTodos,
  }) : super(FilteredTodosState(filteredTodos: initialFilteredTodos)) {
    final setFilteredTodosEvent = SetFilteredTodosEvent(
      filter: todoFilterBloc.state.filter,
      searchTerm: todoSearchBloc.state.searchTerm,
      todos: todoListBloc.state.todos,
    );

    todoFilterSubscription =
        todoFilterBloc.stream.listen((state) => add(setFilteredTodosEvent));
    todoSearchSubscription =
        todoSearchBloc.stream.listen((state) => add(setFilteredTodosEvent));
    todoListSubscription =
        todoListBloc.stream.listen((state) => add(setFilteredTodosEvent));

    on<SetFilteredTodosEvent>(_setFilteredTodos);
  }

  @override
  Future<void> close() {
    todoFilterSubscription.cancel();
    todoSearchSubscription.cancel();
    todoListSubscription.cancel();
    return super.close();
  }

  void _setFilteredTodos(
    SetFilteredTodosEvent event,
    Emitter<FilteredTodosState> emit,
  ) {
    final filter = todoFilterBloc.state.filter;
    final searchTerm = todoSearchBloc.state.searchTerm;
    final todos = todoListBloc.state.todos;
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
