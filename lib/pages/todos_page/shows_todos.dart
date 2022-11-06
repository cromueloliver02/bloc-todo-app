import 'package:flutter/material.dart';

import '../../cubits/cubits.dart';

class ShowTodos extends StatelessWidget {
  const ShowTodos({super.key});

  @override
  Widget build(BuildContext context) {
    final todos = context.watch<FilteredTodosCubit>().state.filteredTodos;

    return Container(
      color: Colors.grey,
      child: ListView.separated(
        primary: false, // TODO - to learn about this
        shrinkWrap: true, // TODO - to learn about this
        itemCount: todos.length,
        separatorBuilder: (ctx, idx) => const Divider(color: Colors.grey),
        itemBuilder: (ctx, idx) {
          final todo = todos[idx];

          return Text(
            todo.desc,
            style: const TextStyle(fontSize: 20),
          );
        },
      ),
    );
  }
}
