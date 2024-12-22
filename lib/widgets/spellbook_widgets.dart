import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hocus_focus/styles/colors.dart';
import 'package:hocus_focus/styles/styles.dart';

class SpellslotWidget extends StatelessWidget {
  final String spellName;

  // Constructor with spellName parameter and a default value
  SpellslotWidget({this.spellName = 'Spell Name'});

  @override
  Widget build(BuildContext context) {
    // Figma Flutter Generator SpellslotWidget - INSTANCE
    return Container(
      width: 170,
      height: 161,
      child: Stack(children: <Widget>[
        Positioned(
          top: 0,
          left: 0,
          child: Container(
            width: 170,
            height: 161,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(14),
                topRight: Radius.circular(14),
                bottomLeft: Radius.circular(14),
                bottomRight: Radius.circular(14),
              ),
              boxShadow: [MyStyles.boxShadowBasic],
              color: MyColors.details,
              border: Border.all(
                color: Color.fromRGBO(0, 0, 0, 1),
                width: 1,
              ),
            ),
          ),
        ),
        Positioned(
          top: 9,
          left: 15,
          child: Container(
            width: 140,
            height: 115,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
              color: MyColors.primary,
              border: Border.all(
                color: Color.fromRGBO(0, 0, 0, 1),
                width: 1,
              ),
            ),
          ),
        ),
        Positioned(
          top: 131,
          left: 15,
          child: Container(
            width: 140,
            height: 26,
            decoration: BoxDecoration(),
            child: Container(
              width: 140,
              height: 26,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                color: MyColors.primary,
                border: Border.all(
                  color: Color.fromRGBO(0, 0, 0, 1),
                  width: 1,
                ),
              ),
              child: Center(  // Centering the text inside the container
                child: Text(
                  spellName,  // Use the custom spellName here
                  textAlign: TextAlign.center,
                  style: MyStyles.magic14,
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: 12,
          left: 18.5,
          child: SvgPicture.asset('assets/images/vector12.svg', semanticsLabel: 'vector12'),
        ),
      ]),
    );
  }
}


/*
class SpellslotWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Figma Flutter Generator SpellslotWidget - INSTANCE
    return Container(
        width: 170,
        height: 161,
        child: Stack(children: <Widget>[
          Positioned(
              top: 0,
              left: 0,
              child: Container(
                  width: 170,
                  height: 161,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(14),
                      topRight: Radius.circular(14),
                      bottomLeft: Radius.circular(14),
                      bottomRight: Radius.circular(14),
                    ),
                    boxShadow: [MyStyles.boxShadowBasic],
                    color: MyColors.details,
                    border: Border.all(
                      color: Color.fromRGBO(0, 0, 0, 1),
                      width: 1,
                    ),
                  ))),
          Positioned(
              top: 9,
              left: 15,
              child: Container(
                  width: 140,
                  height: 115,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                    color: MyColors.primary,
                    border: Border.all(
                      color: Color.fromRGBO(0, 0, 0, 1),
                      width: 1,
                    ),
                  ))),
          Positioned(
              top: 131,
              left: 15,
              child: Container(
                  width: 140,
                  height: 26,
                  decoration: BoxDecoration(),
                  child: Stack(children: <Widget>[
                    Positioned(
                        top: 0,
                        left: 0,
                        child: Container(
                            width: 140,
                            height: 26,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                              ),
                              color: MyColors.primary,
                              border: Border.all(
                                color: Color.fromRGBO(0, 0, 0, 1),
                                width: 1,
                              ),
                            ))),
                    Positioned(
                        top: 6,
                        left: 33,
                        child: Text('Spell Name',
                            textAlign: TextAlign.left,
                            style: MyStyles.magic14)),
                  ]))),
          Positioned(
              top: 12,
              left: 18.5,
              child: SvgPicture.asset('assets/images/vector12.svg',
                  semanticsLabel: 'vector12')),
        ]));
  }
}*/
