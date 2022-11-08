import 'dart:async';

import 'package:equatable/equatable.dart';
import '../../blocs/blocs.dart';

part 'active_todo_count_event.dart';
part 'active_todo_count_state.dart';

class ActiveTodoCountBloc
    extends Bloc<ActiveTodoCountEvent, ActiveTodoCountState> {
  late final StreamSubscription todoListSubscription;
  final TodoListBloc todoListBloc;
  final int initialActiveTodoCount;

  ActiveTodoCountBloc({
    required this.todoListBloc,
    required this.initialActiveTodoCount,
  }) : super(ActiveTodoCountState(activeTodoCount: initialActiveTodoCount)) {
    todoListSubscription = todoListBloc.stream.listen(_todoListListener);

    on<CalculateActiveTodoCountEvent>(_calculateActiveTodoCount);
  }

  @override
  Future<void> close() {
    todoListSubscription.cancel();
    return super.close();
  }

  void _todoListListener(TodoListState state) {
    final activeTodoCount = state.todos.where((d) => !d.completed).length;

    add(CalculateActiveTodoCountEvent(activeTodoCount: activeTodoCount));
  }

  void _calculateActiveTodoCount(
    CalculateActiveTodoCountEvent event,
    Emitter<ActiveTodoCountState> emit,
  ) {
    emit(state.copyWith(activeTodoCount: event.activeTodoCount));
  }
}
