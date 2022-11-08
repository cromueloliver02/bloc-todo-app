// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:equatable/equatable.dart';

part 'todo_search_event.dart';
part 'todo_search_state.dart';

class TodoSearchBloc extends Bloc<TodoSearchEvent, TodoSearchState> {
  TodoSearchBloc() : super(TodoSearchState.initial()) {
    on<SetSearchTermEvent>(
      _setSearchTerm,
      transformer: debounce(const Duration(milliseconds: 2000)),
    );
  }

  EventTransformer<SetSearchTermEvent> debounce<SetSearchTermEvent>(
    Duration duration,
  ) =>
      (events, mapper) {
        return events.debounceTime(duration).flatMap(mapper);
      };

  void _setSearchTerm(
    SetSearchTermEvent event,
    Emitter<TodoSearchState> emit,
  ) {
    emit(state.copyWith(searchTerm: event.searchTerm));
  }
}
