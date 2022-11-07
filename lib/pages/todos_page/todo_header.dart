import 'package:flutter/material.dart';
import '../../cubits/cubits.dart';

class TodoHeader extends StatelessWidget {
  const TodoHeader({super.key});

  void _activeTodoCountListener(BuildContext ctx, TodoListState state) {
    final activeTodoCount = state.todos.where((d) => !d.completed).length;

    ctx.read<ActiveTodoCountCubit>().calculateActiveTodoCount(activeTodoCount);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'TODO',
          style: TextStyle(
            fontSize: 40,
          ),
        ),
        BlocListener<TodoListCubit, TodoListState>(
          listener: _activeTodoCountListener,
          child: BlocSelector<ActiveTodoCountCubit, ActiveTodoCountState, int>(
            selector: (state) => state.activeTodoCount,
            builder: (ctx, activeTodoCount) => Text(
              '$activeTodoCount items left',
              style: const TextStyle(
                color: Colors.redAccent,
                fontSize: 20,
              ),
            ),
          ),
        ),
        // Text(
        //   '${context.watch<ActiveTodoCountCubit>().state.activeTodoCount} items left',
        //   style: const TextStyle(
        //     color: Colors.redAccent,
        //     fontSize: 20,
        //   ),
        // ),
      ],
    );
  }
}
