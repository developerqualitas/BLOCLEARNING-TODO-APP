import 'package:bl_todo_app/models/todo_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'filtered_todos_state.dart';

class FilteredTodosCubit extends Cubit<FilteredTodosState> {
  final List<TodoModel> initialTodoList;

  FilteredTodosCubit({required this.initialTodoList})
    : super(FilteredTodosState(filteredTodoList: initialTodoList));
  void setFilteredTodos(
    TodoFilter todoFilter,
    String searchText,
    List<TodoModel> todoList,
  ) {
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
