import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskly/components/dialog_box.dart';
import 'package:taskly/components/goals_welcome_card.dart';
import 'package:taskly/components/task_card.dart';
import 'package:taskly/cubits/cubit/todo_cubit.dart';
import 'package:taskly/models/to_do_model.dart';

class GoalsPage extends StatefulWidget {
  const GoalsPage({super.key});

  @override
  State<GoalsPage> createState() => _GoalsPageState();
}

class _GoalsPageState extends State<GoalsPage> {
  TextEditingController taskName = TextEditingController();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<TodoCubit>(context).loadGoals();
  }

  void saveNewGoal() {
    if (taskName.text.isNotEmpty) {
      ToDoModel todoModel = ToDoModel(name: taskName.text, isCompleted: false);
      BlocProvider.of<TodoCubit>(context).saveNewGoal(todoModel);
      Navigator.pop(context);
      taskName.clear();
    }
  }

  void editGoal(int index) {
    if (taskName.text.isNotEmpty) {
      BlocProvider.of<TodoCubit>(context).updateGoal(taskName.text, index);
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
                  GoalsWelcomeCard(),
                  SizedBox(height: 20),
                  Text(
                    "You have ${BlocProvider.of<TodoCubit>(context).goalsList.length} goals right now",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Expanded(
                    child: ListView.builder(
                      itemCount:
                          BlocProvider.of<TodoCubit>(context).goalsList.length,
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: TaskCard(
                          toDoModel: BlocProvider.of<TodoCubit>(context)
                              .goalsList[index],
                          onChanged: (value) =>
                              BlocProvider.of<TodoCubit>(context)
                                  .checkGoalBoxChanged(value, index),
                          onPressed: (context) =>
                              BlocProvider.of<TodoCubit>(context)
                                  .deleteGoal(index),
                          onEdit: (context) {
                            taskName = TextEditingController(
                                text: BlocProvider.of<TodoCubit>(context)
                                    .goalsList[index]
                                    .name);
                            showDialog(
                              context: context,
                              builder: (context) => DialogBox(
                                formTitle: "Edit Specific Goal",
                                buttonText: "Edit",
                                onTap: () => editGoal(index),
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
              onTap: saveNewGoal,
              title: taskName,
              formTitle: "Add New Goal",
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
