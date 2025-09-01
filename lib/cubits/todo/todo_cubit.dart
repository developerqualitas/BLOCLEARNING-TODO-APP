import 'package:bl_todo_app/models/todo_model.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'todo_state.dart';

class TodoCubit extends Cubit<TodoState> {
  TodoCubit() : super(TodoState.initial());

  void addTodo(String todoDesc) {
    final newTodo = TodoModel(desc: todoDesc);
    final newTodoList = [...state.todoList, newTodo];

    emit(state.copyWith(todoList: newTodoList));
  }

  void editTodo(String todoDesc, String id) {
    final updatedTodo =
        state.todoList.map((TodoModel todos) {
          if (todos.id == id) {
            return TodoModel(
              id: id,
              desc: todoDesc,
              completed: todos.completed,
            );
          }
          return todos;
        }).toList();

    emit(state.copyWith(todoList: updatedTodo));
  }

  void toggleTodo(String id) {
    final toggleTodo =
        state.todoList.map((TodoModel todos) {
          if (todos.id == id) {
            return TodoModel(id: id, desc: todos.desc, completed: !todos.completed);
          }
          return todos;
        }).toList();

    emit(state.copyWith(todoList: toggleTodo));
  }

  void deleteTodo(TodoModel todoModel){
    final removeTodo = state.todoList.where((TodoModel todo) => todo.id != todoModel.id,).toList();

    emit(state.copyWith(
      todoList: removeTodo
    ));
  }
}
