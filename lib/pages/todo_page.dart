import 'package:flutter/material.dart';

class TodoPage extends StatelessWidget {
  const TodoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        title: Text("My Todos"),
      ),
      body: Center(
        child: Text("Todo List Here ...."),
      ),
    ));
  }
}
