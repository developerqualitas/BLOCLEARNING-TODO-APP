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

  void setFilteredTodos({
    required TodoFilter todoFilter,
    required String searchText,
    required List<TodoModel> todoList,
  }) {
    List<TodoModel> filterdTodoList;

    switch (todoFilter) {
      case TodoFilter.active:
        filterdTodoList =
            todoList.where((TodoModel todos) => !todos.completed).toList();
        break;
      case TodoFilter.completed:
        filterdTodoList =
            todoList.where((TodoModel todos) => todos.completed).toList();
        break;
      case TodoFilter.all:
      default:
        filterdTodoList = todoList;
    }

    if (searchText.isNotEmpty) {
      filterdTodoList =
          filterdTodoList
              .where(
                (TodoModel todoModel) =>
                    todoModel.desc.toLowerCase().contains(searchText),
              )
              .toList();
    }

    emit(state.copyWith(filteredTodoList: filterdTodoList));
  }
}
