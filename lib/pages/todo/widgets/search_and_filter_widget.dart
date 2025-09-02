import 'package:bl_todo_app/cubits/cubits.dart';
import 'package:bl_todo_app/models/todo_model.dart';
import 'package:bl_todo_app/utils/debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchAndFilterWidget extends StatefulWidget {
  SearchAndFilterWidget({super.key});
  final debounce = Debounce(milliseconds: 2000);

  @override
  State<SearchAndFilterWidget> createState() => _SearchAndFilterWidgetState();
}

class _SearchAndFilterWidgetState extends State<SearchAndFilterWidget> {
  final searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// Search Bar
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          child: TextFormField(
            controller: searchController,
            decoration: InputDecoration(
              hintText: "Search todos...",
              prefixIcon: const Icon(Icons.search, color: Colors.grey),
              filled: true,
              fillColor: Colors.grey.shade100,
              contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Colors.blueAccent, width: 1.5),
              ),
            ),
            onChanged: (String? searchText) {
              if (searchText != null) {
                widget.debounce.run(() {
                  context.read<TodoSearchCubit>().applySearch(searchText);
                });
              }
            },
          ),
        ),

        /// Filter Buttons Row
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              filterButtonWidget(context, TodoFilter.all),
              filterButtonWidget(context, TodoFilter.active),
              filterButtonWidget(context, TodoFilter.completed),
            ],
          ),
        ),
      ],
    );
  }

  Widget filterButtonWidget(BuildContext context, TodoFilter todoFilter) {
    final currentFilter = context.watch<TodoFilterCubit>().state.todoFilter;
    final isSelected = currentFilter == todoFilter;

    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: isSelected ? Colors.blueAccent.withOpacity(0.1) : Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
      onPressed: () {
        context.read<TodoFilterCubit>().changeFilter(todoFilter);
      },
      child: Text(
        todoFilter == TodoFilter.all
            ? "All"
            : todoFilter == TodoFilter.active
            ? "Active"
            : "Completed",
        style: TextStyle(
          fontSize: 16,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          color: isSelected ? Colors.blueAccent : Colors.grey,
        ),
      ),
    );
  }
}
