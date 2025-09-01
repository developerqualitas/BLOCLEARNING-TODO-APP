part of 'todo_cubit.dart';

class TodoState extends Equatable {
  final List<TodoModel> todoList;
  const TodoState({required this.todoList});

  factory TodoState.initial() {
    return TodoState(todoList: []);
  }

  TodoState copyWith({List<TodoModel>? todoList}) {
    return TodoState(todoList: todoList ?? this.todoList);
  }

  @override
  String toString() {
    return 'TodoState{todoList: $todoList}';
  }

  @override
  List<Object> get props => [todoList];
}
