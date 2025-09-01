import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

// Create Enum For Filters
enum TodoFilter { all, active, completed }

// UUID instance make for use

Uuid uuid = Uuid();

class TodoModel extends Equatable {
  final String id;
  final String desc;
  final bool completed;

  TodoModel({String? id, required this.desc, this.completed = false})
    : this.id = id ?? uuid.v4();

  @override
  String toString() {
    return 'TodoModel{id: $id, desc: $desc, completed: $completed}';
  }

  @override
  List<Object> get props => [id, desc, completed];
}
