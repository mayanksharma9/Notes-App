import 'package:flutter/material.dart';
import 'package:notes/Models/Note.dart';

class NoteData extends ChangeNotifier {
  List<Note> allNotes = [
    Note(id: 0, text: 'First Note'),
    Note(id: 1, text: 'Second Note'),
    Note(id: 02, text: 'Third Note'),
  ];

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
