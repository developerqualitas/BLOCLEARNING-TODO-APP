import 'dart:async';

import 'package:bl_todo_app/blocs/blocs.dart';
import 'package:bl_todo_app/models/todo_model.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'todo_filtered_event.dart';
part 'todo_filtered_state.dart';

class TodoFilteredBloc extends Bloc<TodoFilteredEvent, TodoFilteredState> {
  late StreamSubscription todoFilterStreamSubscription;
  late StreamSubscription todoSearchStreamSubscription;
  late StreamSubscription todoStreamSubscription;

  final TodoListBloc todoListBloc;
  final TodoSearchBloc todoSearchBloc;
  final TodoFilterBloc todoFilterBloc;

  final List<TodoModel> initialTodoList;

  TodoFilteredBloc({
    required this.todoListBloc,
    required this.todoSearchBloc,
    required this.todoFilterBloc,
    required this.initialTodoList,
  }) : super(TodoFilteredState(filteredTodoList: initialTodoList)) {
    todoFilterStreamSubscription = todoFilterBloc.stream.listen((
      TodoFilterState filterState,
    ) {
      setFilteredTodos();
    });

    todoSearchStreamSubscription = todoSearchBloc.stream.listen((
      TodoSearchState searchState,
    ) {
      setFilteredTodos();
    });

    todoStreamSubscription = todoListBloc.stream.listen((todoState) {
      setFilteredTodos();
    });

    on<CalculatedFilteredTodoListEvent>(
      _calculatedFilteredTodoListEventHandler,
    );
  }

  void setFilteredTodos() {
    List<TodoModel> filterdTodoList;

    switch (todoFilterBloc.state.todoFilter) {
      case TodoFilter.active:
        filterdTodoList =
            todoListBloc.state.todoList
                .where((TodoModel todos) => !todos.completed)
                .toList();
        break;
      case TodoFilter.completed:
        filterdTodoList =
            todoListBloc.state.todoList
                .where((TodoModel todos) => todos.completed)
                .toList();
        break;
      case TodoFilter.all:
      default:
        filterdTodoList = todoListBloc.state.todoList;
    }

    if (todoSearchBloc.state.searchText.isNotEmpty) {
      filterdTodoList =
          filterdTodoList
              .where(
                (TodoModel todoModel) => todoModel.desc.toLowerCase().contains(
                  todoSearchBloc.state.searchText,
                ),
              )
              .toList();
    }

    emit(state.copyWith(filteredTodoList: filterdTodoList));
  }

  void _calculatedFilteredTodoListEventHandler(
    CalculatedFilteredTodoListEvent event,
    Emitter<TodoFilteredState> emit,
  ) {
    emit(state.copyWith(filteredTodoList: event.filteredTodoList));
  }

  @override
  Future<void> close() {
    todoFilterStreamSubscription.cancel();
    todoStreamSubscription.cancel();
    todoSearchStreamSubscription.cancel();
    return super.close();
  }
}
