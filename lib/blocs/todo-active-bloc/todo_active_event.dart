part of 'todo_active_bloc.dart';

abstract class TodoActiveEvent extends Equatable {
  const TodoActiveEvent();
}

class CalculateActiveTodoCountEvent extends TodoActiveEvent {
  final int activeTodoCount;

  CalculateActiveTodoCountEvent({required this.activeTodoCount});

  @override
  String toString() {
    return 'CalculateActiveTodoCountEvent{activeTodoCount: $activeTodoCount}';
  }

  @override
  List<Object> get props => [activeTodoCount];
}
