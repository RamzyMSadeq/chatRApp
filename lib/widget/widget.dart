import 'package:flutter/material.dart';
import 'package:chatapp/helper/theme.dart' as style;

Widget appBarMain(BuildContext context) {
  return AppBar(
    title:Text('chat'),
    elevation: 0.0,
    centerTitle: false,
    backgroundColor:style.CustomTheme.mainColors ,
  );
}

InputDecoration textFieldInputDecoration(String hintText) {
  return InputDecoration(
      hintText: hintText,
      hintStyle: TextStyle(color: Colors.white54),
      focusedBorder:
          UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
      enabledBorder:
          UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)));
}

TextStyle simpleTextStyle() {
  return TextStyle(color: Colors.white, fontSize: 16);
}
TextStyle simpleTextStyle2() {
  return TextStyle(color: Colors.grey[900], fontSize: 16);
}

TextStyle biggerTextStyle() {
  return TextStyle(color: Colors.white, fontSize: 17);
}
