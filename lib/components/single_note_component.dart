import 'package:elo_notes_app/models/notes.dart';
import 'package:elo_notes_app/screens/note_screen.dart';
import 'package:elo_notes_app/utils/size_config.dart';
import 'package:elo_notes_app/utils/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

List<Color> colorList = [
  Colors.blue,
  Colors.green,
  Colors.indigo,
  Colors.red,
  Colors.cyan,
  Colors.teal,
  Colors.amber.shade900,
  Colors.deepOrange
];

class SingleNoteComponent extends StatelessWidget {
  const SingleNoteComponent({
    this.noteData,
    this.onTapAction,
    Key key,
  }) : super(key: key);

  final NotesModel noteData;
  final Function(NotesModel noteData) onTapAction;

  @override
  Widget build(BuildContext context) {
    String neatDate = DateFormat.yMd().add_jm().format(noteData.date);
    // Color color = colorList.elementAt(noteData.title.length % colorList.length);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () => onTapAction(noteData),
        child: Material(
          elevation: 10,
          borderRadius: BorderRadius.circular(15),
          child: Container(
            padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 3.7),
            // height: 50,
            decoration: BoxDecoration(
              color: whiteColor,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      '${noteData.title.trim().length <= 20 ? noteData.title.trim() : noteData.title.trim().substring(0, 20) + '...'}',
                      style: TextStyle(
                          color: primaryColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                    Text(
                      '$neatDate',
                      style: TextStyle(
                        color: primaryColor,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: SizeConfig.blockSizeVertical * 2,
                ),
                Text(
                    '${noteData.content.trim().split('\n').first.length <= 30 ? noteData.content.trim().split('\n').first : noteData.content.trim().split('\n').first.substring(0, 30) + '...'}'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
