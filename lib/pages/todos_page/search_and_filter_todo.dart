import 'package:flutter/material.dart';
import '../../blocs/blocs.dart';
import '../../models/todo.dart';
import '../../utils/debounce.dart';

class SearchAndFilterTodo extends StatelessWidget {
  SearchAndFilterTodo({super.key});

  final debounce = Debounce(milliseconds: 1000);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          decoration: const InputDecoration(
            labelText: 'Search todos...',
            border: InputBorder.none,
            filled: true,
            prefixIcon: Icon(Icons.search),
          ),
          onChanged: (value) => debounce.run(
            () => context
                .read<TodoSearchBloc>()
                .add(SetSearchTermEvent(searchTerm: value)),
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            _FilterButton(
              title: 'All',
              filter: Filter.all,
            ),
            _FilterButton(
              title: 'Active',
              filter: Filter.active,
            ),
            _FilterButton(
              title: 'Completed',
              filter: Filter.completed,
            ),
          ],
        ),
      ],
    );
  }
}

class _FilterButton extends StatelessWidget {
  const _FilterButton({
    Key? key,
    required this.title,
    required this.filter,
  }) : super(key: key);

  final String title;
  final Filter filter;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () =>
          context.read<TodoFilterBloc>().add(ChangeFilterEvent(filter: filter)),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          color: context.watch<TodoFilterBloc>().state.filter == filter
              ? Colors.blue
              : Colors.grey,
        ),
      ),
    );
  }
}
