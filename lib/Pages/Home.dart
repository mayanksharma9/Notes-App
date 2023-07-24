import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes/Models/Note.dart';
import 'package:notes/Models/NoteData.dart';
import 'package:provider/provider.dart';

import 'EditNotePage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void initstate() {
    super.initState();
    Provider.of<NoteData>(context, listen: false).initializeNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NoteData>(
        builder: (context, value, child) => Scaffold(
              backgroundColor: CupertinoColors.systemGroupedBackground,
              floatingActionButton: FloatingActionButton(
                  onPressed: creteNewNote,
                  elevation: 0,
                  backgroundColor: Colors.grey[300],
                  child: const Icon(Icons.add, color: Colors.white)),
              appBar: AppBar(),
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(25.0),
                    child: Text(
                      "Notes",
                      style:
                          TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                    ),
                  ),
                  value.getAllNotes().length ==0 ? const Padding(
                    padding: EdgeInsets.only(top : 50.0),
                    child: Center(child: Text('Nothing here', style: TextStyle(color: Colors.grey),)),
                  ) :
                  CupertinoListSection.insetGrouped(
                      children: List.generate(
                          value.getAllNotes().length,
                          (index) => CupertinoListTile(
                              title: Text(value.getAllNotes()[index].text),
                              onTap: () => goToNotePage(
                                  value.getAllNotes()[index], false),
                                  trailing: IconButton(icon: Icon(Icons.delete),
                                  onPressed: () => deleteNote(value.getAllNotes()[index],),)))),
                ],
              ),
            ));
  }

  void creteNewNote() {
    int id = Provider.of<NoteData>(context, listen: false).getAllNotes().length;
    Note newNote = Note(
      id: id,
      text: '',
    );
    goToNotePage(newNote, true);
  }

  void goToNotePage(Note note, bool isNewNote) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EditNotePage(note: note, isNewNote: isNewNote),
        ));
  }

  void deleteNote(Note note) {
    Provider.of<NoteData>(context, listen: false).deletNote(note);
  }
}
