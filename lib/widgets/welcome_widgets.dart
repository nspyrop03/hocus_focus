import 'package:flutter/material.dart';
import 'package:hocus_focus/styles/colors.dart';
import 'package:hocus_focus/styles/styles.dart';

class NameinputfullboxWidget extends StatelessWidget {
  const NameinputfullboxWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // Figma Flutter Generator NameinputfullboxWidget - INSTANCE
    return SizedBox(
        width: 385,
        height: 60,
        child: Stack(children: <Widget>[
          Positioned(
              top: 0,
              left: 0,
              child: Container(
                  width: 385,
                  height: 60,
                  decoration: const BoxDecoration(
                    borderRadius: MyStyles.roundBox16,
                    boxShadow: [MyStyles.boxShadowBasic],
                    color: MyColors.primary,
                  ))),
          Positioned(
              top: 16,
              left: 13,
              child: Container(
                decoration: const BoxDecoration(),
                padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    InputfieldgenericWidget()
                  ],
                ),
              )),
        ]));
  }
}

class InputfieldgenericWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Figma Flutter Generator InputfieldgenericWidget - COMPONENT
    return Container(
        width: 358,
        height: 29,
        child: Stack(children: <Widget>[
          Positioned(
              top: 7,
              left: 0,
              child: Text(
                'Name:',
                textAlign: TextAlign.center,
                style: MyStyles.magic14,
              )),
          Positioned(
              top: 0,
              left: 78,
              child: Container(
                  width: 280,
                  height: 29,
                  child: Stack(children: <Widget>[
                    Positioned(
                        top: 0,
                        left: 0,
                        child: Container(
                            width: 280,
                            height: 29,
                            decoration: BoxDecoration(
                              borderRadius: MyStyles.roundBox8,
                              color: MyColors.background,
                              border: MyStyles.borderAll1,
                            ))),
                    Positioned(
                        top: 8,
                        left: 8,
                        child: Text(
                          'Input Field',
                          textAlign: TextAlign.center,
                          style: MyStyles.magic14,
                        )),
                  ]))),
        ]));
  }
}
