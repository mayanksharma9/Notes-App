import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:notes/Models/NoteData.dart';
import 'package:provider/provider.dart';

import '../Models/Note.dart';

class EditNotePage extends StatefulWidget {
  Note note;
  bool isNewNote;
  EditNotePage({
    Key? key,
    required Note note,
    required bool isNewNote,
  });
  @override
  State<EditNotePage> createState() => _EditNotePageState();
}

class _EditNotePageState extends State<EditNotePage> {
  QuillController _controller = QuillController.basic();

  void initState() {
    super.initState();
    loadExistingNote();
  }

  void loadExistingNote() {
    final doc = Document()..insert(0, widget.note.text);
    setState(() {
      _controller = QuillController(
        document: doc,
        selection: const TextSelection.collapsed(offset: 0),
      );
    });
  }

  void addNewNote(int id) {
    String text = _controller.document.toPlainText();
    Provider.of<NoteData>(context, listen: false).addNewNotes(
      Note(id: id, text: text),
    );
  }

  void updateNote() {
    String text = _controller.document.toPlainText();
    Provider.of<NoteData>(context, listen: false).updateNote(widget.note, text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.arrow_back_ios_new), 
        onPressed: () {
          if (widget.isNewNote && !_controller.document.isEmpty()) {
            addNewNote(Provider.of<NoteData>(context,listen: false).getAllNotes()
            .length);
            
          };
        },
        color: Colors.black,),
      ),
      body: Column(
        children: [
          QuillToolbar.basic(controller: _controller,
          showAlignmentButtons: false),
          Expanded(child: 
          Container(
            padding: const EdgeInsets.all(25.0),
            child: QuillEditor.basic(controller: _controller, readOnly: false),
          ),)
        ],
      ),
    );
  }
}
