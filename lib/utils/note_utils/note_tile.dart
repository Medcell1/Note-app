import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:note/pages/note-screen/input_note_page.dart';
import 'package:note/provider/note_provider.dart';
import 'package:provider/provider.dart';

import '../../models/note_model.dart';

class NoteTile extends StatelessWidget {
  final NoteModel? noteModel;
  final String titleNote;
  final DateTime? date;
  final String contentNote;
  final Color colors;

  const NoteTile({
    Key? key,
    required this.noteModel,
    required this.titleNote,
    required this.contentNote,
    required this.date,
    required this.colors,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<NoteProvider>(
      builder: (context, noteProvider, child) {
        return Padding(
          padding:
              const EdgeInsets.only(left: 16, right: 16, top: 15, bottom: 10),
          child: GestureDetector(
            onLongPress: () {
              noteProvider.deleteNoteLists(noteModel!, context);
            },
            onTap: () {
              NoteProvider noteProvider =
                  Provider.of<NoteProvider>(context, listen: false);
              noteProvider.titleController.text = noteModel!.title!;
              noteProvider.contentController.text = noteModel!.content!;
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return InputNotePage(
                      noteModel: noteModel,
                    );
                  },
                ),
              );
            },
            child: Container(
              height: 85,
              decoration: BoxDecoration(
                color: colors,
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.only(
                left: 24,
                right: 24,
                top: 11,
              ),
              child: titleNote.isNotEmpty
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          titleNote,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        contentNote.isNotEmpty
                            ? SizedBox(
                                height: 5,
                              )
                            : SizedBox(
                                height: 0,
                              ),
                        Text(
                          contentNote,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 16),
                        ),
                        contentNote.isNotEmpty
                            ? SizedBox(
                                height: 4,
                              )
                            : SizedBox(
                                height: 0,
                              ),
                        Text(
                          formatDate(
                            date!,
                            [
                              M,
                              ", ",
                              d,
                              " ",
                              yyyy,
                              " ",
                            ],
                          ),
                          style: TextStyle(fontSize: 10),
                        ),
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 9,
                        ),
                        Text(
                          contentNote,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          formatDate(
                            date!,
                            [
                              M,
                              ", ",
                              d,
                              " ",
                              yyyy,
                              " ",
                            ],
                          ),
                          style: TextStyle(fontSize: 10),
                        ),
                      ],
                    ),
            ),
          ),
        );
      },
    );
  }
}
