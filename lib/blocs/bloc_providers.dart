import 'blocs.dart';

class BlocProviderHandler {
  final blocProviders = [
    BlocProvider<TodoFilterBloc>(create: (ctx) => TodoFilterBloc()),
    BlocProvider<TodoSearchBloc>(create: (ctx) => TodoSearchBloc()),
    BlocProvider<TodoListBloc>(create: (ctx) => TodoListBloc()),
    BlocProvider<ActiveTodoCountBloc>(
      create: (ctx) => ActiveTodoCountBloc(
        todoListBloc: ctx.read<TodoListBloc>(),
        initialActiveTodoCount: ctx
            .read<TodoListBloc>()
            .state
            .todos
            .where((d) => !d.completed)
            .length,
      ),
    ),
    BlocProvider<FilteredTodosBloc>(
      create: (ctx) => FilteredTodosBloc(
        todoFilterBloc: ctx.read<TodoFilterBloc>(),
        todoSearchBloc: ctx.read<TodoSearchBloc>(),
        todoListBloc: ctx.read<TodoListBloc>(),
        initialFilteredTodos: ctx.read<TodoListBloc>().state.todos,
      ),
    ),
  ];
}
