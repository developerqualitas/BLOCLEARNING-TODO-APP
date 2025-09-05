import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';
part 'todo_search_event.dart';
part 'todo_search_state.dart';

class TodoSearchBloc extends Bloc<TodoSearchEvent, TodoSearchState> {
  TodoSearchBloc() : super(TodoSearchState.initial()) {
    on<SearchTodoEvent>(
      _todoSearchEventHandler,
      transformer: debounce(const Duration(milliseconds: 3000)),
    );
  }

  void _todoSearchEventHandler(
    SearchTodoEvent event,
    Emitter<TodoSearchState> emit,
  ) {
    emit(state.copyWith(searchText: event.searchText));
  }

  EventTransformer<SearchTodoEvent> debounce<SearchTodoEvent>(
    Duration duration,
  ) {
    return (event, mapper) => event.debounceTime(duration).flatMap(mapper);
  }
}
