import 'package:bl_todo_app/models/todo_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'todo_filter_event.dart';
part 'todo_filter_state.dart';

class TodoFilterBloc extends Bloc<TodoFilterEvent, TodoFilterState> {
  TodoFilterBloc() : super(TodoFilterState.initial()) {
    on<ChangeFilterEvent>(_changeFilterEventHandler);
  }

  void _changeFilterEventHandler(
    ChangeFilterEvent event,
    Emitter<TodoFilterState> emit,
  ) {
    emit(
      state.copyWith(
        todoFilter: event.newFilter
      )
    );
  }
}
