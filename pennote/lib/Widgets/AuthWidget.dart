import 'package:flutter/material.dart';

class Auth extends StatefulWidget {
  @override
  _AuthController createState() => _AuthController();
}
class _AuthController extends State<Auth> {
  @override
  Widget build(BuildContext context) => _AuthView(this);
}
class _AuthView extends StatelessWidget {
    final _AuthController state;
  _AuthView(this.state) : super();
@override
  Widget build(BuildContext context) {
    return Container();
  }
}