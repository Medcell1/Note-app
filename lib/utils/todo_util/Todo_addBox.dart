import 'package:flutter/material.dart';
import 'package:note/provider/note_provider.dart';
import 'package:note/provider/todo_provider.dart';
import 'package:provider/provider.dart';

import '../../models/todo_model.dart';

class TodoAddBox extends StatelessWidget {
  final TodoModel? todoModel;
  final dynamic index;
  const TodoAddBox({Key? key, this.todoModel, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer2<TodoProvider, NoteProvider>(
      builder: (context, tp, np, child) {
        return AlertDialog(
          title: Text('To-do'),
          content: TextField(
            controller: tp.controller,
            maxLines: 2,
            decoration: InputDecoration(
              hintText: 'Add a To-do item',
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            MaterialButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            MaterialButton(
              onPressed: () {
                if (todoModel != null && tp.controller.text.isNotEmpty) {
                  tp.editTodoItem(todoModel!, context);
                } else {
                  tp.addNewTodoItem(context);
                }
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
