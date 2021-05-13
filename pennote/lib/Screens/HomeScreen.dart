import 'package:flutter/material.dart';
import 'package:sad_lib/CustomWidgets.dart';
import 'package:sad_lib/StorageClass/StorageClass.dart';
import '../Utils/NoteModel.dart';
import '../Screens/EditScreen.dart';
import '../Widgets/NoteTile.dart';
import '../Widgets/TopBar.dart';
import '../Utils/Responsive.dart';
import '../Widgets/Dialog.dart';
import '../Utils/Colors.dart' as colors;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenController createState() => _HomeScreenController();
}

class _HomeScreenController extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) => _HomeScreenView(this);

  //TODO: add empty state art

  DialogClass _dialog;
  List<Note> _notes = [];
  Size _size;
  Future<void> _future;

  void createNote() {
    Note note = Note();
    _dialog.showInputDialog(context, title: "Give your note a name", hint: "Enter a name", positiveBtn: "Create", dismissible: true).then((title) {
      if(title != null) {
        setState(() {
          note.title = title;
        });
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => EditScreen(note: note,)));
      }
    });
  }

  void editNote(int i) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => EditScreen(note: _notes[i])));
  }

  @override
  void initState() {
    _future = fetchNotes();
    _dialog = DialogClass();
    super.initState();
  }

  Future<List<Note>> fetchNotes() async {
    _notes.clear();
    StorageClass().readFromMap("Notes.pn").then((notes) {
      notes.forEach((key, value) {
        Note note = Note.fromStorage(data: value);
        setState(() {
         _notes.add(note);
        });
      });
    });
    return _notes;
  }
}

class _HomeScreenView extends StatelessWidget {
  final _HomeScreenController state;
  _HomeScreenView(this.state) : super();

  @override
  Widget build(BuildContext context) {
    return Responsive.isDesktop(context) ? _desktop() : Responsive.isTablet(context) ? _tablet() : _mobile(context);
  }


  Widget _mobile(BuildContext context) {
  state._size = MediaQuery.of(context).size;
    return Material(
      color: colors.bg,
      child: SafeArea(
        child: Stack(
          alignment: Alignment.bottomRight,
          children: [
            Column(
              children: [
                TopBar(),
                Expanded(
                  child: _builder(context),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(right: 20.0, bottom: 20.0),
              child: FloatingActionButton(
                onPressed: () {
                  state.createNote();
                },
                backgroundColor: colors.primary.withOpacity(0.80),
                splashColor: colors.primary,
                child: Icon(Icons.add, color: colors.bg, size: 30.0,),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _tablet() {
    return Container(
      color: Colors.blue,
    );
  }

  Widget _desktop() {
    return Container(
      color: Colors.red,
    );
  }

  Widget _builder(BuildContext context) {
    return FutureBuilder(
      future: state._future,
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.done) {
          if(snapshot.hasData && state._notes.isNotEmpty) {
            return RefreshIndicator(
              onRefresh: state.fetchNotes,
              backgroundColor: Colors.black45,
              child: SingleChildScrollView(
                padding: EdgeInsets.all(20.0),
                physics: AlwaysScrollableScrollPhysics(),
                child: Container(
                  height: state._size.height,
                  child: Column(
                    children: [
                      for(int i = 0; i < state._notes.length; i++)
                        NoteTile(
                          onPressed: () {
                            state.editNote(i);
                          },
                          note: state._notes[i],
                        ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return Center(
              child: Container(
                child: TextView(
                  text: "No Notes, add new",
                  color: colors.primary,
                  size: 30.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            );
          }
        } else {
          return Center(
            child: CustomLoader(color1: colors.primary, color2: Colors.transparent),
          );
        }
      },
    );
  }
}