import 'package:flutter/material.dart';
import 'package:note/provider/note_provider.dart';
import 'package:note/provider/todo_provider.dart';
import 'package:provider/provider.dart';

import '../../models/todo_model.dart';
import 'Todo_addBox.dart';

class TodoTile extends StatelessWidget {
  final String todoTitle;
  final bool todoCompleted;
  final dynamic onChanged;
  final TodoModel? todoModel;
  final Color color;
  const TodoTile({
    Key? key,
    required this.todoTitle,
    required this.todoCompleted,
    this.onChanged,
    this.todoModel,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer2<TodoProvider, NoteProvider>(
      builder: (context, tp, np, child) {
        return GestureDetector(
          onLongPress: () {
            tp.deleteNoteLists(todoModel!, context);
          },
          onTap: () {
            TodoProvider todoProvider =
                Provider.of<TodoProvider>(context, listen: false);
            todoProvider.controller.text = todoModel!.taskTitle!;
            showDialog(
                context: context,
                builder: (context) {
                  return TodoAddBox(
                    todoModel: todoModel,
                  );
                });
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: GestureDetector(
              child: Container(
                height: 90,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.only(
                  left: 10,
                  right: 24,
                  top: 3,
                ),
                child: Row(
                  children: [
                    Checkbox(value: todoCompleted, onChanged: onChanged),
                    Text(
                      todoTitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        decoration:
                            todoCompleted ? TextDecoration.lineThrough : null,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        todoTitle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          decoration:
                              todoCompleted ? TextDecoration.lineThrough : null,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
