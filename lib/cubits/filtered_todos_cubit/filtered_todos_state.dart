part of 'filtered_todos_cubit.dart';

class FilteredTodosState extends Equatable {

  final List<TodoModel> filteredTodoList;
  const FilteredTodosState({required this.filteredTodoList});

  factory FilteredTodosState.initial(){
    return FilteredTodosState(filteredTodoList: []);
  }

  FilteredTodosState copyWith({List<TodoModel>? filteredTodoList}) {
    return FilteredTodosState(filteredTodoList: filteredTodoList ?? this.filteredTodoList);
  }

  @override
  String toString() {
    return 'FilteredTodosState{filteredTodoList: $filteredTodoList}';
  }

  @override
  List<Object?> get props => [filteredTodoList];
}

