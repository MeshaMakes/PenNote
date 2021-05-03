import 'package:flutter/material.dart';
import '../Utils/responsive.dart';

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
    return Responsive.isDesktop(context) ? _desktop() : Responsive.isTablet(context) ? _tablet() : _mobile();
  }


  Widget _mobile() {
    return Container(
      color: Colors.green,
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