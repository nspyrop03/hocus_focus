import 'package:flutter/material.dart';
import 'package:hocus_focus/styles/colors.dart';
import 'package:hocus_focus/styles/styles.dart';
import 'package:hocus_focus/widgets/bar_widgets.dart';
import 'package:hocus_focus/widgets/spellbook_widgets.dart' as spellbook;
import 'package:hocus_focus/widgets/welcome_widgets.dart' as welcome;


import 'package:flutter/material.dart';
import 'package:hocus_focus/styles/colors.dart';
import 'package:hocus_focus/styles/styles.dart';
import 'package:hocus_focus/widgets/bar_widgets.dart';
import 'package:hocus_focus/widgets/spellbook_widgets.dart' as spellbook;
import 'package:hocus_focus/widgets/welcome_widgets.dart' as welcome;

class SpellbookPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scrollbarTheme: ScrollbarThemeData(
          thumbColor: MaterialStateProperty.all(MyColors.primary),
          trackColor: MaterialStateProperty.all(MyColors.secondary),
          radius: Radius.circular(10),
          thickness: MaterialStateProperty.all(10.0),
        ),
      ),
      home: Scaffold(
        backgroundColor: MyColors.background,
        body: Column(
          children: [
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  "Spellbook",
                  style: MyStyles.magic40,
                ),
              ),
            ),
            Expanded(
              child: Scrollbar(
                child: SingleChildScrollView(
                  child: Container(
                    height: MediaQuery.of(context).size.height - 200, // Adjust height as needed
                    child: spellbook.SpellGridWidget(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


/*
class SpellbookPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scrollbarTheme: ScrollbarThemeData(
          thumbColor: MaterialStateProperty.all(Color.fromRGBO(225, 175, 209, 1)),
          trackColor: MaterialStateProperty.all(MyColors.secondary),
          radius: Radius.circular(10),
          thickness: MaterialStateProperty.all(10.0),
        ),
      ),
      home: Scaffold(
        backgroundColor: MyColors.background,
        body: Column(
          children: [
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  "Spellbook",
                  style: MyStyles.magic40,
                ),
              ),
            ),
            Expanded(
              child: Scrollbar(
                child: SingleChildScrollView(
                  child: spellbook.SpellGridWidget(), // Clean call to the widget
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
*/


/*
class SpellbookPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scrollbarTheme: ScrollbarThemeData(
          thumbColor: MaterialStateProperty.all(Color.fromRGBO(225, 175, 209, 1)),
          trackColor: MaterialStateProperty.all(MyColors.secondary),
          radius: Radius.circular(10),
          thickness: MaterialStateProperty.all(10.0),
        ),
      ),
      home: Scaffold(
        backgroundColor: MyColors.background,
        body: Column(
          children: [
            SafeArea(
              child: welcome.PageTitleWidget(title: "Spellbook"),
            ),
            Expanded(
              child: Scrollbar(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: spellbook.SpellbookGrid(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
*/