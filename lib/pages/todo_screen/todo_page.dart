import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:note/pages/todo_screen/todo_search_page.dart';
import 'package:note/provider/note_provider.dart';
import 'package:note/provider/todo_provider.dart';
import 'package:provider/provider.dart';

import '../../utils/todo_util/todo_tile.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({Key? key}) : super(key: key);

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          TodoProvider todoProvider =
              Provider.of<TodoProvider>(context, listen: false);
          todoProvider.controller.clear();
          todoProvider.addItem(context);
        },
        child: Icon(Icons.add),
      ),
      body: SafeArea(
        child: Consumer2<TodoProvider, NoteProvider>(
          builder: (context, tp, noteProvider, child) {
            tp.loadTodoList();
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 20),
                          child: Text(
                            'To-dos',
                            style: GoogleFonts.ubuntu(
                                textStyle: TextStyle(fontSize: 30)),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return TodoSearchPage();
                            }));
                          },
                          child: Icon(
                            Icons.search_rounded,
                            size: 27,
                          ),
                        ),
                      ],
                    ),
                    tp.todoList.isNotEmpty
                        ? AnimationLimiter(
                            child: ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: tp.todoList.length,
                                itemBuilder: (context, index) {
                                  final currentTodo = tp.todoList[index];
                                  return AnimationConfiguration.staggeredList(
                                    position: index,
                                    duration: Duration(milliseconds: 345),
                                    child: SlideAnimation(
                                      verticalOffset: 50,
                                      child: FadeInAnimation(
                                        child: TodoTile(
                                          color: noteProvider.colors[index %
                                              noteProvider.colors.length],
                                          todoTitle: currentTodo.taskTitle!,
                                          todoCompleted: currentTodo.isChecked!,
                                          todoModel: currentTodo,
                                          onChanged: (value) {
                                            tp.toggleDone(index, currentTodo);
                                          },
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                          )
                        : Center(
                            child: Container(
                              padding: EdgeInsets.only(top: 320),
                              child: Text(
                                'No To-dos',
                                style: TextStyle(
                                  fontSize: 17,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
