import 'package:flutter/material.dart';
import 'package:pennote/Utils/NoteModel.dart';
import '../Screens/EditScreen.dart';
import 'package:sad_lib/CustomWidgets.dart';
import '../Utils/Colors.dart' as colors;
import '../Utils/Responsive.dart';

class NoteTile extends StatefulWidget {
  final void Function() onPressed;
  final Note note;
  const NoteTile({Key key, this.onPressed, this.note}) : super(key: key);
  @override
  _NoteTileController createState() => _NoteTileController();
}

class _NoteTileController extends State<NoteTile> {
  @override
  Widget build(BuildContext context) => _NoteTileView(this);
}

class _NoteTileView extends StatelessWidget {
    final _NoteTileController state;
  _NoteTileView(this.state) : super();

@override
  Widget build(BuildContext context) {
    return ButtonView(
      onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => EditScreen()));
      },
      color: Colors.transparent,
      splashColor: Colors.black87.withOpacity(0.50),
      padding: EdgeInsets.all(10.0),
      margin: EdgeInsets.only(bottom: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextView(
            text: state.widget.note.title,
            color: colors.white,
            letterSpacing: 1.5,
            size: Responsive.isDesktop(context) || Responsive.isTablet(context) ? 20.0 : 18.0,
            fontWeight: FontWeight.w500,
            padding: EdgeInsets.only(bottom: 15.0),
          ),
          TextView(
            text: state.widget.note.noteTxt,
            color: colors.white,
            letterSpacing: 1.5,
            maxLines: 2,
            textOverflow: TextOverflow.ellipsis,
            size: Responsive.isDesktop(context) || Responsive.isTablet(context) ? 15.0 : 12.0,
            fontWeight: FontWeight.w400,
          ),
        ],
      ),
    );
  }
}