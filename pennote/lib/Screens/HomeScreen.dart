import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pennote/Widgets/DesktopView.dart';
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

  DialogClass _dialog;
  List<Note> _notes = [];
  Size _size;
  Future<void> _future;
  bool _tabletDrawer;

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
    _tabletDrawer = false;
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
    state._size = MediaQuery.of(context).size;
    return Responsive.isDesktop(context) ? _desktop(context) :
    Responsive.isTablet(context) ?
    _mobile(context) :
    _mobile(context);
  }


  Widget _mobile(BuildContext context) {
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
                tooltip: "Create Note",
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

  Widget _tablet(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.bg,
      appBar: AppBar(
        backgroundColor: colors.bg,
      ),
      drawer: Container(
        color: colors.bg,
        child: Column(
          children: [
            TopBar(),
            ButtonView(
              onPressed: () {
                state.createNote();
              },
              borderRadius: 5.0,
              widthType: Width.stretch,
              color: colors.primary,
              padding: EdgeInsets.symmetric(vertical: 10.0),
              margin: EdgeInsets.all(20.0),
              child: TextView(
                text: "New Note",
                color: colors.bg,
                letterSpacing: 1.5,
                size: 20.0,
                fontWeight: FontWeight.w600,
                align: TextAlign.center,
              ),
            ),
            Expanded(
              child: _builder(context),
            ),
          ],
        ),
      ),
      body: Container(
        color: Colors.purple,
      ),
    );
  }

  Widget _desktop(BuildContext context) {
    return DesktopView(
      builder: _builder(context),
      createNote: () {
        state.createNote();
      },
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/empty.svg',
                    width: Responsive.isDesktop(context) ? state._size.width / 5 : state._size.width / 1.5,
                    height: Responsive.isDesktop(context) ? state._size.width / 5 : state._size.width / 1.5,
                  ),
                  TextView.rich(
                    padding: EdgeInsets.only(top: 20.0, left: 10.0, right: 10.0),
                    align: TextAlign.center,
                    textSpan: [
                      TextView(
                        text: "No Notes? ",
                        color: colors.grey,
                        letterSpacing: 1.5,
                        size: Responsive.isTablet(context) ? 25.0 : 18.0,
                        fontWeight: FontWeight.w400,
                      ),
                      TextView(
                        text: "Create a new note ",
                        color: colors.primary,
                        letterSpacing: 1.5,
                        size: Responsive.isTablet(context) ? 25.0 : 18.0,
                        fontWeight: FontWeight.w400,
                      ),
                      TextView(
                        text: "by pressing the button below",
                        color: colors.grey,
                        letterSpacing: 1.5,
                        size: Responsive.isTablet(context) ? 25.0 : 18.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ],
                  ),
                ],
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