import 'package:bl_todo_app/blocs/blocs.dart';
import 'package:bl_todo_app/models/todo_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShowTodoListWidget extends StatelessWidget {
  const ShowTodoListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final todo = context.watch<TodoFilteredBloc>().state.filteredTodoList;
    return MultiBlocListener(
      listeners: [
        //Todo Bloc List
        BlocListener<TodoListBloc, TodoListState>(
          listener: (context, state) {
            context.read<TodoFilteredBloc>().setFilteredTodos(
              todoFilter: context.read<TodoFilterBloc>().state.todoFilter,
              searchText: context.read<TodoSearchBloc>().state.searchText,
              todoList: state.todoList,
            );
          },
        ),

        //Todo Search Bloc List
        BlocListener<TodoSearchBloc, TodoSearchState>(
          listener: (context, state) {
            context.read<TodoFilteredBloc>().setFilteredTodos(
              todoFilter: context.read<TodoFilterBloc>().state.todoFilter,
              searchText: state.searchText,
              todoList: context.read<TodoListBloc>().state.todoList,
            );
          },
        ),

        //Todo Filter Bloc List
        BlocListener<TodoFilterBloc, TodoFilterState>(
          listener: (context, state) {
            context.read<TodoFilteredBloc>().setFilteredTodos(
              todoFilter: state.todoFilter,
              searchText: context.read<TodoSearchBloc>().state.searchText,
              todoList: context.read<TodoListBloc>().state.todoList,
            );
          },
        ),
      ],
      child: ListView.separated(
        primary: false,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Dismissible(
            key: ValueKey(todo[index].id),
            background: showDismissBackground(isLeft: true),
            secondaryBackground: showDismissBackground(isLeft: false),
            child: TodoListItem(todoModel: todo[index]),
            onDismissed: (_) {
              context.read<TodoListBloc>().add(
                RemoveTodoEvent(todoModel: todo[index]),
              );
            },
            confirmDismiss: (_) {
              return showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) {
                  return AlertDialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    title: const Text("Are You Sure?"),
                    content: const Text(
                      "Do you really want to delete this todo?",
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context, false);
                        },
                        child: const Text("No"),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context, true);
                        },
                        child: const Text("Yes"),
                      ),
                    ],
                  );
                },
              );
            },
          );
        },
        separatorBuilder: (context, index) {
          return const Divider(height: 1, thickness: 0.8);
        },
        itemCount: todo.length,
      ),
    );
  }

  Widget showDismissBackground({required bool isLeft}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
        color: Colors.redAccent,
        borderRadius: BorderRadius.circular(8.0),
      ),
      alignment: isLeft ? Alignment.centerLeft : Alignment.centerRight,
      child: const Icon(Icons.delete, size: 26.0, color: Colors.white),
    );
  }
}

class TodoListItem extends StatefulWidget {
  final TodoModel todoModel;
  const TodoListItem({super.key, required this.todoModel});

  @override
  State<TodoListItem> createState() => _TodoListItemState();
}

class _TodoListItemState extends State<TodoListItem> {
  final todoUpdateController = TextEditingController();

  @override
  void dispose() {
    todoUpdateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      onTap: () {
        widget.todoModel.completed == false
            ? showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) {
                bool _error = false;
                todoUpdateController.text = widget.todoModel.desc;
                return StatefulBuilder(
                  builder: (context, setState) {
                    return AlertDialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      title: const Text(
                        "Update Todo",
                        style: TextStyle(fontSize: 18),
                      ),
                      content: TextFormField(
                        controller: todoUpdateController,
                        decoration: InputDecoration(
                          hintText: "Enter todo",
                          errorText: _error ? "Value cannot be empty" : null,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 12,
                          ),
                        ),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context, false);
                          },
                          child: const Text("Cancel"),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueAccent,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              _error = todoUpdateController.text.isEmpty;
                              if (!_error) {
                                context.read<TodoListBloc>().add(
                                  EditTodoEvent(
                                    todoId: widget.todoModel.id,
                                    todoDesc: todoUpdateController.text.trim(),
                                  ),
                                );

                                Navigator.pop(context);
                              }
                            });
                          },
                          child: const Text("Update"),
                        ),
                      ],
                    );
                  },
                );
              },
            )
            : ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("once you completed can not edit !")),
            );
      },
      leading: Checkbox(
        value: widget.todoModel.completed,
        onChanged: (bool? newValue) {
          context.read<TodoListBloc>().add(
            ToggleTodoEvent(todoId: widget.todoModel.id),
          );
        },
      ),
      title: Text(
        widget.todoModel.desc,
        style: TextStyle(
          fontSize: 16,
          color: widget.todoModel.completed ? Colors.grey : Colors.black87,
          decoration:
              widget.todoModel.completed
                  ? TextDecoration.lineThrough
                  : TextDecoration.none,
        ),
      ),
    );
  }
}
