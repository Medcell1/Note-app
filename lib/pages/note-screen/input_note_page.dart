import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:note/provider/note_provider.dart';
import 'package:provider/provider.dart';

class InputNotePage extends StatelessWidget {
  final dynamic noteModel;
  const InputNotePage({Key? key, this.noteModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final time = DateTime.now();
    return Scaffold(
      body: Consumer<NoteProvider>(
        builder: (context, np, child) {
          return SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          margin: const EdgeInsets.only(left: 20),
                          child: const Icon(
                            Icons.close,
                            size: 30,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        'Notes',
                        style: GoogleFonts.ubuntu(
                          textStyle: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Spacer(),
                      InkWell(
                        onTap: () {
                          if (noteModel != null) {
                            np.editNoteLists(noteModel, context);
                          } else {
                            np.addNewNote(
                              context,
                              DateTime.now(),
                            );
                          }
                        },
                        child: Container(
                          margin: const EdgeInsets.only(right: 20),
                          child: const Center(child: Icon(Icons.check)),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      children: [
                        TextField(
                          style:
                              const TextStyle(fontSize: 20, fontFamily: 'Roboto'),
                          keyboardType: TextInputType.visiblePassword,
                          controller: np.titleController,
                          maxLines: 2,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.only(left: 15),
                            hintText: 'Enter Titles',
                            border: InputBorder.none,
                            hintStyle: TextStyle(
                                color: Colors.black54.withOpacity(0.2),
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          formatDate(
                            time,
                            [
                              M,
                              ", ",
                              d,
                              " ",
                              yyyy,
                              " ",
                              "at",
                              " ",
                              hh,
                              ":",
                              nn,
                              " ",
                              am
                            ],
                          ),
                          style: TextStyle(color: Colors.black.withOpacity(0.5)),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextField(
                          keyboardType: TextInputType.visiblePassword,
                          style: const TextStyle(color: Colors.black45),
                          // keyboardType: TextInputType.visiblePassword,
                          minLines: 5,
                          maxLines: 350,
                          controller: np.contentController,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.only(left: 18),
                            hintText: 'Enter content',
                            border: InputBorder.none,
                            hintStyle: TextStyle(
                              color: Colors.black54.withOpacity(0.2),
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
