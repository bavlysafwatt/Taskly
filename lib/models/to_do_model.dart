import 'package:hive/hive.dart';
part 'to_do_model.g.dart';

@HiveType(typeId: 0)
class ToDoModel {
  @HiveField(0)
  String name;
  @HiveField(1)
  bool isCompleted;

  ToDoModel({required this.name, required this.isCompleted});
}
