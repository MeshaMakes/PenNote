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
            elevation: 0.0,
            backgroundColor: colors.bg,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
            child: Container(
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

  Future<bool> showConfirmDialog(BuildContext context, String message, {String title = "Caution", String positiveBtn = "Confirm",  String negativeBtn = "Cancel", bool dismissible = true}) {
    return showDialog(
        context: context,
        barrierDismissible: dismissible,
        builder: (BuildContext context) {
          return Dialog(
            backgroundColor: colors.bg,
            elevation: 0.0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
            child: Container(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                padding: EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 30.0,),
                    Text(
                      "$message",
                      style: TextStyle(
                        color: colors.grey,
                        fontSize: 15.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 30.0,),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Spacer(),
                        ButtonView(
                          color: colors.grey,
                          onPressed: () {
                            Navigator.of(context).pop(false);
                          },
                          margin: EdgeInsets.only(top: 20.0),
                          padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
                          child: Text(
                            "$negativeBtn",
                            style: TextStyle(
                              color: colors.white,
                              fontSize: 15.0,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        SizedBox(width: 10.0,),
                        ButtonView(
                          color: colors.primary,
                          onPressed: () {
                            Navigator.of(context).pop(true);
                          },
                          margin: EdgeInsets.only(top: 20.0),
                          padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
                          child: Text(
                            "$positiveBtn",
                            style: TextStyle(
                              color: colors.bg,
                              fontSize: 15.0,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
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