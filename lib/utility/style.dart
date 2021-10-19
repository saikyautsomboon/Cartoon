import 'package:flutter/material.dart';

class Style {
  Color dartColor = Color(0xff62757f);
  Color prinaryColor = Color(0xff90a4ae);
  Color lightColor = Color(0xffc1d5e0);
  BoxDecoration boxDecoration() => BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white30,
      );

  TextStyle redBoldStyle() => TextStyle(
        color: Colors.red.shade400,
        fontWeight: FontWeight.bold,
      );

  Widget logo() {
    return Image.asset('images/logo.png');
  }

  Widget titileH1(String string) => Text(
        string,
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.italic,
          color: dartColor,
        ),
      );
  Widget titileH2(String string) => Text(
        string,
        style: TextStyle(
          fontSize: 21,
          color: dartColor,
        ),
      );

  Widget titileH2White(String string) => Text(
        string,
        style: TextStyle(
          fontSize: 21,
          color: Colors.white,
        ),
      );
  Widget titileH3(String string) => Text(
        string,
        style: TextStyle(
          fontSize: 15,
          // fontWeight: FontWeight.w400,
          color: dartColor,
        ),
      );
  Widget titileH3White(String string) => Text(
        string,
        style: TextStyle(
          fontSize: 13,
          // fontWeight: FontWeight.w400,
          color: Colors.white54,
        ),
      );
  Style();
}
