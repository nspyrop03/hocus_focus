import 'package:flutter/material.dart';
import 'package:hocus_focus/styles/colors.dart';

class MyStyles {
  static const TextStyle magic14 = TextStyle(
      color: Color(0xff000000),
      fontFamily: 'AvolisseDEMO',
      fontSize: 14,
      letterSpacing: 0,
      fontWeight: FontWeight.normal,
      height: 1);

  static const TextStyle magic24 = TextStyle(
      color: Color(0xff000000),
      fontFamily: 'AvolisseDEMO',
      fontSize: 24,
      letterSpacing: 0,
      fontWeight: FontWeight.normal,
      height: 1);

  static const BorderRadiusGeometry roundBox16 = BorderRadius.only(
    topLeft: Radius.circular(16),
    topRight: Radius.circular(16),
    bottomLeft: Radius.circular(16),
    bottomRight: Radius.circular(16),
  );

  static const BorderRadiusGeometry roundBox8 = BorderRadius.only(
    topLeft: Radius.circular(8),
    topRight: Radius.circular(8),
    bottomLeft: Radius.circular(8),
    bottomRight: Radius.circular(8),
  );

  static const BorderRadiusGeometry topBox = BorderRadius.only(
    topLeft: Radius.circular(0),
    topRight: Radius.circular(0),
    bottomLeft: Radius.circular(15),
    bottomRight: Radius.circular(15),
  );

  static const BorderRadiusGeometry bottomBox = BorderRadius.only(
    topLeft: Radius.circular(15),
    topRight: Radius.circular(15),
    bottomLeft: Radius.circular(0),
    bottomRight: Radius.circular(0),
  );

  static Border borderAll1 = Border.all(
    color: Color.fromRGBO(0, 0, 0, 1),
    width: 1,
  );

  static const BoxShadow boxShadowBasic = BoxShadow(
      color: Color.fromRGBO(0, 0, 0, 0.25),
      offset: Offset(0, 4),
      blurRadius: 4);

  static ButtonStyle createButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: MyColors.secondary,
    textStyle: magic24.copyWith(color: Colors.black),
    shape: RoundedRectangleBorder(
      borderRadius: roundBox8,
    ),
  );
}
