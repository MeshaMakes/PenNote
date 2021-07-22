import 'package:flutter/material.dart';
import 'package:pennote/Screens/EditScreen.dart';
import 'package:pennote/Utils/NoteModel.dart';
import 'package:pennote/Widgets/TopBar.dart';
import 'package:sad_lib/CustomWidgets.dart';
import '../Utils/Colors.dart' as colors;

class DesktopView extends StatefulWidget {
  final Widget builder;
  final void Function() createNote;
  final Note note;
  const DesktopView({Key key, this.builder, this.createNote, this.note}) : super(key: key);

  @override
  _DesktopViewState createState() => _DesktopViewState();
}

class _DesktopViewState extends State<DesktopView> {
  Size _size;


  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;
    return Material(
      color: colors.bg,
      child: SafeArea(
        child: IndexedStack(
          children: [
            _drawer(context),
            EditScreen(note: widget.note),
          ],
        ),
      ),
    );
  }

  Widget _drawer(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: _size.width / 4.5,
      ),
      color: colors.bg,
      child: Column(
        children: [
          TopBar(),
          ButtonView(
            onPressed: () {
              widget.createNote();
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
            child: widget.builder,
          ),
        ],
      ),
    );
  }
}
