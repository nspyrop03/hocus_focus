import 'package:flutter/material.dart';

class MyStyles {

  static const TextStyle magic14 = TextStyle(
    color: Color(0xff000000),
    fontFamily: 'AvolisseDEMO',
    fontSize: 14,
    letterSpacing: 0,
    fontWeight: FontWeight.normal,
    height: 1
  );

  static const TextStyle magic24 = TextStyle(
    color: Color(0xff000000),
    fontFamily: 'AvolisseDEMO',
    fontSize: 24,
    letterSpacing: 0,
    fontWeight: FontWeight.normal,
    height: 1
  );

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

  static Border borderAll1 = Border.all(
    color: Color.fromRGBO(0, 0, 0, 1),
    width: 1,
  );

  static const BoxShadow boxShadowBasic = BoxShadow(
    color: Color.fromRGBO(0, 0, 0, 0.25),
    offset: Offset(0, 4),
    blurRadius: 4
  );

}