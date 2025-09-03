import 'package:bl_todo_app/cubits/cubits.dart';
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
        BlocProvider<TodoCubit>(create: (context) => TodoCubit()),
        BlocProvider<TodoFilterCubit>(create: (context) => TodoFilterCubit()),
        BlocProvider<TodoSearchCubit>(create: (context) => TodoSearchCubit()),
        BlocProvider<FilteredTodosCubit>(
          create:
              (context) => FilteredTodosCubit(
                initialTodoList: context.read<TodoCubit>().state.todoList,
              ),
        ),
        BlocProvider<ActiveTodoCubit>(
          create:
              (context) => ActiveTodoCubit(
                initialActiveTodoCount:
                    context.read<TodoCubit>().state.todoList.length,
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
