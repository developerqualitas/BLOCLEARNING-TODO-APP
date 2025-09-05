part of 'todo_search_bloc.dart';

abstract class TodoSearchEvent extends Equatable {
  const TodoSearchEvent();
}

class SearchTodoEvent extends TodoSearchEvent {
  final String searchText;

  const SearchTodoEvent({required this.searchText});

  @override
  String toString() {
    return 'SearchTodoEvent{searchText: $searchText}';
  }

  @override
  List<Object> get props => [searchText];
}
