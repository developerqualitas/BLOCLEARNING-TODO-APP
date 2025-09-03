import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';


part 'active_todo_state.dart';

class ActiveTodoCubit extends Cubit<ActiveTodoState> {
  final int initialActiveTodoCount;

  ActiveTodoCubit({required this.initialActiveTodoCount})
    : super(ActiveTodoState(activeTodoCount: initialActiveTodoCount));

  void calculateActiveTodoCount(int activeTodoCount) {
    emit(state.copyWith(
      activeTodoCount: activeTodoCount
    ));
  }
}
