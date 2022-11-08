// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../models/todo.dart';

part 'todo_filter_event.dart';
part 'todo_filter_state.dart';

class TodoFilterBloc extends Bloc<TodoFilterEvent, TodoFilterState> {
  TodoFilterBloc() : super(TodoFilterState.initial()) {
    on<ChangeFilterEvent>(_changeFilter);
  }

  void _changeFilter(
    ChangeFilterEvent event,
    Emitter<TodoFilterState> emit,
  ) {
    emit(state.copyWith(filter: event.filter));
  }
}
