import 'package:bl_todo_app/blocs/blocs.dart';
import 'package:bl_todo_app/blocs/todo-active-bloc/todo_active_bloc.dart';
import 'package:bl_todo_app/pages/todo/todo_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // Blocs
        BlocProvider<TodoFilterBloc>(create: (context) => TodoFilterBloc()),
        BlocProvider<TodoSearchBloc>(create: (context) => TodoSearchBloc()),
        BlocProvider<TodoListBloc>(create: (context) => TodoListBloc()),
        BlocProvider<TodoFilteredBloc>(
          create:
              (context) => TodoFilteredBloc(
                initialTodoList: context.read<TodoListBloc>().state.todoList,
              ),
        ),
        BlocProvider<TodoActiveBloc>(
          create:
              (context) => TodoActiveBloc(
                initialActiveTodoCount:
                    context.read<TodoListBloc>().state.todoList.length,
              ),
        ),
      ],
      child: MaterialApp(
        title: 'BL-TODO-APP',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: TodoPage(),
      ),
    );
  }
}
