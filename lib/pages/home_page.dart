import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskly/components/dialog_box.dart';
import 'package:taskly/components/task_card.dart';
import 'package:taskly/components/welcome_card.dart';
import 'package:taskly/cubits/cubit/todo_cubit.dart';
import 'package:taskly/models/to_do_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController taskName = TextEditingController();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<TodoCubit>(context).loadData();
  }

  void saveNewTask() {
    if (taskName.text.isNotEmpty) {
      ToDoModel todoModel = ToDoModel(name: taskName.text, isCompleted: false);
      BlocProvider.of<TodoCubit>(context).saveNewTask(todoModel);
      Navigator.pop(context);
      taskName.clear();
    }
  }

  void editTask(int index) {
    if (taskName.text.isNotEmpty) {
      BlocProvider.of<TodoCubit>(context).updateTask(taskName.text, index);
      Navigator.pop(context);
      taskName.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff5f8fd),
      body: BlocBuilder<TodoCubit, TodoState>(
        builder: (context, state) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  WelcomeCard(),
                  SizedBox(height: 20),
                  Text(
                    "You have ${BlocProvider.of<TodoCubit>(context).toDoList.length} tasks for today",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Expanded(
                    child: ListView.builder(
                      itemCount:
                          BlocProvider.of<TodoCubit>(context).toDoList.length,
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: TaskCard(
                          toDoModel: BlocProvider.of<TodoCubit>(context)
                              .toDoList[index],
                          onChanged: (value) =>
                              BlocProvider.of<TodoCubit>(context)
                                  .checkBoxChanged(value, index),
                          onPressed: (context) =>
                              BlocProvider.of<TodoCubit>(context)
                                  .deleteTask(index),
                          onEdit: (context) {
                            taskName = TextEditingController(
                                text: BlocProvider.of<TodoCubit>(context)
                                    .toDoList[index]
                                    .name);
                            showDialog(
                              context: context,
                              builder: (context) => DialogBox(
                                formTitle: "Edit Specific Task",
                                buttonText: "Edit",
                                onTap: () => editTask(index),
                                title: taskName,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => DialogBox(
              onTap: saveNewTask,
              title: taskName,
              formTitle: "Add New Task",
              buttonText: "Add",
            ),
          );
        },
        backgroundColor: Color(0xff91b9f6),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
