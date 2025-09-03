import 'package:bl_todo_app/cubits/cubits.dart';
import 'package:bl_todo_app/models/todo_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cubits/active_todo/active_todo_cubit.dart';

class TodoHeaderWidget extends StatelessWidget {
  const TodoHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          /// Title
          Text(
            "My Todos",
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
              color: Colors.black87,
            ),
          ),

          /// Active todos counter
          BlocListener<TodoCubit, TodoState>(
            listener: (context, state) {
              final int activeTodoCount = state.todoList.where((TodoModel todo) => !todo.completed).toList().length;
              context.read<ActiveTodoCubit>().calculateActiveTodoCount(activeTodoCount);
            },
            child: BlocBuilder<ActiveTodoCubit, ActiveTodoState>(
              builder: (context, state) {
                return Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.redAccent.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    "${state.activeTodoCount} left",
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.redAccent,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
