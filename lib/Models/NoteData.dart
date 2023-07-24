import 'package:flutter/material.dart';
import 'package:notes/Data/DatabaseHive.dart';
import 'package:notes/Models/Note.dart';

class NoteData extends ChangeNotifier {
  final db = HiveDatabase();
  List<Note> allNotes = [

  ];
  void initializeNotes() {
    allNotes = db.loadNotes();
  }

  List<Note> getAllNotes() {
    return allNotes;
  }

  void addNewNotes(Note note) {
    allNotes.add(note);
    notifyListeners();
  }

  void updateNote(Note note, String text) {
    for (int i = 0; i < allNotes.length; i++) {
      if (allNotes[i].id == note.id) {
        allNotes[i].text = text;
      }
    }
    notifyListeners();
  }

  void deletNote(Note note) {
    allNotes.remove(note);
    notifyListeners();
  }
}
