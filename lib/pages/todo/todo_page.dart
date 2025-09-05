import 'package:bl_todo_app/pages/todo/widgets/create_todo_widget.dart';
import 'package:bl_todo_app/pages/todo/widgets/search_and_filter_widget.dart';
import 'package:bl_todo_app/pages/todo/widgets/todo_header_widget.dart';
import 'package:flutter/material.dart';
import 'widgets/show_todo_list_widget.dart';

class TodoPage extends StatelessWidget {
  const TodoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 40.0, horizontal: 20.0),
            child: Column(
              children: [
                TodoHeaderWidget(),
                CreateTodoWidget(),
                SearchAndFilterWidget(),
                ShowTodoListWidget()

              ],
            ),
          ),
        ),
      ),
    );
  }
}
