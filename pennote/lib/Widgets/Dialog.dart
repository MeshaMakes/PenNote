import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sad_lib/CustomWidgets.dart';
import '../Utils/Colors.dart' as colors;

class DialogClass {
  Future<String> showInputDialog(BuildContext context, {String positiveBtn = "Add", String title = "Add your Question", String hint = "eg: Are you going to exercise today?", bool dismissible = false, int maxLength = 100}) {
    String text;
    return showDialog(
        context: context,
        barrierDismissible: dismissible,
        builder: (BuildContext context) {
          return Dialog(
            backgroundColor: colors.bg,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
            child: Container(
              width: MediaQuery.of(context).size.width / 3,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                padding: EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextView(
                      text: "$title",
                        color: colors.white,
                        size: 20.0,
                        fontWeight: FontWeight.w500,
                    ),
                    SizedBox(height: 30.0,),
                    TextField(
                      autocorrect: true,
                      enableSuggestions: true,
                      textInputAction: TextInputAction.newline,
                      textCapitalization: TextCapitalization.sentences,
                      scrollPhysics: BouncingScrollPhysics(),
                      textAlignVertical: TextAlignVertical.center,
                      toolbarOptions: ToolbarOptions(paste: true, selectAll: true, copy: true, cut: true),
                      keyboardType: TextInputType.multiline,
                      cursorColor: colors.primary,
                      maxLength: maxLength,
                      maxLines: null,
                      minLines: null,
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w400,
                        color: colors.grey,
                      ),
                      onChanged: (s) {
                        text = s;
                      },
                      decoration: InputDecoration(
                        filled: false,
                        hintText: "$hint",
                        hintStyle: TextStyle(color: Colors.grey),
                        focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: colors.primary)),
                        enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: colors.grey),),
                        contentPadding: EdgeInsets.all(10.0),
                      ),
                    ),
                    ButtonView(
                      alignment: Alignment.bottomRight,
                      color: colors.primary,
                      margin: EdgeInsets.only(top: 30.0),
                      padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
                      onPressed: () {
                        if(text != null && text != "") {
                          Navigator.of(context).pop(text);
                        }
                      },
                      child: TextView(
                        text: "$positiveBtn",
                        color: colors.white,
                        size: 15.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
    );
  }
}