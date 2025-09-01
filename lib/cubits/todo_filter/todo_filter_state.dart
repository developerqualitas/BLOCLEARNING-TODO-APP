part of 'todo_filter_cubit.dart';

class TodoFilterState extends Equatable {
  final TodoFilter todoFilter;

  const TodoFilterState({required this.todoFilter});

  factory TodoFilterState.initial(){
    return TodoFilterState(todoFilter: TodoFilter.all);
  }

  @override
  String toString() {
    return 'TodoFilterState{todoFilter: $todoFilter}';
  }

  TodoFilterState copyWith({TodoFilter? todoFilter}) {
    return TodoFilterState(todoFilter: todoFilter ?? this.todoFilter);
  }

  @override
  List<Object> get props => [todoFilter];
}
