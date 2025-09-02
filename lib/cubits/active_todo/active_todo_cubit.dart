import 'dart:async';

import 'package:bl_todo_app/cubits/todo/todo_cubit.dart';
import 'package:bl_todo_app/models/todo_model.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

part 'active_todo_state.dart';

class ActiveTodoCubit extends Cubit<ActiveTodoState> {
  late StreamSubscription todoStreamSubscription;

  final int initialActiveTodoCount;
  final TodoCubit todoCubit;

  ActiveTodoCubit({required this.initialActiveTodoCount ,required this.todoCubit}) : super(ActiveTodoState(activeTodoCount: initialActiveTodoCount)) {
    todoStreamSubscription = todoCubit.stream.listen((TodoState todoState) {
      debugPrint("todo state : $todoState");

      final int currentActiveTodoCount =
          todoState.todoList
              .where((TodoModel todoModel) => !todoModel.completed)
              .toList()
              .length;

      emit(state.copyWith(activeTodoCount: currentActiveTodoCount));
    });
  }

  @override
  Future<void> close() {
    todoStreamSubscription.cancel();
    return super.close();
  }
}
