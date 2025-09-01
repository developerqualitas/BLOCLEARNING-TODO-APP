import 'dart:async';

import 'package:bl_todo_app/cubits/todo/todo_cubit.dart';
import 'package:bl_todo_app/cubits/todo_filter/todo_filter_cubit.dart';
import 'package:bl_todo_app/cubits/todo_search/todo_search_cubit.dart';
import 'package:bl_todo_app/models/todo_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'filtered_todos_state.dart';

class FilteredTodosCubit extends Cubit<FilteredTodosState> {
  late StreamSubscription todoFilterStreamSubscription;
  late StreamSubscription todoSearchStreamSubscription;
  late StreamSubscription todoStreamSubscription;

  final TodoCubit todoCubit;
  final TodoSearchCubit todoSearchCubit;
  final TodoFilterCubit todoFilterCubit;

  FilteredTodosCubit({
    required this.todoFilterCubit,
    required this.todoSearchCubit,
    required this.todoCubit,
  }) : super(FilteredTodosState.initial()) {
    todoFilterStreamSubscription = todoFilterCubit.stream.listen((
      TodoFilterState filterState,
    ) {
      setFilteredTodos();
    });

    todoSearchStreamSubscription = todoSearchCubit.stream.listen((
      TodoSearchState searchState,
    ) {
      setFilteredTodos();
    });
    todoStreamSubscription = todoCubit.stream.listen((TodoState todoState) {
      setFilteredTodos();
    });
  }
  void setFilteredTodos() {
    List<TodoModel> filterdTodoList;

    switch (todoFilterCubit.state.todoFilter) {
      case TodoFilter.active:
        filterdTodoList =
            todoCubit.state.todoList
                .where((TodoModel todos) => !todos.completed)
                .toList();
        break;
      case TodoFilter.completed:
        filterdTodoList =
            todoCubit.state.todoList
                .where((TodoModel todos) => todos.completed)
                .toList();
        break;
      case TodoFilter.all:
      default:
        filterdTodoList = todoCubit.state.todoList;
    }

    if (todoSearchCubit.state.searchText.isNotEmpty) {
      filterdTodoList =
          filterdTodoList
              .where(
                (TodoModel todoModel) => todoModel.desc.toLowerCase().contains(
                  todoSearchCubit.state.searchText,
                ),
              )
              .toList();
    }

    emit(state.copyWith(filteredTodoList: filterdTodoList));
  }

  @override
  Future<void> close() {
    todoFilterStreamSubscription.cancel();
    todoStreamSubscription.cancel();
    todoSearchStreamSubscription.cancel();
    return super.close();
  }
}
