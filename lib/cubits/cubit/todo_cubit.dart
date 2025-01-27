// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';
import 'package:taskly/models/to_do_model.dart';

part 'todo_state.dart';

class TodoCubit extends Cubit<TodoState> {
  TodoCubit() : super(TodoInitial());

  List toDoList = [];
  final box = Hive.box('toDoBox');

  void loadData() {
    if (box.get("toDoList") == null) {
      toDoList = [];
    } else {
      toDoList = box.get("toDoList");
    }
    emit(TodoRefresh());
  }

  void updateData() {
    box.put("toDoList", toDoList);
  }

  void checkBoxChanged(bool? value, int index) {
    toDoList[index].isCompleted = !toDoList[index].isCompleted;
    emit(TodoRefresh());
    updateData();
  }

  void updateTask(String value, int index) {
    toDoList[index].name = value;
    emit(TodoRefresh());
    updateData();
  }

  void saveNewTask(ToDoModel todoModel) {
    toDoList.add(todoModel);
    emit(TodoRefresh());
    updateData();
  }

  void deleteTask(int index) {
    toDoList.removeAt(index);
    emit(TodoRefresh());
    updateData();
  }
}
