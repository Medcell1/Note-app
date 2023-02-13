import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../models/note_model.dart';
import '../pages/note-screen/input_note_page.dart';
import '../utils/note_utils/boxes.dart';
import '../utils/note_utils/delete_box.dart';

class NoteProvider extends ChangeNotifier {
  List<NoteModel> noteList = [];
  List<Color> colors = [
    Color(0xFFFFB7F4),
    Color(0xFFCA5FDA),
    Color(0xFFFDC8BA),
    Color(0xFF00CED1),
    Color(0xFFADD8E6),
    Color(0xFFA5DFBC),
    Color(0xFFFFC0CB),
    Color(0xFFDEBE5C),
    Color(0xFF90BF84),
    Color(0xFFFFFF00),
    Color(0XFF8FC0C8),
  ];
  final TextEditingController contentController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  List<NoteModel> foundNotes = [];

  filterNotes(
    String enteredNote,
  ) {
    List<NoteModel> results = [];
    if (enteredNote.isEmpty) {
      results = noteList;
    } else {
      results = noteList
          .where(
            (element) =>
                element.content!.toString().toLowerCase().contains(
                      enteredNote.toLowerCase(),
                    ) ||
                element.title!.toString().toLowerCase().contains(
                      enteredNote.toLowerCase(),
                    ),
          )
          .toList();
    }

    foundNotes = results;
    notifyListeners();
  }

  inputNew(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return InputNotePage();
        });
    notifyListeners();
  }

  void loadNotesList() {
    noteList = Boxes.getNotesLists().values.toList();
  }

  addNewNote(BuildContext context, DateTime? dateTime) {
    if (titleController.text.isNotEmpty || contentController.text.isNotEmpty) {
      NoteModel note = NoteModel(
        title: titleController.text,
        content: contentController.text,
        dateTime: dateTime,
      );

      final noteBox = Boxes.getNotesLists();
      noteBox.add(note);
      contentController.clear();
      titleController.clear();
      notifyListeners();
      Navigator.pop(context);
      // food.save();
      print('${contentController.text} added Successfully');
    }
  }

  editNoteLists(NoteModel oldNote, BuildContext context) {
    if (titleController.text.isNotEmpty || contentController.text.isNotEmpty) {
      NoteModel newNote = oldNote
        ..title = titleController.text
        ..content = contentController.text;

      newNote.save();
      Navigator.pop(context);
      notifyListeners();
    }
  }

  deleteNoteLists(NoteModel note, BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (ctx) => NoteDeleteBox(onPressed: () {
        Navigator.pop(context);
        note.delete();
        notifyListeners();
      }),
    );
    // }
  }
}
