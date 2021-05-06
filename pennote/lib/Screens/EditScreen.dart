import 'package:flutter/material.dart';
import 'package:markdown_widget/markdown_widget.dart';
import 'package:sad_lib/CustomWidgets.dart';
import '../Utils/Colors.dart' as colors;
import '../Utils/Responsive.dart';
import 'package:url_launcher/url_launcher.dart';

class EditScreen extends StatefulWidget {
  @override
  _EditScreenController createState() => _EditScreenController();
}

class _EditScreenController extends State<EditScreen> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) => _EditScreenView(this);

  TabController _tab;
  TextEditingController _text;
  TextEditingController _titleText;

  String _textOutput = "";

  void setText(String text) {
    setState(() {
      this._textOutput = text;
    });
  }

  @override
  void initState() {
    _tab = TabController(length: 2, vsync: this);
    _text = TextEditingController();
    _titleText = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _tab.dispose();
    _titleText.dispose();
    super.dispose();
  }
}

class _EditScreenView extends StatelessWidget {
    final _EditScreenController state;
  _EditScreenView(this.state) : super();

@override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        top: true,
        child: Scaffold(
          backgroundColor: colors.bg,
          appBar: AppBar(
            backgroundColor: colors.bg,
            leading: ButtonView(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Icon(Icons.arrow_back_ios_rounded, color: colors.white, size: 30.0,),
            ),
            title: Align(
              alignment: Alignment.topRight,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ButtonView(
                    onPressed: () {},
                    color: Colors.transparent,
                    splashColor: Colors.black87.withOpacity(0.50),
                    child: Icon(Icons.save, color: colors.white, size: 25.0,),
                    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                  ),
                  ButtonView(
                    onPressed: () {},
                    color: Colors.transparent,
                    splashColor: Colors.black87.withOpacity(0.50),
                    child: Icon(Icons.info_outline, color: colors.white, size: 25.0,),
                    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                  ),
                  ButtonView(
                    onPressed: () {},
                    color: Colors.transparent,
                    splashColor: Colors.black87.withOpacity(0.50),
                    child: Icon(Icons.delete, color: colors.red.withOpacity(0.80), size: 25.0,),
                    padding: EdgeInsets.only(left: 10.0, top: 5.0, bottom: 5.0),
                  ),
                ],
              ),
            ),
            bottom: TabBar(
              controller: state._tab,
              labelColor: colors.primary,
              unselectedLabelColor: colors.grey,
              indicatorColor: colors.primary,
              indicatorSize: TabBarIndicatorSize.tab,
              indicator: UnderlineTabIndicator(
                borderSide: BorderSide(width: 4.0, color: colors.primary),
              ),
              tabs: [
                Tab(
                  text: "Edit",
                ),
                Tab(
                  text: "Preview",
                ),
              ],
            ),
          ),
          body: TabBarView(
            controller: state._tab,
            children: [
              Stack(
                children: [
                  Container(
                    margin: EdgeInsets.all(20.0),
                    child: TextField(
                      controller: state._text,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      toolbarOptions: ToolbarOptions(cut: true, copy: true, paste: true, selectAll: true),
                      style: TextStyle(color: colors.grey),
                      cursorColor: colors.grey,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Start typing",
                          hintStyle: TextStyle(color: colors.grey),
                      ),
                      onChanged: (String text) {
                        state.setText(text);
                      },
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: EdgeInsets.only(right: 10.0, bottom: 20.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(Icons.watch_later_outlined, color: colors.primary, size: 20.0,),
                              TextView(
                                text: "Apr 21, 2021",
                                size: 12.0,
                                color: colors.white,
                                fontWeight: FontWeight.w400,
                                padding: EdgeInsets.only(left: 10.0),
                              ),
                            ],
                          ),
                          SizedBox(height: 10.0,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(Icons.edit, color: colors.primary, size: 20.0,),
                              TextView(
                                text: "Apr 26, 2021",
                                size: 12.0,
                                color: colors.white,
                                fontWeight: FontWeight.w400,
                                padding: EdgeInsets.only(left: 10.0),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.all(20.0),
                child: MarkdownWidget(
                  data: state._textOutput,
                  styleConfig: StyleConfig(
                    markdownTheme: MarkdownTheme.darkTheme,
                    pConfig: PConfig(
                      linkStyle: TextStyle(color: colors.primary),
                      onLinkTap: (url) {
                        launch(url);
                      }
                    )
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _showPopupNotebookMenu(BuildContext context) {
      return PopupMenuButton<int>(
        color: colors.bg,
        onSelected: (i) {
          if(i == 0) {
            //open settings
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

                TextView(text: 'Settings', color: colors.white, size: 15.0, fontWeight: FontWeight.w500, padding: EdgeInsets.only(left: 5.0),),
              ],
            ),
          ),
          PopupMenuItem<int>(
            value: 1,
            child: Row(
              children: [

                TextView(text: 'Logout', color: colors.white, size: 15.0, fontWeight: FontWeight.w500, padding: EdgeInsets.only(left: 5.0),),
              ],
            ),
          ),
        ],
      );
    }
}