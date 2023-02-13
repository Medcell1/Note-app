import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/note_provider.dart';
import '../../utils/note_utils/note_tile.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    NoteProvider np = Provider.of<NoteProvider>(context, listen: false);
    np.foundNotes = np.noteList;
    return Scaffold(
      body: SafeArea(
        child: Consumer<NoteProvider>(
          builder: (context, np, child) {
            return SingleChildScrollView(
              child: Column(children: [
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
                      width: 280,
                      child: TextField(
                        style: TextStyle(
                          fontSize: 15,
                        ),
                        onChanged: (value) {
                          np.filterNotes(value);
                        },
                        decoration: InputDecoration(
                          hintText: 'Search For Notes',
                        ),
                      ),
                    ),
                  ],
                ),
                np.foundNotes.isNotEmpty
                    ? ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final currentNote = np.foundNotes[index];
                          return NoteTile(
                              colors: np.colors[index % np.colors.length],
                              noteModel: currentNote,
                              titleNote: currentNote.title!,
                              contentNote: currentNote.content!,
                              date: currentNote.dateTime);
                        },
                        itemCount: np.foundNotes.length,
                      )
                    : Container(
                        padding: EdgeInsets.only(top: 350),
                        child: Text(
                          'No Notes found',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
              ]),
            );
          },
        ),
      ),
    );
  }
}
