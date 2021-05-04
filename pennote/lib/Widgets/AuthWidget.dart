import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pennote/Screens/HomeScreen.dart';
import 'package:pennote/Utils/responsive.dart';
import 'package:sad_lib/CustomWidgets.dart';
import '../Utils/Colors.dart' as colors;

class Auth extends StatefulWidget {
  @override
  _AuthController createState() => _AuthController();
}

class _AuthController extends State<Auth> {
  @override
  Widget build(BuildContext context) => _AuthView(this);

  Size size;

  @override
  void initState() {
    super.initState();
  }
}

class _AuthView extends StatelessWidget {
    final _AuthController state;
  _AuthView(this.state) : super();

@override
  Widget build(BuildContext context) {
  state.size = MediaQuery.of(context).size;
    return Material(
      color: colors.bg,
      child: Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 40.0),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  TextView(
                    text: "Pen Note",
                    color: colors.white,
                    size: Responsive.isDesktop(context) ? 40.0 : Responsive.isTablet(context) ? 35.0 : 25.0,
                    fontWeight: FontWeight.w500,
                  ),
                  Positioned(
                    right: -30.0,
                    child: Icon(Icons.edit_outlined, color: colors.primary, size: 30.0,),
                  ),
                ],
              ),
            ),
            Spacer(),
            ButtonView.hover(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomeScreen()));
              },
              width: Responsive.isDesktop(context) ? state.size.width / 2.5 : Responsive.isTablet(context) ? state.size.width / 1.5 : state.size.width,
              onHover: ContainerChanges(
                  padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                  margin: EdgeInsets.only(bottom: 40.0),
                  decoration: BoxDecoration(
                    color: colors.primary,
                    borderRadius: BorderRadius.circular(7.5),
                  ),
              ),
              color: colors.primary.withOpacity(0.80),
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              margin: EdgeInsets.only(bottom: 40.0),
              builder: (isHovering) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FaIcon(FontAwesomeIcons.google, color: colors.bg, size: 25.0,),
                    TextView(
                      text: "Continue with Google",
                      color: colors.bg,
                      size: Responsive.isDesktop(context) ? 20.0 : Responsive.isTablet(context) ? 18.0 : 15.0,
                      fontWeight: FontWeight.w700,
                      align: TextAlign.center,
                      padding: EdgeInsets.only(left: 20.0),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}