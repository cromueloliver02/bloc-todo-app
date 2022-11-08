import 'package:flutter/material.dart';

import '../../blocs/blocs.dart';
import '../../models/todo.dart';

class ShowTodos extends StatelessWidget {
  const ShowTodos({super.key});

  @override
  Widget build(BuildContext context) {
    final todos = context.watch<FilteredTodosBloc>().state.filteredTodos;

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
              ctx.read<TodoListBloc>().add(RemoveTodoEvent(id: todo.id)),
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
  late final TextEditingController _editTodoController;

  void _showEditTodoModal() {
    showDialog(
      context: context,
      builder: (ctx) {
        var isError = false;
        _editTodoController.text = widget.todo.desc;

        return StatefulBuilder(
          builder: (ctx, setState) => AlertDialog(
            title: const Text('Edit Todo'),
            content: TextField(
              controller: _editTodoController,
              autofocus: true,
              decoration: InputDecoration(
                errorText: isError ? 'Value cannot be empty' : null,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('CANCEL'),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    isError = _editTodoController.text.isEmpty;
                  });

                  if (!isError) {
                    context.read<TodoListBloc>().add(EditTodoEvent(
                          id: widget.todo.id,
                          desc: _editTodoController.text,
                        ));
                    Navigator.pop(context);
                  }
                },
                child: const Text('SAVE'),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: _showEditTodoModal,
      leading: Checkbox(
        value: widget.todo.completed,
        onChanged: (value) => context
            .read<TodoListBloc>()
            .add(ToggleCompleteEvent(id: widget.todo.id)),
      ),
      title: Text(
        widget.todo.desc,
        style: const TextStyle(fontSize: 20),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _editTodoController = TextEditingController();
  }

  @override
  void dispose() {
    _editTodoController.dispose();
    super.dispose();
  }
}
