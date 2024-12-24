library welcome_widgets;
import 'package:flutter/material.dart';
import 'package:hocus_focus/screens/main_page.dart';
import 'package:hocus_focus/sqflite_helper.dart';
import 'package:hocus_focus/styles/colors.dart';
import 'package:hocus_focus/styles/styles.dart';
import 'dart:math' as math;
import 'package:flutter_svg/flutter_svg.dart';

class NameInputFullBoxWidget extends StatelessWidget {
  final inputField = InputFieldGenericWidget();

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
                  child: inputField)),
        ]));
  }
}

class InputFieldGenericWidget extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
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
                      controller: nameController,
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
  final String type;
  final VoidCallback onNext;
  final VoidCallback onPrevious;

  const ChangeAppearanceWidget(
      {super.key,
      required this.name,
      required this.onNext,
      required this.onPrevious,
      required this.type});

  @override
  State<ChangeAppearanceWidget> createState() => _ChangeAppearanceWidgetState();
}

class _ChangeAppearanceWidgetState extends State<ChangeAppearanceWidget> {
  var currentSelection = 1;

  Future<int> waitForLengthData() async {
    var request = await DatabaseHelper().getWizardAssetsOfType(widget.type);
    return request.length;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: waitForLengthData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
              width: 160,
              height: 45,
              decoration: BoxDecoration(
                borderRadius: MyStyles.roundBox16,
                boxShadow: [MyStyles.boxShadowBasic],
                color: MyColors.primary,
              ),
              child: Center(child: CircularProgressIndicator()));
        } else if (snapshot.hasError) {
          return Center(child: Text('Error loading assets'));
        } else {
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
                            padding: EdgeInsets.symmetric(
                                horizontal: 0, vertical: 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                GestureDetector(
                                  onTap: () {
                                    print('Tapped previous');
                                    if (currentSelection > 1) {
                                      widget.onPrevious();
                                    }
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
                                  '$currentSelection/${snapshot.data}',
                                  textAlign: TextAlign.center,
                                  style: MyStyles.magic14,
                                ),
                                SizedBox(width: 10),
                                GestureDetector(
                                  onTap: () {
                                    print('Tapped next');
                                    if (currentSelection <
                                        (snapshot.data ?? 0)) {
                                      widget.onNext();
                                    }
                                    setState(() {
                                      currentSelection = math.min(
                                          snapshot.data ?? 0,
                                          currentSelection + 1);
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
      },
    );
  }
}

final mainPageKey = GlobalKey<MainPageState>();

class CreateButtonWidget extends StatelessWidget {
  final dynamic text;
  
  final TextEditingController? inputField;
  final Future<void> Function()? extraOnClick;

  const CreateButtonWidget(
      {super.key, required this.text, this.inputField, this.extraOnClick});
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
            onPressed: () async{
              print("Pressing the button!");
              if (inputField != null && inputField!.text.isNotEmpty) {
                print("Checked field! ${inputField!.text}");
                await extraOnClick!();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => MainPage(key: mainPageKey)),
                );
              }
            },
            style: MyStyles.createButtonStyle,
            child: Text(
              text,
              style: MyStyles.magic24.copyWith(color: Colors.black),
            ),
          ),
        ));
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