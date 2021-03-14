import 'package:elo_notes_app/models/notes.dart';
import 'package:elo_notes_app/screens/edit_note_screen.dart';
import 'package:elo_notes_app/services/database.dart';
import 'package:elo_notes_app/utils/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NoteScreen extends StatefulWidget {
  Function() triggerRefetch;
  NotesModel currentNote;
  NoteScreen({Key key, Function() triggerRefetch, NotesModel currentNote})
      : super(key: key) {
    this.triggerRefetch = triggerRefetch;
    this.currentNote = currentNote;
  }

  @override
  _NoteScreenState createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainBackColor,
      floatingActionButton: FloatingActionButton(
        backgroundColor: buttonColor,
        onPressed: handleEdit,
        child: Icon(Icons.edit),
      ),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: secondaryColor,
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context)),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.delete), onPressed: handleDelete),
        ],
        title: Text(widget.currentNote.title),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: 10.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Uncategorized'),
                Text(
                  DateFormat.yMd().add_jm().format(widget.currentNote.date),
                ),
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              widget.currentNote.content,
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16.0),
            )
          ],
        ),
      ),
    );
  }

  void handleEdit() {
    Navigator.pop(context);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => EditNoteScreen(
                  existingNote: widget.currentNote,
                  triggerRefetch: widget.triggerRefetch,
                )));
  }

  void handleDelete() async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            title: Text('Delete Note'),
            content: Text('This note will be deleted permanently'),
            actions: <Widget>[
              FlatButton(
                child: Text('DELETE',
                    style: TextStyle(
                        color: Colors.red.shade300,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1)),
                onPressed: () async {
                  await NotesDatabaseService.db
                      .deleteNoteInDB(widget.currentNote);
                  widget.triggerRefetch();
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
              ),
              FlatButton(
                child: Text('CANCEL',
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1)),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          );
        });
  }

  void onDelete() {}
}
