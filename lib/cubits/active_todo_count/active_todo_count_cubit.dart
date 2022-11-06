import 'dart:async';

// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../cubits/todo_list/todo_list_cubit.dart';

part 'active_todo_count_state.dart';

class ActiveTodoCountCubit extends Cubit<ActiveTodoCountState> {
  late final StreamSubscription _todoListSubscription;
  final TodoListCubit todoListCubit;
  final int initialActiveTodoCount;

  ActiveTodoCountCubit({
    required this.todoListCubit,
    required this.initialActiveTodoCount,
  }) : super(ActiveTodoCountState(activeTodoCount: initialActiveTodoCount)) {
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
