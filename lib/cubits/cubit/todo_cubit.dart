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
  List goalsList = [];
  final box = Hive.box('toDoBox');

  void loadData() {
    if (box.get("toDoList") == null) {
      toDoList = [];
    } else {
      toDoList = box.get("toDoList");
    }
    emit(TodoRefresh());
  }

  void loadGoals() {
    if (box.get("goalsList") == null) {
      goalsList = [];
    } else {
      goalsList = box.get("goalsList");
    }
    emit(TodoRefresh());
  }

  void updateData() {
    box.put("toDoList", toDoList);
  }

  void updateGoals() {
    box.put("goalsList", goalsList);
  }

  void checkBoxChanged(bool? value, int index) {
    toDoList[index].isCompleted = !toDoList[index].isCompleted;
    emit(TodoRefresh());
    updateData();
  }

  void checkGoalBoxChanged(bool? value, int index) {
    goalsList[index].isCompleted = !goalsList[index].isCompleted;
    emit(TodoRefresh());
    updateGoals();
  }

  void updateTask(String value, int index) {
    toDoList[index].name = value;
    emit(TodoRefresh());
    updateData();
  }

  void updateGoal(String value, int index) {
    goalsList[index].name = value;
    emit(TodoRefresh());
    updateGoals();
  }

  void saveNewTask(ToDoModel todoModel) {
    toDoList.add(todoModel);
    emit(TodoRefresh());
    updateData();
  }

  void saveNewGoal(ToDoModel todoModel) {
    goalsList.add(todoModel);
    emit(TodoRefresh());
    updateGoals();
  }

  void deleteTask(int index) {
    toDoList.removeAt(index);
    emit(TodoRefresh());
    updateData();
  }

  void deleteGoal(int index) {
    goalsList.removeAt(index);
    emit(TodoRefresh());
    updateGoals();
  }
}
