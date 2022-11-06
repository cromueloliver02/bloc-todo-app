import 'package:bloc_todo_app/models/todo.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../../cubits/cubits.dart';

class CreateTodo extends StatefulWidget {
  const CreateTodo({super.key});

  @override
  State<CreateTodo> createState() => _CreateTodoState();
}

class _CreateTodoState extends State<CreateTodo> {
  late final TextEditingController _createTodoController;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _createTodoController,
      decoration: const InputDecoration(labelText: 'What to do?'),
      onSubmitted: (value) {
        if (value.trim().isNotEmpty) {
          const uuid = Uuid();
          final todo = Todo(id: uuid.v4(), desc: value);

          context.read<TodoListCubit>().addTodo(todo);
          _createTodoController.clear();
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _createTodoController = TextEditingController();
  }

  @override
  void dispose() {
    _createTodoController.dispose();
    super.dispose();
  }
}
