import 'package:flutter/material.dart';
import 'package:bloc_todo_app/cubits/cubits.dart';

class TodosPage extends StatelessWidget {
  const TodosPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 40,
            ),
            child: Column(
              children: const [
                TodoHeader(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

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
        // BlocSelector<ActiveTodoCountCubit, ActiveTodoCountState, int>(
        //   selector: (state) => state.activeTodoCount,
        //   builder: (context, activeTodoCount) => Text(
        //     '$activeTodoCount items left',
        //     style: const TextStyle(
        //       color: Colors.redAccent,
        //       fontSize: 20,
        //     ),
        //   ),
        // ),
        Text(
          '${context.watch<ActiveTodoCountCubit>().state.activeTodoCount} items left',
          style: const TextStyle(
            color: Colors.redAccent,
            fontSize: 20,
          ),
        ),
      ],
    );
  }
}
