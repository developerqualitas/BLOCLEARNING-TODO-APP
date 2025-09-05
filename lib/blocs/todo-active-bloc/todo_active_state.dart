part of 'todo_active_bloc.dart';

class TodoActiveState extends Equatable {
  final int activeTodoCount;

  const TodoActiveState({required this.activeTodoCount});

  factory TodoActiveState.initial() {
    return TodoActiveState(activeTodoCount: 0);
  }

  TodoActiveState copyWith({int? activeTodoCount}) {
    return TodoActiveState(
      activeTodoCount: activeTodoCount ?? this.activeTodoCount,
    );
  }

  @override
  String toString() {
    return 'TodoActiveState{activeTodoCount: $activeTodoCount}';
  }

  @override
  List<Object> get props => [activeTodoCount];
}
