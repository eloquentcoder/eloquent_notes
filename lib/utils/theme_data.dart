import 'package:elo_notes_app/utils/size_config.dart';
import 'package:flutter/material.dart';

ThemeData themeData() {
  return ThemeData(
      visualDensity: VisualDensity.adaptivePlatformDensity,
      primaryColor: primaryColor,
      scaffoldBackgroundColor: whiteColor,
      fontFamily: 'Raleway');
}

TextStyle headingText() {
  return TextStyle(
      fontSize: SizeConfig.blockSizeHorizontal * 6,
      color: secondaryColor,
      fontWeight: FontWeight.bold);
}

const secondaryColor = Color(0xff22006d);
const primaryColor = Colors.black;
const whiteColor = Colors.white;
const mainBackColor = Color(0xfff7f7f7);
const buttonColor = Color(0xfffdb800);
