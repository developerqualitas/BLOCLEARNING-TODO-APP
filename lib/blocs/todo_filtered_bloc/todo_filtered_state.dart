part of 'todo_filtered_bloc.dart';

class TodoFilteredState extends Equatable {

  final List<TodoModel> filteredTodoList;
  const TodoFilteredState({required this.filteredTodoList});

  factory TodoFilteredState.initial(){
    return TodoFilteredState(filteredTodoList: []);
  }

  TodoFilteredState copyWith({List<TodoModel>? filteredTodoList}) {
    return TodoFilteredState(filteredTodoList: filteredTodoList ?? this.filteredTodoList);
  }

  @override
  String toString() {
    return 'TodoFilteredState{filteredTodoList: $filteredTodoList}';
  }

  @override
  List<Object?> get props => [filteredTodoList];
}

