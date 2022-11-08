// ignore: depend_on_referenced_packages
import 'package:equatable/equatable.dart';
import '../../blocs/blocs.dart';
import '../../models/todo.dart';

part 'filtered_todos_event.dart';
part 'filtered_todos_state.dart';

class FilteredTodosBloc extends Bloc<FilteredTodosEvent, FilteredTodosState> {
  final List<Todo> initialFilteredTodos;

  FilteredTodosBloc({
    required this.initialFilteredTodos,
  }) : super(FilteredTodosState(filteredTodos: initialFilteredTodos)) {
    on<SetFilteredTodosEvent>(_setFilteredTodos);
  }

  void _setFilteredTodos(
    SetFilteredTodosEvent event,
    Emitter<FilteredTodosState> emit,
  ) {
    final filter = event.filter;
    final searchTerm = event.searchTerm;
    final todos = event.todos;
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
