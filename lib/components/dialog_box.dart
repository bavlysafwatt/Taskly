import 'package:flutter/material.dart';
import 'package:taskly/components/add_todo_form.dart';

class DialogBox extends StatelessWidget {
  const DialogBox(
      {super.key,
      required this.onTap,
      required this.title,
      required this.formTitle,
      required this.buttonText});

  final String formTitle;
  final String buttonText;
  final void Function() onTap;
  final TextEditingController title;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      elevation: 0,
      contentPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      content: SingleChildScrollView(
        child: Container(
          height: 240,
          width: 300,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
          ),
          child: TodoForm(
            onTap: onTap,
            title: title,
            buttonText: buttonText,
            formTitle: formTitle,
          ),
        ),
      ),
    );
  }
}
