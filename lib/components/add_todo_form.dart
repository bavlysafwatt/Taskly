import 'package:flutter/material.dart';
import 'package:taskly/components/custom_button.dart';
import 'package:taskly/components/custom_text_field.dart';

class TodoForm extends StatelessWidget {
  const TodoForm(
      {super.key,
      required this.onTap,
      required this.title,
      required this.buttonText,
      required this.formTitle});

  final void Function() onTap;
  final TextEditingController title;
  final String buttonText;
  final String formTitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 15),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  title.clear();
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.cancel,
                  color: Colors.grey.shade800,
                ),
              ),
              const SizedBox(width: 55),
              Text(
                formTitle,
                style: TextStyle(
                  color: Color(0xff91b9f6),
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
          const SizedBox(height: 25),
          Text(
            'Add Text',
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          CustomTextField(
            hintText: 'Enter Text',
            maxLines: 1,
            controller: title,
          ),
          const SizedBox(height: 20),
          Center(
            child: CustomButton(
              text: buttonText,
              onTap: onTap,
            ),
          ),
        ],
      ),
    );
  }
}
