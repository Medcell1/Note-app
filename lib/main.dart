import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:note/models/note_model.dart';
import 'package:note/models/todo_model.dart';
import 'package:note/provider/note_provider.dart';
import 'package:note/provider/todo_provider.dart';
import 'package:note/utils/note_utils/g_bottom.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

List<Box> boxList = [];
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// init hive db...
  Directory directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  var habitDb = await Hive.openBox('Habit_Database');
  var todoDb = await Hive.openBox('Todo_Database');
  boxList.add(habitDb);
  boxList.add(todoDb);
  // Hive.registerAdapter(NoteModelAdapter());
  Hive.registerAdapter(NoteModelAdapter());
  Hive.registerAdapter(TodoModelAdapter());
  await Hive.openBox<NoteModel>('noteBox');
  await Hive.openBox<TodoModel>('todoBox');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NoteProvider()),
        ChangeNotifierProvider(create: (_) => TodoProvider()),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.purple,
          ),
          home: GBottom()),
    );
  }
}
