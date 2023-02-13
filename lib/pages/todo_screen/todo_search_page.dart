import 'package:flutter/material.dart';
import 'package:note/provider/note_provider.dart';
import 'package:note/provider/todo_provider.dart';
import 'package:provider/provider.dart';

import '../../utils/todo_util/todo_tile.dart';

class TodoSearchPage extends StatelessWidget {
  const TodoSearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TodoProvider todoProvider =
        Provider.of<TodoProvider>(context, listen: false);
    todoProvider.foundTodos = todoProvider.todoList;
    return Scaffold(
      body: SafeArea(child: SingleChildScrollView(
        child: Consumer2<TodoProvider, NoteProvider>(
          builder: (context, tp, np, child) {
            return Column(
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back,
                        size: 30,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: 280,
                      child: TextField(
                        style: TextStyle(
                          fontSize: 17,
                        ),
                        onChanged: (value) {
                          tp.filterTodos(value);
                        },
                        decoration: InputDecoration(
                          hintText: 'Search For Notes',
                        ),
                      ),
                    ),
                  ],
                ),
                tp.foundTodos.isNotEmpty
                    ? ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: tp.foundTodos.length,
                        itemBuilder: (context, index) {
                          final currentTodo = tp.foundTodos[index];
                          return TodoTile(
                            color: np.colors[index % np.colors.length],
                            todoTitle: currentTodo.taskTitle!,
                            todoCompleted: currentTodo.isChecked!,
                            todoModel: currentTodo,
                            onChanged: (value) {
                              tp.toggleDone(index, currentTodo);
                            },
                          );
                        })
                    : Container(
                        padding: EdgeInsets.only(top: 350),
                        child: Text(
                          'No To-do found',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
              ],
            );
          },
        ),
      )),
    );
  }
}
