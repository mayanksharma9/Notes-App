import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:notes/Models/NoteData.dart';
import 'package:provider/provider.dart';

import '../Models/Note.dart';

class EditNotePage extends StatefulWidget {
  Note note;
  bool isNewNote;
  EditNotePage({
    super.key,
    required this.note,
    required this.isNewNote,
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

  void addNewNote() {
    int id = Provider.of<NoteData>(context, listen: false).getAllNotes().length;
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
      backgroundColor: CupertinoColors.systemBackground,
      appBar: AppBar(
        elevation: 0,
        backgroundColor:Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            if (widget.isNewNote && !_controller.document.isEmpty()) {
              addNewNote();
            } else {
              updateNote();
            }
            Navigator.pop(context);
          },
          color: Colors.black,
        ),
      ),
      body: Column(
        children: [
          QuillToolbar.basic(
              controller: _controller, showAlignmentButtons: false,
              showBackgroundColorButton: false,
              showCenterAlignment: false,
              showColorButton: false,
              showCodeBlock: false,
              showDirection: false,
              showFontFamily: false,
              showDividers: false,
              showHeaderStyle: false,
              showIndent: false,
              showSearchButton: false,
              showInlineCode: false,
              showFontSize: false,
              showClearFormat: false,
              showBoldButton: false,
              showListBullets: false,
              showItalicButton: false,
              showStrikeThrough: false,
              showUnderLineButton: false,
              showListCheck: false,
              showListNumbers: false,
              ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(25.0),
              child:
                  QuillEditor.basic(controller: _controller, readOnly: false),
            ),
          )
        ],
      ),
    );
  }
}
