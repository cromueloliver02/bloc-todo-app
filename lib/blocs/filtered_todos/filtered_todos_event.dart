part of 'filtered_todos_bloc.dart';

abstract class FilteredTodosEvent extends Equatable {
  const FilteredTodosEvent();

  @override
  List<Object> get props => [];
}

class SetFilteredTodosEvent extends FilteredTodosEvent {
  final Filter filter;
  final String searchTerm;
  final List<Todo> todos;

  const SetFilteredTodosEvent({
    required this.filter,
    required this.searchTerm,
    required this.todos,
  });

  @override
  List<Object> get props => [filter, searchTerm, todos];

  @override
  String toString() =>
      'SetFilteredTodosEvent(filter: $filter, searchTerm: $searchTerm, todos: $todos)';
}
