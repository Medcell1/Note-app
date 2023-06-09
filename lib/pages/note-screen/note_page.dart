import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:note/pages/note-screen/note_search_page.dart';
import 'package:note/provider/note_provider.dart';
import 'package:provider/provider.dart';

import '../../utils/note_utils/note_tile.dart';

class NotePage extends StatefulWidget {
  const NotePage({Key? key}) : super(key: key);

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Consumer<NoteProvider>(
        builder: (context, np, child) {
          return FloatingActionButton(
            onPressed: () {
              NoteProvider noteProvider =
                  Provider.of<NoteProvider>(context, listen: false);
              noteProvider.titleController.clear();
              noteProvider.contentController.clear();
              noteProvider.inputNew(context);
            },
            child: Icon(Icons.add),
          );
        },
      ),
      body: SafeArea(
        child: Consumer<NoteProvider>(
          builder: (context, np, child) {
            np.loadNotesList();
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                            'Notes',
                            style: GoogleFonts.ubuntu(
                                textStyle: TextStyle(fontSize: 30)),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SearchPage()));
                          },
                          child: Icon(
                            Icons.search_rounded,
                            size: 27,
                          ),
                        ),
                      ],
                    ),
                    np.noteList.isNotEmpty
                        ? AnimationLimiter(
                            child: ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                final currentNote = np.noteList[index];
                                return AnimationConfiguration.staggeredList(
                                  position: index,
                                  duration: Duration(milliseconds: 345),
                                  child: SlideAnimation(
                                    verticalOffset: 50,
                                    child: FadeInAnimation(
                                      child: NoteTile(
                                          colors: np
                                              .colors[index % np.colors.length],
                                          noteModel: currentNote,
                                          titleNote: currentNote.title!,
                                          contentNote: currentNote.content!,
                                          date: currentNote.dateTime),
                                    ),
                                  ),
                                );
                              },
                              itemCount: np.noteList.length,
                            ),
                          )
                        : Center(
                            child: Container(
                              padding: EdgeInsets.only(top: 320),
                              child: Text(
                                'Put down a Note',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
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
