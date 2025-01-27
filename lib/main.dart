import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:taskly/cubits/cubit/todo_cubit.dart';
import 'package:taskly/models/to_do_model.dart';
import 'package:taskly/pages/home_page.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(ToDoModelAdapter());
  await Hive.openBox("toDoBox");
  runApp(const Taskly());
}

class Taskly extends StatelessWidget {
  const Taskly({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TodoCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: "SpaceGrotesk",
        ),
        home: Scaffold(
          body: HomePage(),
        ),
      ),
    );
  }
}
