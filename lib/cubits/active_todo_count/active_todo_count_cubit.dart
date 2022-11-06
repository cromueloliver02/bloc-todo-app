import 'dart:async';

// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../cubits/todo_list/todo_list_cubit.dart';

part 'active_todo_count_state.dart';

class ActiveTodoCountCubit extends Cubit<ActiveTodoCountState> {
  final TodoListCubit todoListCubit;
  late final StreamSubscription _todoListSubscription;

  ActiveTodoCountCubit({required this.todoListCubit})
      : super(ActiveTodoCountState.initial()) {
    _todoListSubscription = todoListCubit.stream.listen(_todoListListener);
  }

  @override
  Future<void> close() {
    _todoListSubscription.cancel();
    return super.close();
  }

  void _todoListListener(todoListState) {
    final activeTodoCount =
        todoListState.todos.where((d) => !d.completed).length;

    emit(state.copyWith(activeTodoCount: activeTodoCount));
  }
}
