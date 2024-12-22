import 'package:flutter/material.dart';
import 'package:hocus_focus/styles/colors.dart';
import 'package:hocus_focus/styles/styles.dart';
import 'package:hocus_focus/widgets/bar_widgets.dart';
import 'package:hocus_focus/widgets/spellbook_widgets.dart';


class SpellbookPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // List of different spell names
    List<String> spellNames = [
      'Fireball', 'Lightning Bolt', 'Healing Touch', 'Ice Storm', 'Teleport', 
      'Summon Familiar', 'Shield', 'Magic Missile', 'Misty Step', 'Counterspell',
      'Arcane Blast', 'Blight', 'Invisibility', 'Dispel Magic', 'Flamestrike',
      'Greater Heal', 'Polymorph', 'Wall of Force', 'Fly', 'Divine Light'
    ];

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
                            style: MyStyles.magic40,
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
                              itemCount: spellNames.length, // Using the length of the spellNames list
                              itemBuilder: (BuildContext context, int index) {
                                // Pass the spell name from the list
                                return SpellslotWidget(spellName: spellNames[index]);
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
                                return SpellslotWidget(spellName: "Pookie juice");
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

*/