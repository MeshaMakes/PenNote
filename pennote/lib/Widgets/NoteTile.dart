import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sad_lib/CustomWidgets.dart';
import '../Utils/Colors.dart' as colors;
import '../Utils/responsive.dart';

class NoteTile extends StatefulWidget {
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
      onPressed: () {},
      color: Colors.transparent,
      splashColor: Colors.black87.withOpacity(0.50),
      padding: EdgeInsets.all(10.0),
      margin: EdgeInsets.only(bottom: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextView(
            text: "Shopping List",
            color: colors.white,
            letterSpacing: 1.5,
            size: Responsive.isDesktop(context) || Responsive.isTablet(context) ? 20.0 : 18.0,
            fontWeight: FontWeight.w500,
            padding: EdgeInsets.only(bottom: 15.0),
          ),
          TextView(
            text: "Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint",
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