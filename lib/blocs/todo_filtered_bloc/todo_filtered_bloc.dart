import 'package:bl_todo_app/models/todo_model.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'todo_filtered_event.dart';
part 'todo_filtered_state.dart';

class TodoFilteredBloc extends Bloc<TodoFilteredEvent, TodoFilteredState> {
  final List<TodoModel> initialTodoList;

  TodoFilteredBloc({required this.initialTodoList})
    : super(TodoFilteredState(filteredTodoList: initialTodoList)) {
    on<CalculatedFilteredTodoListEvent>(
      _calculatedFilteredTodoListEventHandler,
    );
  }

  void _calculatedFilteredTodoListEventHandler(
    CalculatedFilteredTodoListEvent event,
    Emitter<TodoFilteredState> emit,
  ) {
    emit(state.copyWith(filteredTodoList: event.filteredTodoList));
  }
}
