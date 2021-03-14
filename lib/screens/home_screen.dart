import 'package:elo_notes_app/components/single_note_component.dart';
import 'package:elo_notes_app/models/notes.dart';
import 'package:elo_notes_app/screens/edit_note_screen.dart';
import 'package:elo_notes_app/screens/note_screen.dart';
import 'package:elo_notes_app/screens/settings.dart';
import 'package:elo_notes_app/services/database.dart';
import 'package:elo_notes_app/utils/size_config.dart';
import 'package:elo_notes_app/utils/theme_data.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchController = TextEditingController();
  bool isFlagOn = false;
  bool isSearchEmpty = true;
  List<NotesModel> notesList = [];

  @override
  void initState() {
    NotesDatabaseService.db.init();
    setNotesFromDB();
    super.initState();
  }

  setNotesFromDB() async {
    print("Entered setNotes");
    var fetchedNotes = await NotesDatabaseService.db.getNotesFromDB();
    setState(() {
      notesList = fetchedNotes;
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: mainBackColor,
      floatingActionButton: FloatingActionButton(
        backgroundColor: buttonColor,
        onPressed: () => gotoEditNote(),
        child: Icon(Icons.add),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
        child: AnimatedContainer(
          padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.blockSizeHorizontal * 2),
          duration: Duration(milliseconds: 200),
          child: ListView(
            children: <Widget>[
              SizedBox(
                height: SizeConfig.blockSizeVertical * 7,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Hi there!',
                    style: headingText(),
                  ),
                ],
              ),
              SizedBox(
                height: SizeConfig.blockSizeVertical * 0.7,
              ),
              buildSearchRow(),
              SizedBox(
                height: SizeConfig.blockSizeVertical * 3,
              ),
              ...buildNoteComponentsList(),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> buildNoteComponentsList() {
    List<Widget> noteComponentsList = [];

    notesList.sort((a, b) {
      return b.date.compareTo(a.date);
    });
    if (searchController.text.isNotEmpty) {
      notesList.forEach((note) {
        if (note.title
                .toLowerCase()
                .contains(searchController.text.toLowerCase()) ||
            note.content
                .toLowerCase()
                .contains(searchController.text.toLowerCase()))
          noteComponentsList.add(SingleNoteComponent(
            noteData: note,
            onTapAction: openNoteToRead,
          ));
      });
      return noteComponentsList;
    }
    if (isFlagOn) {
      notesList.forEach((note) {
        if (note.isImportant)
          noteComponentsList.add(SingleNoteComponent(
            noteData: note,
            onTapAction: openNoteToRead,
          ));
      });
    } else {
      notesList.forEach((note) {
        noteComponentsList.add(SingleNoteComponent(
          noteData: note,
          onTapAction: openNoteToRead,
        ));
      });
    }
    return noteComponentsList;
  }

  Widget buildSearchRow() {
    return Row(
      children: <Widget>[
        Expanded(
          child: Container(
            alignment: Alignment.center,
            // margin: EdgeInsets.only(left: 8),
            padding: EdgeInsets.only(left: 16),
            height: SizeConfig.blockSizeVertical * 6,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.all(Radius.circular(16))),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: searchController,
                    maxLines: 1,
                    onChanged: (value) {
                      handleSearch(value);
                    },
                    autofocus: false,
                    keyboardType: TextInputType.text,
                    style: TextStyle(
                        fontSize: SizeConfig.blockSizeHorizontal * 3,
                        fontWeight: FontWeight.w500),
                    textInputAction: TextInputAction.search,
                    decoration: InputDecoration.collapsed(
                      hintText: 'Search',
                      hintStyle: TextStyle(
                          color: Colors.grey.shade300,
                          fontSize: SizeConfig.blockSizeHorizontal * 3,
                          fontWeight: FontWeight.w500),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(isSearchEmpty ? Icons.search : Icons.cancel,
                      color: Colors.grey.shade300),
                  onPressed: cancelSearch,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  openNoteToRead(NotesModel noteData) async {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => NoteScreen(
                triggerRefetch: refetchNotesFromDB, currentNote: noteData)));
  }

  void handleSearch(String value) {
    if (value.isNotEmpty) {
      setState(() {
        isSearchEmpty = false;
      });
    } else {
      setState(() {
        isSearchEmpty = true;
      });
    }
  }

  void cancelSearch() {
    FocusScope.of(context).requestFocus(new FocusNode());
    setState(() {
      searchController.clear();
      isSearchEmpty = true;
    });
  }

  gotoEditNote() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                EditNoteScreen(triggerRefetch: refetchNotesFromDB)));
  }

  void refetchNotesFromDB() async {
    await setNotesFromDB();
    print("Refetched notes");
  }
}
