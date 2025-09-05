import 'dart:async';

import 'package:bl_todo_app/blocs/blocs.dart';
import 'package:bl_todo_app/models/todo_model.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

part 'todo_active_event.dart';
part 'todo_active_state.dart';

class TodoActiveBloc extends Bloc<TodoActiveEvent, TodoActiveState> {
  final int initialActiveTodoCount;

  TodoActiveBloc({required this.initialActiveTodoCount})
    : super(TodoActiveState(activeTodoCount: initialActiveTodoCount)) {
    on<CalculateActiveTodoCountEvent>(_calculateActiveTodoCountEventHandler);
  }

  void _calculateActiveTodoCountEventHandler(
    CalculateActiveTodoCountEvent event,
    Emitter<TodoActiveState> emit,
  ) {
    emit(state.copyWith(activeTodoCount: event.activeTodoCount));
  }


}
