import 'package:flutter/material.dart';
import '../cubits/cubits.dart';

import 'pages/todos_page/todos_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TodoFilterCubit>(create: (ctx) => TodoFilterCubit()),
        BlocProvider<TodoSearchCubit>(create: (ctx) => TodoSearchCubit()),
        BlocProvider<TodoListCubit>(create: (ctx) => TodoListCubit()),
        BlocProvider<ActiveTodoCountCubit>(
          create: (ctx) => ActiveTodoCountCubit(
            initialActiveTodoCount: ctx
                .read<TodoListCubit>()
                .state
                .todos
                .where((d) => !d.completed)
                .length,
          ),
        ),
        BlocProvider<FilteredTodosCubit>(
          create: (ctx) => FilteredTodosCubit(
            initialFilteredTodos: ctx.read<TodoListCubit>().state.todos,
          ),
        ),
      ],
      child: MaterialApp(
        title: 'TODO',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const TodosPage(),
      ),
    );
  }
}
