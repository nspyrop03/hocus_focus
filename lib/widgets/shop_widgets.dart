import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hocus_focus/styles/colors.dart';
import 'package:hocus_focus/styles/styles.dart';

class Category1Widget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Figma Flutter Generator Category1Widget - VECTOR
    return SvgPicture.asset('assets/images/category1.svg',
        semanticsLabel: 'category1');
    ;
  }
}

class ShopcategoriesWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Figma Flutter Generator ShopcategoriesWidget - INSTANCE
    return Container(
        width: 121,
        height: 79,
        child: Stack(children: <Widget>[
          Positioned(top: 0, left: -10, child: Category1Widget()),
          Positioned(
              top: 24,
              left: 0,
              child: Text(
                'Wands',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Color.fromRGBO(0, 0, 0, 1),
                    fontFamily: 'AvolisseDEMO',
                    fontSize: 20,
                    letterSpacing: 0,
                    fontWeight: FontWeight.normal,
                    height: 1.5 /*PERCENT not supported*/
                    ),
              )),
        ]));
  }
}

class Component2Widget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Figma Flutter Generator Component2Widget - INSTANCE
    return Container(
        width: 362,
        height: 79,
        child: Stack(children: <Widget>[
          Positioned(top: 0, left: 0, child: ShopcategoriesWidget()),
          Positioned(top: 0, left: 126, child: ShopcategoriesWidget()),
          Positioned(top: 0, left: 247, child: ShopcategoriesWidget()),
        ]));
  }
}

class ShoprectangleWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Figma Flutter Generator ShoprectangleWidget - INSTANCE
    return Container(
        width: 362,
        height: 564,
        child: Stack(children: <Widget>[
          Positioned(
              top: 0,
              left: 0,
              child: Container(
                  width: 362,
                  height: 564,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                    color: MyColors.details,
                    border: Border.all(
                      color: MyColors.details,
                      width: 1,
                    ),
                  ))),
        ]));
  }
}
