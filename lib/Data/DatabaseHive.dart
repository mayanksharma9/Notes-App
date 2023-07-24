import 'package:hive/hive.dart';
import 'package:notes/Models/Note.dart';

class HiveDatabase {
  final myBox = Hive.box("Note_Database");

  List<Note> loadNotes() {
    List<Note> savedNotesFormatted = [];

    if (myBox.get('All_Notes') != null) {
      List<dynamic> savedNotes = myBox.get('All_Notes');
      for (int i = 0; i < savedNotes.length; i++) {
        Note individualNote =
            Note(id: savedNotes[i][0], text: savedNotes[i][1]);

        savedNotesFormatted.add(individualNote);
      }
    } else {
      savedNotesFormatted.add(Note(id: 0, text: 'Fist Note'));
    }
    return savedNotesFormatted;
  }

  void savedNotes(List<Note> allNotes) {
    List<List<dynamic>> allNotesFormatted = [];

    for (var note in allNotes) {
      int id = note.id;
      String text = note.text;
      allNotesFormatted.add([id, text]);
    }
    myBox.put('ALL_NOTES', allNotesFormatted);
  }
}
