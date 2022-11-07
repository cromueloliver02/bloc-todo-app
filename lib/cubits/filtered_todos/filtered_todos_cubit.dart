// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../models/todo.dart';

part 'filtered_todos_state.dart';

class FilteredTodosCubit extends Cubit<FilteredTodosState> {
  final List<Todo> initialFilteredTodos;

  FilteredTodosCubit({
    required this.initialFilteredTodos,
  }) : super(FilteredTodosState(filteredTodos: initialFilteredTodos));

  void setFilteredTodos(Filter filter, String searchTerm, List<Todo> todos) {
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
