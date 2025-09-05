part of 'todo_list_bloc.dart';


class TodoListState extends Equatable {
  final List<TodoModel> todoList;
  const TodoListState({required this.todoList});

  factory TodoListState.initial() {
    return TodoListState(todoList: [TodoModel(id: "1", desc: "First Todo")]);
  }

  TodoListState copyWith({List<TodoModel>? todoList}) {
    return TodoListState(todoList: todoList ?? this.todoList);
  }

  @override
  String toString() {
    return 'TodoListState{todoList: $todoList}';
  }

  @override
  List<Object> get props => [todoList];
}
