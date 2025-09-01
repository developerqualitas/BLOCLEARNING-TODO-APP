part of 'active_todo_cubit.dart';

class ActiveTodoState extends Equatable {
  final int activeTodoCount;

  const ActiveTodoState({required this.activeTodoCount});

  factory ActiveTodoState.initial(){
    return ActiveTodoState(activeTodoCount: 0);
  }

  ActiveTodoState copyWith({int? activeTodoCount}) {
    return ActiveTodoState(
      activeTodoCount: activeTodoCount ?? this.activeTodoCount,
    );
  }

  @override
  String toString() {
    return 'ActiveTodoState{activeTodoCount: $activeTodoCount}';
  }

  @override
  List<Object> get props => [activeTodoCount];
}
