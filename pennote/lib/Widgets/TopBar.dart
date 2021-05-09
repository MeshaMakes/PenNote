import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../Screens/SettingsScreen.dart';
import 'package:sad_lib/CustomWidgets.dart';
import '../Utils/Colors.dart' as colors;
import '../Utils/Responsive.dart';

class TopBar extends StatefulWidget {
  @override
  _TopBarController createState() => _TopBarController();
}

class _TopBarController extends State<TopBar> {
  @override
  Widget build(BuildContext context) => _TopBarView(this);
}

class _TopBarView extends StatelessWidget {
    final _TopBarController state;
  _TopBarView(this.state) : super();

@override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
      decoration: BoxDecoration(
        color: colors.bg,
        boxShadow: [
          BoxShadow(
            color: Colors.black87,
            offset: Offset(5, 0),
            blurRadius: 5.0
          ),
        ]
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(),
          TextView(
            text: "All Notes",
            color: colors.white,
            letterSpacing: 1.5,
            size: Responsive.isDesktop(context) ? 25.0 : Responsive.isTablet(context) ? 20.0 : 18.0,
            fontWeight: FontWeight.w400,
          ),
          _showPopupNotebookMenu(context),
        ],
      ),
    );
  }

  Widget _showPopupNotebookMenu(BuildContext context) {
    return PopupMenuButton<int>(
      color: colors.bg,
      onSelected: (i) {
        if(i == 0) {
          //open settings
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => SettingsScreen()));
        }  else {
          //logout
        }
      },
      offset: Offset(0, 15),
      padding: EdgeInsets.symmetric(horizontal: 5.0),
      child: Icon(Icons.more_vert_outlined,
        size: Responsive.isDesktop(context) || Responsive.isTablet(context) ? 20.0 : 30.0,
        color: colors.white,
      ),
      itemBuilder: (context) => [
        PopupMenuItem<int>(
          value: 0,
          child: Row(
            children: [
              FaIcon(FontAwesomeIcons.cog, color: colors.primary, size: 20.0,),
              TextView(text: 'Settings', color: colors.white, size: 15.0, fontWeight: FontWeight.w500, padding: EdgeInsets.only(left: 5.0),),
            ],
          ),
        ),
        PopupMenuItem<int>(
          value: 1,
          child: Row(
            children: [
              FaIcon(FontAwesomeIcons.signOutAlt, color: colors.red, size: 20.0,),
              TextView(text: 'Logout', color: colors.white, size: 15.0, fontWeight: FontWeight.w500, padding: EdgeInsets.only(left: 5.0),),
            ],
          ),
        ),
      ],
    );
  }
}