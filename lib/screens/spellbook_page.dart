import 'package:flutter/material.dart';
import 'package:hocus_focus/styles/colors.dart';
import 'package:hocus_focus/styles/styles.dart';
import 'package:hocus_focus/widgets/spellbook_widgets.dart' as spellbook;

class SpellbookPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        scrollbarTheme: ScrollbarThemeData(
          thumbColor: MaterialStateProperty.all(MyColors.primary),
          trackColor: MaterialStateProperty.all(MyColors.secondary),
          radius: Radius.circular(10),
          thickness: MaterialStateProperty.all(10.0),
        ),
      ),
      child: Scaffold(
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
