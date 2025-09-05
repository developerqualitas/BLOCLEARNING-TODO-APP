import 'package:bl_todo_app/blocs/blocs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateTodoWidget extends StatefulWidget {
  const CreateTodoWidget({super.key});

  @override
  State<CreateTodoWidget> createState() => _CreateTodoWidgetState();
}

class _CreateTodoWidgetState extends State<CreateTodoWidget> {
  final todoController = TextEditingController();

  @override
  void dispose() {
    todoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
      child: TextFormField(
        controller: todoController,
        decoration: InputDecoration(
          hintText: "Add a new task...",
          prefixIcon: const Icon(
            Icons.add_task_outlined,
            color: Colors.blueAccent,
          ),
          filled: true,
          fillColor: Colors.grey.shade100,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 14,
            horizontal: 16,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.blueAccent, width: 1.5),
          ),
        ),
        onFieldSubmitted: (String? desc) {
          if (desc != null && desc.trim().isNotEmpty) {
            context.read<TodoListBloc>().add(AddTodoEvent(todoDesc: desc));
            todoController.clear();
          }
        },
      ),
    );
  }
}
