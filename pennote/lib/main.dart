import 'package:flutter/material.dart';
import 'package:pennote/Screens/HomeScreen.dart';
import 'package:pennote/Utils/Colors.dart' as colors;

void main() {
  runApp(MaterialApp(
    theme: ThemeData(
      accentColor: colors.primary
    ),
    home: HomeScreen(),
  ));
}