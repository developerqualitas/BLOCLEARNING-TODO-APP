import 'dart:async';

import 'package:bl_todo_app/blocs/blocs.dart';
import 'package:bl_todo_app/models/todo_model.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

part 'todo_active_event.dart';
part 'todo_active_state.dart';

class TodoActiveBloc extends Bloc<TodoActiveEvent, TodoActiveState> {
  late StreamSubscription todoStreamSubscription;
  final int initialActiveTodoCount;
  final TodoListBloc todoListBloc;

  TodoActiveBloc({
    required this.initialActiveTodoCount,
    required this.todoListBloc,
  }) : super(TodoActiveState(activeTodoCount: initialActiveTodoCount)) {
    todoStreamSubscription = todoListBloc.stream.listen((
      TodoListState todoListState,
    ) {
      debugPrint("todo state : $todoListState");

      final int currentActiveTodoCount =
          todoListState.todoList
              .where((TodoModel todoModel) => !todoModel.completed)
              .toList()
              .length;

      emit(state.copyWith(activeTodoCount: currentActiveTodoCount));
    });

    on<CalculateActiveTodoCountEvent>(_calculateActiveTodoCountEventHandler);
  }

  void _calculateActiveTodoCountEventHandler(
    CalculateActiveTodoCountEvent event,
    Emitter<TodoActiveState> emit,
  ) {

    emit(state.copyWith(
      activeTodoCount: event.activeTodoCount
    ));
  }



  @override
  Future<void> close() {
    todoStreamSubscription.cancel();
    return super.close();
  }
}
