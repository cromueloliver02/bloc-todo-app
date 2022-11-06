import 'package:bloc_todo_app/models/todo.dart';
import 'package:flutter/material.dart';

import '../../cubits/cubits.dart';

class ShowTodos extends StatelessWidget {
  const ShowTodos({super.key});

  @override
  Widget build(BuildContext context) {
    final todos = context.watch<FilteredTodosCubit>().state.filteredTodos;

    return ListView.separated(
      primary: false, // TODO - to learn about this
      shrinkWrap: true, // TODO - to learn about this
      itemCount: todos.length,
      separatorBuilder: (ctx, idx) => const Divider(color: Colors.grey),
      itemBuilder: (ctx, idx) {
        final todo = todos[idx];

        return Dismissible(
          key: ValueKey(todo.id),
          direction: DismissDirection.startToEnd,
          onDismissed: (direction) =>
              ctx.read<TodoListCubit>().removeTodo(todo.id),
          confirmDismiss: (direction) => showDialog(
            context: context,
            barrierDismissible: false,
            builder: (ctx) => AlertDialog(
              title: const Text('Are you sure?'),
              content: const Text('Do you really want to delete?'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: const Text('NO'),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context, true),
                  child: const Text('YES'),
                ),
              ],
            ),
          ),
          background: Container(
            color: Colors.red,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: const Icon(
              Icons.delete,
              size: 30,
              color: Colors.white,
            ),
          ),
          child: _TodoTile(todo: todo),
        );
      },
    );
  }
}

class _TodoTile extends StatefulWidget {
  const _TodoTile({
    Key? key,
    required this.todo,
  }) : super(key: key);

  final Todo todo;

  @override
  State<_TodoTile> createState() => _TodoTileState();
}

class _TodoTileState extends State<_TodoTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Checkbox(
        value: widget.todo.completed,
        onChanged: (value) =>
            context.read<TodoListCubit>().toggleComplete(widget.todo.id),
      ),
      title: Text(
        widget.todo.desc,
        style: const TextStyle(fontSize: 20),
      ),
    );
  }
}
