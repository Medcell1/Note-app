import 'package:hive/hive.dart';
import 'package:note/models/note_model.dart';

import '../../models/todo_model.dart';

class Boxes {
  static Box<NoteModel> getNotesLists() => Hive.box<NoteModel>('noteBox');
  static Box<TodoModel> getTodoLists() => Hive.box<TodoModel>('todoBox');
}
