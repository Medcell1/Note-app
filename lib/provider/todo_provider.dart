import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:note/models/todo_model.dart';
import 'package:note/utils/note_utils/boxes.dart';

import '../utils/todo_util/Todo_addBox.dart';
import '../utils/todo_util/todo_delete_box.dart';

class TodoProvider extends ChangeNotifier {
  TextEditingController controller = TextEditingController();
  bool isChecked = false;

  // checkBoxTapped(bool value , ) {
  //   todoList[index].isChecked = value;
  //   notifyListeners();
  // }

  toggleDone(int index, TodoModel todoModel) {
    final newTodo = todoModel..isChecked = !todoModel.isChecked!;

    newTodo.save();
    print("${todoModel.taskTitle} is Changed successfully");

    loadTodoList();
    notifyListeners();
  }

  List<TodoModel> todoList = [];
  void loadTodoList() {
    todoList = Boxes.getTodoLists().values.toList();
    for (TodoModel todo in todoList) {
      print(todo.toJson());
    }
    print("==================");
  }

  addItem(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return TodoAddBox();
      },
    );
    notifyListeners();
  }

  editTodoItem(TodoModel oldTodoItem, BuildContext context) {
    TodoModel newTodoItem = oldTodoItem..taskTitle = controller.text;
    newTodoItem.save();
    Navigator.pop(context);
    notifyListeners();
  }

  deleteNoteLists(TodoModel todo, BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (ctx) => TodoDeleteBox(onPressed: () {
        Navigator.pop(context);
        todo.delete();
        notifyListeners();
      }),
    );
    // }
  }

  addNewTodoItem(BuildContext context) {
    if (controller.text.isNotEmpty) {
      TodoModel todoModel = TodoModel(
        taskTitle: controller.text,
        isChecked: false,
      );
      controller.clear();
      final todoBox = Boxes.getTodoLists();
      todoBox.add(todoModel);
      Navigator.pop(context);
    }
    notifyListeners();
  }

  List<TodoModel> foundTodos = [];
  filterTodos(String enteredTodo) {
    List<TodoModel> results = [];
    if (enteredTodo.isEmpty) {
      results = todoList;
    } else {
      results = foundTodos
          .where((element) => element.taskTitle!
              .toString()
              .toLowerCase()
              .contains(enteredTodo.toLowerCase()))
          .toList();
    }
    foundTodos = results;
    notifyListeners();
  }
}
