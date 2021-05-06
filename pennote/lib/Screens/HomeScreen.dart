import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pennote/Widgets/NoteTile.dart';
import 'package:pennote/Widgets/TopBar.dart';
import 'package:sad_lib/CustomWidgets.dart';
import '../Utils/Responsive.dart';
import '../Utils/Colors.dart' as colors;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenController createState() => _HomeScreenController();
}
class _HomeScreenController extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) => _HomeScreenView(this);
}
class _HomeScreenView extends StatelessWidget {
    final _HomeScreenController state;
  _HomeScreenView(this.state) : super();
@override
  Widget build(BuildContext context) {
    return Responsive.isDesktop(context) ? _desktop() : Responsive.isTablet(context) ? _tablet() : _mobile(context);
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
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        for(int i = 0; i < 3; i++)
                          NoteTile(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(right: 20.0, bottom: 20.0),
              child: FloatingActionButton(
                onPressed: () {},
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
}