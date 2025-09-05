import 'package:bl_todo_app/pages/todo/widgets/create_todo_widget.dart';
import 'package:bl_todo_app/pages/todo/widgets/search_and_filter_widget.dart';
import 'package:bl_todo_app/pages/todo/widgets/todo_header_widget.dart';
import 'package:flutter/material.dart';
import 'widgets/show_todo_list_widget.dart';

class TodoPage extends StatelessWidget {
  const TodoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 40.0, horizontal: 20.0),
            child: Column(
              children: [
                TodoHeaderWidget(),
                CreateTodoWidget(),
                SearchAndFilterWidget(),
                ShowTodoListWidget()

              ],
            ),
          ),
        ),
      ),
    );
  }
}


// todoFilterStreamSubscription = todoFilterBloc.stream.listen((
// TodoFilterState filterState,
// ) {
// setFilteredTodos();
// });
//
// todoSearchStreamSubscription = todoSearchBloc.stream.listen((
// TodoSearchState searchState,
// ) {
// setFilteredTodos();
// });
//
// todoStreamSubscription = todoListBloc.stream.listen((todoState) {
// setFilteredTodos();
// });



// todoStreamSubscription = todoListBloc.stream.listen((
// TodoListState todoListState,
// ) {
// debugPrint("todo state : $todoListState");
//
// final int currentActiveTodoCount =
// todoListState.todoList
//     .where((TodoModel todoModel) => !todoModel.completed)
//     .toList()
//     .length;
//
// emit(state.copyWith(activeTodoCount: currentActiveTodoCount));
// });



// void setFilteredTodos() {
//   List<TodoModel> filterdTodoList;
//
//   switch (todoFilterBloc.state.todoFilter) {
//     case TodoFilter.active:
//       filterdTodoList =
//           todoListBloc.state.todoList
//               .where((TodoModel todos) => !todos.completed)
//               .toList();
//       break;
//     case TodoFilter.completed:
//       filterdTodoList =
//           todoListBloc.state.todoList
//               .where((TodoModel todos) => todos.completed)
//               .toList();
//       break;
//     case TodoFilter.all:
//     default:
//       filterdTodoList = todoListBloc.state.todoList;
//   }
//
//   if (todoSearchBloc.state.searchText.isNotEmpty) {
//     filterdTodoList =
//         filterdTodoList
//             .where(
//               (TodoModel todoModel) => todoModel.desc.toLowerCase().contains(
//             todoSearchBloc.state.searchText,
//           ),
//         )
//             .toList();
//   }
//
//   emit(state.copyWith(filteredTodoList: filterdTodoList));
// }