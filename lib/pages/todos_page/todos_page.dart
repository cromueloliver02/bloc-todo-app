import 'package:flutter/material.dart';
import 'todo_header.dart';

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
