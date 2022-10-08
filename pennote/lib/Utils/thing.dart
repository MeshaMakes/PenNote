import 'package:flutter/material.dart';

enum headerSize{Size1, Size2, Size3, Size4, Size5, Size6}
extension HeaderSizeExtension on headerSize{

  String get getRawCode{
    if(this == headerSize.Size1) {
      return "#";
    } else if(this == headerSize.Size2){
      return "##";
    } else if(this == headerSize.Size3) {
      return "###";
    } else if(this == headerSize.Size4){
      return "####";
    } else if(this == headerSize.Size5) {
      return "#####";
    } else {
      return "#######";
    }
  }
}



class Header {
  String title;
  headerSize size;
  Color fontColor;

  Header(this.size);

  Widget getWidget(){
    return Container();
  }

  String get getRawCode{
    return "${size.getRawCode} $title";
  }

}
class Paragraph {
  String title;
  headerSize size;
  Color fontColor;

  Widget getWidget(){
    return Container();
  }
}

List<dynamic> things = [
  Header(headerSize.Size1,),
  Paragraph(),
];

Widget jdjd(){
  return Column(
    children: [
      for(int i = 0; i < things.length; i++)
        things[i].widget,
    ],
  );
}
