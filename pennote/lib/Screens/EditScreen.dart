import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:markdown_widget/markdown_widget.dart';
import '../Widgets/Dialog.dart';
import 'package:sad_lib/FormatClass.dart';
import '../Utils/NoteModel.dart';
import 'package:sad_lib/CustomWidgets.dart';
import 'package:sad_lib/StorageClass/StorageClass.dart';
import '../Utils/Colors.dart' as colors;
import '../Utils/Responsive.dart';
import 'package:url_launcher/url_launcher.dart';

class EditScreen extends StatefulWidget {
  final Note note;
  const EditScreen({Key key, @required this.note}) : super(key: key);
  @override
  _EditScreenController createState() => _EditScreenController();
}

class _EditScreenController extends State<EditScreen> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) => _EditScreenView(this);

  //TODO: revise the last edited to make sure it adds up

  TabController _tab;
  TextEditingController _text;
  FormatClass _format;
  DialogClass _dialog;

  Note note;
  String _noteText = "";

  void setText(String text) {
    setState(() {
      this._noteText = text;
    });
  }

  void saveNote() {
    if(_noteText != null && _noteText.isNotEmpty) {
      note.noteTxt = _noteText;
      note.lastEdited = DateTime.now();
      StorageClass().writeToMapUpdate("Notes.pn", note.id, note.toJson()).then((value) {
        Fluttertoast.showToast(
          msg: "Note Saved",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          textColor: colors.primary,
          backgroundColor: Colors.black45,
        );
      });
    }
  }

  void deleteNote() {
    _dialog.showConfirmDialog(context, "Are you sure you want to delete this note?").then((flag) {
      if(flag) {
        StorageClass().writeToMapRemove("Notes.pn", widget.note.id).then((value) {
          Navigator.pop(context);
        });
      } else {
        Navigator.pop(context);
      }
    });
  }

  @override
  void initState() {
    _tab = TabController(length: 2, vsync: this);
    _text = TextEditingController();
    _format = FormatClass();
    _dialog = DialogClass();
    note = widget.note;
    if(widget.note != null) {
      setState(() {
        _text.text = widget.note.noteTxt;
        note.noteTxt = _text.text;
        note.creationDate = widget.note.creationDate;
      });
    }
    super.initState();
  }

  @override
  void dispose() {
    _tab.dispose();
    _text.dispose();
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
                    onPressed: () {
                      state.saveNote();
                    },
                    color: Colors.transparent,
                    splashColor: Colors.black87.withOpacity(0.50),
                    child: Icon(Icons.save, color: colors.white, size: 25.0,),
                    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                  ),
                  _showPopupNotebookMenu(context),
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
                    width: double.infinity,
                    height: double.infinity,
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
                                text: state._format.formattedDate(state.widget.note.creationDate),
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
                                text: state._format.formattedDate(state.widget.note.lastEdited),
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
                  data: state._text.text,
                  styleConfig: StyleConfig(
                    markdownTheme: MarkdownTheme.darkTheme,
                    titleConfig: TitleConfig(
                      showDivider: false,
                    ),
                    pConfig: PConfig(
                      linkStyle: TextStyle(color: colors.primary),
                      onLinkTap: (url) {
                        launch(url);
                      }
                    ),
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
            //open info
          }  else if(i == 1) {
            //view preview
          } else {
            //delete note
            state.deleteNote();
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
                Icon(Icons.info_outline, size: 20.0, color: !Responsive.isMobile(context) ? colors.white : colors.primary,),
                TextView(text: 'Info', color: colors.white, size: 15.0, fontWeight: FontWeight.w500, padding: EdgeInsets.only(left: 5.0),),
              ],
            ),
          ),
          if(!Responsive.isMobile(context))
            PopupMenuItem<int>(
            value: 1,
            child: Row(
              children: [
                Icon(Icons.visibility, size: 20.0, color: colors.primary,),
                TextView(text: 'View Preview', color: colors.white, size: 15.0, fontWeight: FontWeight.w500, padding: EdgeInsets.only(left: 5.0),),
              ],
            ),
          ),
          PopupMenuItem<int>(
            value: 2,
            child: Row(
              children: [
                Icon(Icons.delete, size: 20.0, color: colors.red,),
                TextView(text: 'Delete Note', color: colors.white, size: 15.0, fontWeight: FontWeight.w500, padding: EdgeInsets.only(left: 5.0),),
              ],
            ),
          ),
        ],
      );
    }
}