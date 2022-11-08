import 'package:bloc_todo_app/cubits/cubits.dart';

class BlocProviderHandler {
  final blocProviders = [
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
  ];
}
