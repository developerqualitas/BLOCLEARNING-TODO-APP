part of 'todo_list_bloc.dart';

abstract class TodoListEvent extends Equatable {
  const TodoListEvent();
}

// Add Todo Event
class AddTodoEvent extends TodoListEvent {
  final String todoDesc;

  const AddTodoEvent({required this.todoDesc});

  @override
  String toString() {
    return 'AddTodoEvent{todoDesc: $todoDesc}';
  }

  @override
  List<Object> get props => [todoDesc];
}

// Edit Todo Event
class EditTodoEvent extends TodoListEvent {
  final String todoId;
  final String todoDesc;

  const EditTodoEvent({required this.todoId, required this.todoDesc});

  @override
  String toString() {
    return 'EditTodoEvent{todoId: $todoId, todoDesc: $todoDesc}';
  }

  @override
  List<Object> get props => [todoId, todoDesc];
}

// Toggle Todo Event
class ToggleTodoEvent extends TodoListEvent {
  final String todoId;

  const ToggleTodoEvent({required this.todoId});

  @override
  String toString() {
    return 'ToggleTodoEvent{todoId: $todoId}';
  }

  @override
  List<Object> get props => [todoId];
}

// Remove Todo Event
class RemoveTodoEvent extends TodoListEvent {
  final TodoModel todoModel;

  const RemoveTodoEvent({required this.todoModel});

  @override
  String toString() {
    return 'RemoveTodoEvent{todoModel: $todoModel}';
  }

  @override
  List<Object> get props => [todoModel];
}
