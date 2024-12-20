import 'package:flutter/material.dart';
import 'package:hocus_focus/styles/colors.dart';
import 'package:hocus_focus/styles/styles.dart';
import 'dart:math' as math;
import 'package:flutter_svg/flutter_svg.dart';

class NameInputFullBoxWidget extends StatelessWidget {
  const NameInputFullBoxWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // Figma Flutter Generator NameinputfullboxWidget - INSTANCE
    return SizedBox(
        width: 370,
        height: 70,
        child: Stack(children: <Widget>[
          Positioned(
              top: 0,
              left: 0,
              child: Container(
                  width: 370,
                  height: 70,
                  decoration: const BoxDecoration(
                    borderRadius: MyStyles.roundBox16,
                    boxShadow: [MyStyles.boxShadowBasic],
                    color: MyColors.primary,
                  ))),
          Positioned(
              top: 20,
              left: 13,
              child: Container(
                  decoration: const BoxDecoration(),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                  child: InputFieldGenericWidget())),
        ]));
  }
}

class InputFieldGenericWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Name:',
                textAlign: TextAlign.center,
                style: MyStyles.magic14,
              ),
              SizedBox(width: 30),
              Stack(
                children: [
                  Container(
                      width: 250,
                      height: 29,
                      decoration: BoxDecoration(
                        borderRadius: MyStyles.roundBox8,
                        color: MyColors.background,
                        border: MyStyles.borderAll1,
                      )),
                  SizedBox(
                    width: 250,
                    height: 22,
                    child: TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Enter your name',
                        hintStyle: MyStyles.magic14,
                      ),
                      style: MyStyles.magic14,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}

class ChangeAppearanceWidget extends StatefulWidget {
  final dynamic name;
  final dynamic maxSelections;

  const ChangeAppearanceWidget(
      {super.key, required this.name, required this.maxSelections});

  @override
  State<ChangeAppearanceWidget> createState() => _ChangeAppearanceWidgetState();
}

class _ChangeAppearanceWidgetState extends State<ChangeAppearanceWidget> {
  var currentSelection = 1;

  @override
  Widget build(BuildContext context) {
    // Figma Flutter Generator ChangeappearanceWidget - COMPONENT
    return SizedBox(
        width: 160,
        height: 45,
        child: Stack(children: <Widget>[
          Positioned(
              top: 0,
              left: 0,
              child: Container(
                  width: 160,
                  height: 45,
                  decoration: BoxDecoration(
                    borderRadius: MyStyles.roundBox16,
                    boxShadow: [MyStyles.boxShadowBasic],
                    color: MyColors.primary,
                  ))),
          Positioned(
              top: 16,
              left: 7,
              child: Container(
                decoration: BoxDecoration(),
                padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      widget.name,
                      textAlign: TextAlign.center,
                      style: MyStyles.magic14,
                    ),
                    SizedBox(width: 22),
                    Container(
                      decoration: BoxDecoration(),
                      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              print('Tapped previous');
                              setState(() {
                                currentSelection =
                                    math.max(1, currentSelection - 1);
                              });
                            },
                            child: SvgPicture.asset(
                                'assets/images/vector29.svg',
                                semanticsLabel: 'vector29'),
                          ),
                          SizedBox(width: 10),
                          Text(
                            '$currentSelection/${widget.maxSelections}',
                            textAlign: TextAlign.center,
                            style: MyStyles.magic14,
                          ),
                          SizedBox(width: 10),
                          GestureDetector(
                            onTap: () {
                              print('Tapped next');
                              setState(() {
                                currentSelection = math.min(
                                    widget.maxSelections, currentSelection + 1);
                              });
                            },
                            child: SvgPicture.asset(
                                'assets/images/vector28.svg',
                                semanticsLabel: 'vector28'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )),
        ]));
  }
}

class CreateButtonWidget extends StatelessWidget {
  final dynamic text;

  const CreateButtonWidget({super.key, required this.text});
  @override
  Widget build(BuildContext context) {
    // Figma Flutter Generator CreatebuttonWidget - INSTANCE
    return SizedBox(
        width: 150,
        height: 62,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: MyStyles.roundBox8,
            boxShadow: [MyStyles.boxShadowBasic],
            color: MyColors.secondary,
            border: MyStyles.borderAll1,
          ),
          child: OutlinedButton(
            onPressed: () {},
            style: MyStyles.createButtonStyle,
            child: Text(text, style: MyStyles.magic24.copyWith(color: Colors.black),),
          ),
        )
      );
  }
}

class PageTitleWidget extends StatelessWidget {
  final dynamic title;
  const PageTitleWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          textAlign: TextAlign.left,
          style: MyStyles.magic24,
        ),
        Divider(
          color: MyColors.details,
          thickness: 2,
          indent: 10,
          endIndent: 10,
        ),
      ],
    );
  }
}

//===== It needs a ton of changes, maybe even seperate file!!! =====\\
class WizardIconWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Figma Flutter Generator WizardiconWidget - RECTANGLE
    return Container(
        width: 148,
        height: 168,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/Wizardicon.png'),
              fit: BoxFit.fitWidth),
        ));
  }
}
