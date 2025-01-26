import 'package:flutter/material.dart';

class StyleAsset {
  static TextStyle normal({double fontSize = 16.0}) {
    return TextStyle(
        fontStyle: FontStyle.normal, fontFamily: "Poppins", fontSize: fontSize);
  }

  static TextStyle italic({double fontSize = 16.0}) {
    return TextStyle(
        fontStyle: FontStyle.italic, fontFamily: "Poppins", fontSize: fontSize);
  }

  static TextStyle bold({double fontSize = 16.0}) {
    return TextStyle(
        fontWeight: FontWeight.bold, fontFamily: "Poppins", fontSize: fontSize);
  }
}
