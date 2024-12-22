import 'package:flutter/material.dart';
import 'package:hocus_focus/styles/colors.dart';
import 'package:hocus_focus/styles/styles.dart';
import 'package:hocus_focus/widgets/bar_widgets.dart';
import 'package:hocus_focus/widgets/spellbook_widgets.dart';

class SpellbookPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scrollbarTheme: ScrollbarThemeData(
          thumbColor: MaterialStateProperty.all(Color.fromRGBO(225, 175, 209, 1)), // Set the thumb color
          trackColor: MaterialStateProperty.all(MyColors.secondary), // Set the track color
          radius: Radius.circular(10), // Rounded corners
          thickness: MaterialStateProperty.all(10.0), // Thickness of the scrollbar
        ),
      ),
      home: Scaffold(
        backgroundColor: MyColors.background,
        body: Column(
          children: [
            TopBarWidget(), // Top bar remains at the top
            Expanded(
              child: Scrollbar(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20.0), // Add space to move the scrollbar down
                    child: Column(
                      children: [
                        // Title "Spellbook" above the spell slots
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20.0), // Add vertical spacing around the title
                          child: Text(
                            'Spellbook',
                            style: MyStyles.magic40
                          ),
                        ),
                        // Spell slots (your GridView)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: GridView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 10.0,
                                crossAxisSpacing: 20.0,
                                childAspectRatio: 1.0,
                              ),
                              itemCount: 20,
                              itemBuilder: (BuildContext context, int index) {
                                return SpellslotWidget();
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
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
          thumbColor: MaterialStateProperty.all(Color.fromRGBO(225, 175, 209, 1)), // Set the thumb color
          trackColor: MaterialStateProperty.all(MyColors.secondary), // Set the track color
          radius: Radius.circular(10), // Rounded corners
          thickness: MaterialStateProperty.all(10.0), // Thickness of the scrollbar
        ),
      ),
      home: Scaffold(
        backgroundColor: MyColors.background,
        body: Column(
          children: [
            TopBarWidget(), // Top bar remains at the top
            Expanded(
              child: Scrollbar(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20.0), // Add a little space before the scrollbar
                    child: Column(
                      children: [
                        SizedBox(height: 10),  // Some space below the top bar
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 23.0),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: GridView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 10.0,
                                crossAxisSpacing: 20.0,
                                childAspectRatio: 1.0,
                              ),
                              itemCount: 20,
                              itemBuilder: (BuildContext context, int index) {
                                return SpellslotWidget();
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
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
    return Scaffold(
      body: SingleChildScrollView(  // Wrap the entire body in a SingleChildScrollView
        child: Column(
          children: [
            TopBarWidget(),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 23.0), // Adjust padding as needed
              child: Align(
                alignment: Alignment.centerRight,  // Align the GridView to the right
                child: GridView.builder(
                  shrinkWrap: true,  // This ensures that GridView takes up only the space it needs
                  physics: NeverScrollableScrollPhysics(),  // Disable GridView's own scrolling
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Two columns
                    mainAxisSpacing: 10.0, // Space between rows
                    crossAxisSpacing: 20.0, // Space between columns
                    childAspectRatio: 1.0, // Adjust for aspect ratio of the widgets
                  ),
                  itemCount: 20, // Replace with the number of SpellslotWidgets you want to display
                  itemBuilder: (BuildContext context, int index) {
                    return SpellslotWidget(); // Replace with your custom widget
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      //bottomNavigationBar: BottomBarWidget(),
    );
  }
}
*/*/