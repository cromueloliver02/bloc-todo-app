import 'package:flutter/material.dart';

import '../../cubits/cubits.dart';
import '../../models/todo.dart';

class SearchAndFilterTodo extends StatelessWidget {
  const SearchAndFilterTodo({super.key});

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
          onChanged: (value) {
            if (value.trim().isNotEmpty) {
              context.read<TodoSearchCubit>().setSearchTerm(value);
            }
          },
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
      onPressed: () => context.read<TodoFilterCubit>().changeFilter(filter),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          color: context.watch<TodoFilterCubit>().state.filter == filter
              ? Colors.blue
              : Colors.grey,
        ),
      ),
    );
  }
}
