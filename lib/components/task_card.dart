import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:msh_checkbox/msh_checkbox.dart';
import 'package:taskly/models/to_do_model.dart';

class TaskCard extends StatelessWidget {
  final ToDoModel toDoModel;
  final void Function(bool) onChanged;
  final void Function(BuildContext)? onPressed;
  final void Function(BuildContext)? onEdit;

  const TaskCard(
      {super.key,
      required this.toDoModel,
      required this.onChanged,
      this.onPressed,
      this.onEdit});

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: ScrollMotion(),
        children: [
          CustomSlidableAction(
            onPressed: onEdit,
            backgroundColor: Colors.grey.shade600,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12), bottomLeft: Radius.circular(12)),
            child: Icon(
              FontAwesomeIcons.pen,
              size: 15,
            ),
          ),
          CustomSlidableAction(
            onPressed: onPressed,
            backgroundColor: Colors.redAccent,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(12),
                bottomRight: Radius.circular(12)),
            child: Icon(
              FontAwesomeIcons.trash,
              size: 15,
            ),
          ),
        ],
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            MSHCheckbox(
              size: 25,
              value: toDoModel.isCompleted,
              colorConfig: MSHColorConfig.fromCheckedUncheckedDisabled(
                checkedColor: Color(0xff91b9f6),
              ),
              onChanged: onChanged,
              duration: Duration(milliseconds: 500),
            ),
            SizedBox(width: 15),
            Expanded(
              child: Wrap(
                children: [
                  Text(
                    toDoModel.name,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      decoration: toDoModel.isCompleted
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                      decorationThickness: 1.5,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 10),
            Icon(
              Icons.arrow_back_ios,
              size: 18,
              color: toDoModel.isCompleted ? Color(0xff91b9f6) : Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
