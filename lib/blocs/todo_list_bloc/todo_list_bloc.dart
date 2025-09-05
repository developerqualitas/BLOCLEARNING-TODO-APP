import 'package:bl_todo_app/models/todo_model.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'todo_list_event.dart';
part 'todo_list_state.dart';

class TodoListBloc extends Bloc<TodoListEvent, TodoListState> {
  TodoListBloc() : super(TodoListState.initial()) {
    on<AddTodoEvent>(_addTodoEventHandler);
    on<EditTodoEvent>(_editTodoEventHandler);
    on<ToggleTodoEvent>(_toggleTodoEventHandler);
    on<RemoveTodoEvent>(_removeTodoEventHandler);
  }

  void _addTodoEventHandler(AddTodoEvent event, Emitter<TodoListState> emit) {
    final newTodo = TodoModel(desc: event.todoDesc);
    final newTodos = [...state.todoList, newTodo];

    emit(state.copyWith(todoList: newTodos));
  }

  void _editTodoEventHandler(EditTodoEvent event, Emitter<TodoListState> emit) {
    final updateTodo =
        state.todoList.map((TodoModel todoModel) {
          if (todoModel.id == event.todoId) {
            return TodoModel(
              id: todoModel.id,
              desc: event.todoDesc,
              completed: todoModel.completed,
            );
          }
          return todoModel;
        }).toList();

    emit(state.copyWith(todoList: updateTodo));
  }

  void _toggleTodoEventHandler(
    ToggleTodoEvent event,
    Emitter<TodoListState> emit,
  ) {
    final toggleTodo =
        state.todoList.map((TodoModel todoModel) {
          if (todoModel.id == event.todoId) {
            return TodoModel(
              id: todoModel.id,
              desc: todoModel.desc,
              completed: !todoModel.completed,
            );
          }
          return todoModel;
        }).toList();

    emit(state.copyWith(todoList: toggleTodo));
  }

  void _removeTodoEventHandler(
    RemoveTodoEvent event,
    Emitter<TodoListState> emit,
  ) {
    final removeTodo =
        state.todoList.where((TodoModel todo) => todo.id != event.todoModel.id).toList();

    emit(state.copyWith(todoList: removeTodo));
  }
}
