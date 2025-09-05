part of 'todo_filtered_bloc.dart';

abstract class TodoFilteredEvent extends Equatable {
  const TodoFilteredEvent();
}

class CalculatedFilteredTodoListEvent extends TodoFilteredEvent {
  final List<TodoModel> filteredTodoList;

  CalculatedFilteredTodoListEvent({required this.filteredTodoList});

  @override
  String toString() {
    return 'CalculatedFilteredTodoListEvent{filteredTodoList: $filteredTodoList}';
  }

  @override
  List<Object> get props => [filteredTodoList];
}
