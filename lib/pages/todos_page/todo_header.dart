import 'package:flutter/material.dart';
import '../../blocs/blocs.dart';

class TodoHeader extends StatelessWidget {
  const TodoHeader({super.key});

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
        BlocSelector<ActiveTodoCountBloc, ActiveTodoCountState, int>(
          selector: (state) => state.activeTodoCount,
          builder: (ctx, activeTodoCount) => Text(
            '$activeTodoCount items left',
            style: const TextStyle(
              color: Colors.redAccent,
              fontSize: 20,
            ),
          ),
        ),
        // Text(
        //   '${context.watch<ActiveTodoCountBloc>().state.activeTodoCount} items left',
        //   style: const TextStyle(
        //     color: Colors.redAccent,
        //     fontSize: 20,
        //   ),
        // ),
      ],
    );
  }
}
