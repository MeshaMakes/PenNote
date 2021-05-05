import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sad_lib/CustomWidgets.dart';
import '../Utils/Colors.dart' as colors;
import '../Utils/responsive.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenController createState() => _SettingsScreenController();
}

class _SettingsScreenController extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) => _SettingsScreenView(this);
}

class _SettingsScreenView extends StatelessWidget {
    final _SettingsScreenController state;
  _SettingsScreenView(this.state) : super();

@override
  Widget build(BuildContext context) {
    return Material(
      color: colors.bg,
      child: SafeArea(
        child: Stack(
          alignment: Alignment.bottomRight,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
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
                    children: [
                      ButtonView(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Icon(Icons.arrow_back_ios_rounded, color: colors.white, size: 30.0,),
                      ),
                      TextView(
                        text: "Settings",
                        color: colors.white,
                        letterSpacing: 1.5,
                        size: Responsive.isDesktop(context) ? 25.0 : Responsive.isTablet(context) ? 20.0 : 18.0,
                        fontWeight: FontWeight.w400,
                        padding: EdgeInsets.only(left: 20.0),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextView.rich(
                          textSpan: [
                            TextView(
                              text: "Hello, ",
                              color: colors.grey,
                              letterSpacing: 1.5,
                              size: Responsive.isDesktop(context) ? 35.0 : Responsive.isTablet(context) ? 30.0 : 25.0,
                              fontWeight: FontWeight.w400,
                            ),
                            TextView(
                              text: "David",
                              color: colors.primary,
                              letterSpacing: 1.5,
                              size: Responsive.isDesktop(context) ? 35.0 : Responsive.isTablet(context) ? 30.0 : 25.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ],
                          padding: EdgeInsets.only(bottom: 40.0, top: 20.0),
                        ),

                        TextView(
                          text: "Account",
                          color: colors.primary,
                          letterSpacing: 1.5,
                          size: Responsive.isDesktop(context) ? 20.0 : Responsive.isTablet(context) ? 18.0 : 15.0,
                          fontWeight: FontWeight.w400,
                          padding: EdgeInsets.only(bottom: 30.0),
                        ),
                        ButtonView(
                          onPressed: () {},
                          color: Colors.transparent,
                          splashColor: Colors.black87.withOpacity(0.50),
                          width: double.infinity,
                          padding: EdgeInsets.all(10.0),
                          margin: EdgeInsets.only(bottom: 10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextView(
                                text: "Logout",
                                color: colors.white,
                                letterSpacing: 1.5,
                                size: Responsive.isDesktop(context) ? 25.0 : Responsive.isTablet(context) ? 20.0 : 18.0,
                                fontWeight: FontWeight.w400,
                                padding: EdgeInsets.only(bottom: 10.0),
                              ),
                              TextView(
                                text: "user@email.com",
                                color: colors.grey,
                                letterSpacing: 1.5,
                                size: Responsive.isDesktop(context) ? 20.0 : Responsive.isTablet(context) ? 18.0 : 15.0,
                                fontWeight: FontWeight.w400,
                              ),
                            ],
                          ),
                        ),
                        ButtonView(
                          onPressed: () {},
                          color: Colors.transparent,
                          splashColor: Colors.black87.withOpacity(0.50),
                          width: double.infinity,
                          padding: EdgeInsets.all(10.0),
                          margin: EdgeInsets.only(bottom: 10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextView(
                                text: "Password",
                                color: colors.white,
                                letterSpacing: 1.5,
                                size: Responsive.isDesktop(context) ? 25.0 : Responsive.isTablet(context) ? 20.0 : 18.0,
                                fontWeight: FontWeight.w400,
                                padding: EdgeInsets.only(bottom: 10.0),
                              ),
                              TextView(
                                text: "Change Password",
                                color: colors.grey,
                                letterSpacing: 1.5,
                                size: Responsive.isDesktop(context) ? 20.0 : Responsive.isTablet(context) ? 18.0 : 15.0,
                                fontWeight: FontWeight.w400,
                              ),
                            ],
                          ),
                        ),

                        TextView(
                          text: "More",
                          color: colors.primary,
                          letterSpacing: 1.5,
                          size: Responsive.isDesktop(context) ? 20.0 : Responsive.isTablet(context) ? 18.0 : 15.0,
                          fontWeight: FontWeight.w400,
                          padding: EdgeInsets.only(bottom: 30.0, top: 50.0),
                        ),
                        ButtonView(
                          onPressed: () {},
                          color: Colors.transparent,
                          splashColor: Colors.black87.withOpacity(0.50),
                          width: double.infinity,
                          padding: EdgeInsets.all(10.0),
                          margin: EdgeInsets.only(bottom: 10.0),
                          child: TextView(
                            text: "About",
                            color: colors.white,
                            letterSpacing: 1.5,
                            size: Responsive.isDesktop(context) ? 25.0 : Responsive.isTablet(context) ? 20.0 : 18.0,
                            fontWeight: FontWeight.w400,
                            padding: EdgeInsets.only(bottom: 10.0),
                          ),
                        ),
                        ButtonView(
                          onPressed: () {},
                          color: Colors.transparent,
                          splashColor: Colors.black87.withOpacity(0.50),
                          width: double.infinity,
                          padding: EdgeInsets.all(10.0),
                          margin: EdgeInsets.only(bottom: 10.0),
                          child: TextView(
                            text: "Buy me a coffee",
                            color: colors.white,
                            letterSpacing: 1.5,
                            size: Responsive.isDesktop(context) ? 25.0 : Responsive.isTablet(context) ? 20.0 : 18.0,
                            fontWeight: FontWeight.w400,
                            padding: EdgeInsets.only(bottom: 10.0),
                          ),
                        ),
                        ButtonView(
                          onPressed: () {},
                          color: Colors.transparent,
                          splashColor: Colors.black87.withOpacity(0.50),
                          width: double.infinity,
                          padding: EdgeInsets.all(10.0),
                          margin: EdgeInsets.only(bottom: 10.0),
                          child: TextView(
                            text: "Visit website",
                            color: colors.white,
                            letterSpacing: 1.5,
                            size: Responsive.isDesktop(context) ? 25.0 : Responsive.isTablet(context) ? 20.0 : 18.0,
                            fontWeight: FontWeight.w400,
                            padding: EdgeInsets.only(bottom: 10.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            TextView(
              text: "v1.0",
              color: colors.grey,
              letterSpacing: 1.5,
              size: Responsive.isDesktop(context) ? 20.0 : Responsive.isTablet(context) ? 18.0 : 15.0,
              fontWeight: FontWeight.w400,
              padding: EdgeInsets.only(bottom: 20.0, right: 20.0),
            ),
          ],
        ),
      ),
    );
  }
}