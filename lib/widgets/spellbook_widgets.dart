import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hocus_focus/styles/colors.dart';
import 'package:hocus_focus/styles/styles.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hocus_focus/sqflite_helper.dart'; 
import 'package:hocus_focus/cache.dart';


/*
class SpellGridWidget extends StatefulWidget {
  @override
  _SpellGridWidgetState createState() => _SpellGridWidgetState();
}

class _SpellGridWidgetState extends State<SpellGridWidget> {
  List<Map<String, dynamic>> spells = [];
  int playerLevel = 1;

  @override
  void initState() {
    super.initState();
    fetchSpellsAndUpdate();
  }

  Future<void> fetchSpellsAndUpdate() async {
    var dbHelper = DatabaseHelper();

    // Fetch player experience and calculate level
    int exp = await dbHelper.getProfileExp();
    int level = getLevel(exp); // Assume getLevel is imported

    // Fetch spells from the database
    List<Map<String, dynamic>> fetchedSpells = await dbHelper.getSpells();

    setState(() {
      playerLevel = level;
      spells = fetchedSpells;
    });

    print("Fetched spells: $spells");
  }

  @override
  Widget build(BuildContext context) {
    return spells.isEmpty
        ? Center(child: CircularProgressIndicator())
        : GridView.builder(
            padding: const EdgeInsets.all(8.0),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 10.0,
            ),
            itemCount: spells.length,
            itemBuilder: (context, index) {
              final spell = spells[index];
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: MyColors.primary,
                  border: Border.all(color: Colors.black, width: 1),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      spell['asset'],
                      width: 80,
                      height: 80,
                      placeholderBuilder: (context) => CircularProgressIndicator(),
                    ),
                    SizedBox(height: 10),
                    Text(
                      spell['name'],
                      style: MyStyles.magic14,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            },
          );
  }
}
*/

class SpellGridWidget extends StatefulWidget {
  @override
  _SpellGridWidgetState createState() => _SpellGridWidgetState();
}

class _SpellGridWidgetState extends State<SpellGridWidget> {
  List<Map<String, dynamic>> spells = [];
  int playerLevel = 1;

  @override
  void initState() {
    super.initState();
    fetchSpellsAndUpdate();
  }

  Future<void> fetchSpellsAndUpdate() async {
    var dbHelper = DatabaseHelper();

    // Fetch player experience and calculate level
    int exp = await dbHelper.getProfileExp();
    int level = getLevel(exp); // Assume getLevel is imported

    // Fetch spells from the database
    List<Map<String, dynamic>> fetchedSpells = await dbHelper.getSpells();

    setState(() {
      playerLevel = level;
      spells = fetchedSpells;
    });

    print("Fetched spells: $spells");
  }

  @override
  Widget build(BuildContext context) {
    return spells.isEmpty
        ? Center(child: CircularProgressIndicator())
        : GridView.builder(
            padding: const EdgeInsets.all(8.0),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 10.0,
            ),
            itemCount: spells.length,
            itemBuilder: (context, index) {
              final spell = spells[index];
              bool isUnlocked = playerLevel >= (spell['requiredLevel'] ?? 0);

              return SpellslotWidget(
                spellName: spell['name']?.replaceAll('_', ' ') ?? 'Unknown Spell', // Format the name
                assetPath: spell['asset'] ?? '', // Pass the asset path
                isUnlocked: isUnlocked, // Pass unlocked status
              );
            },
          );
  }
}

class SpellslotWidget extends StatelessWidget {
  final String spellName;
  final String assetPath;
  final bool isUnlocked;

  SpellslotWidget({
    this.spellName = 'Spell Name',
    this.assetPath = '',
    this.isUnlocked = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: MyColors.primary,
        boxShadow: [MyStyles.boxShadowBasic],
        border: Border.all(
          color: isUnlocked ? Colors.green : Colors.red.withOpacity(0.6),
          width: 2,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Opacity(
            opacity: isUnlocked ? 1.0 : 0.5,
            child: SvgPicture.asset(
              assetPath,
              width: 80,
              height: 80,
              placeholderBuilder: (context) => CircularProgressIndicator(),
            ),
          ),
          SizedBox(height: 10),
          Text(
            spellName,
            style: MyStyles.magic14,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
/// A widget for displaying the page title.
class PageTitleWidget extends StatelessWidget {
  final String title;

  PageTitleWidget({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Text(
        title,
        style: MyStyles.magic40,
      ),
    );
  }
}

class SpellbookGrid extends StatelessWidget {
  final List<Map<String, dynamic>> spells;

  SpellbookGrid({required this.spells});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10.0,
          crossAxisSpacing: 20.0,
          childAspectRatio: 1.0,
        ),
        itemCount: spells.length,
        itemBuilder: (BuildContext context, int index) {
          final spell = spells[index];
          final isUnlocked = spell['unlocked'] == 1;

          return SpellslotWidget(
            spellName: spell['name'].replaceAll('_', ' '), // Format the name
            assetPath: spell['asset'], // Pass the asset path
            isUnlocked: isUnlocked, // Pass unlocked status
          );
        },
      ),
    );
  }
}





/*
class SpellslotWidget extends StatelessWidget {
  final String spellName;
  final String assetPath;
  final bool isUnlocked;

  SpellslotWidget({
    this.spellName = 'Spell Name',
    this.assetPath = '',
    this.isUnlocked = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: MyColors.details,
        boxShadow: [MyStyles.boxShadowBasic],
        border: Border.all(
          color: isUnlocked ? Colors.green : Colors.red.withOpacity(0.6),
          width: 2,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Opacity(
            opacity: isUnlocked ? 1.0 : 0.4,
            child: SvgPicture.asset(
              assetPath, // Use the assetPath
              width: 80,
              height: 80,
              placeholderBuilder: (context) => CircularProgressIndicator(),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            spellName,
            style: MyStyles.magic14,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
*/






/*
/// A single spell slot widget for displaying a spell name.
class SpellslotWidget extends StatelessWidget {
  final String spellName;

  SpellslotWidget({this.spellName = 'Spell Name'});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 170,
      height: 161,
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
            child: Container(
              width: 170,
              height: 161,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                boxShadow: [MyStyles.boxShadowBasic],
                color: MyColors.details,
                border: Border.all(color: Color.fromRGBO(0, 0, 0, 1), width: 1),
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
                borderRadius: BorderRadius.circular(10),
                color: MyColors.primary,
                border: Border.all(color: Color.fromRGBO(0, 0, 0, 1), width: 1),
              ),
            ),
          ),
          Positioned(
            top: 131,
            left: 15,
            child: Container(
              width: 140,
              height: 26,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: MyColors.primary,
                border: Border.all(color: Color.fromRGBO(0, 0, 0, 1), width: 1),
              ),
              child: Center(
                child: Text(
                  spellName,
                  textAlign: TextAlign.center,
                  style: MyStyles.magic14,
                ),
              ),
            ),
          ),
          Positioned(
            top: 12,
            left: 18.5,
            child: SvgPicture.asset(
              'assets/images/vector12.svg',
              semanticsLabel: 'vector12',
            ),
          ),
        ],
      ),
    );
  }
}

/// A widget for displaying the page title.
class PageTitleWidget extends StatelessWidget {
  final String title;

  PageTitleWidget({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Text(
        title,
        style: MyStyles.magic40,
      ),
    );
  }
}

/// A widget for displaying the entire spellbook grid.
class SpellbookGrid extends StatelessWidget {
  SpellbookGrid();

  @override
  Widget build(BuildContext context) {
    // Default to 20 spell slots for now.
    int numberOfSpells = 20;

    return Padding(
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
          itemCount: numberOfSpells, // Total number of spell slots
          itemBuilder: (BuildContext context, int index) {
            return SpellslotWidget(); // Always default to "Spell Name"
          },
        ),
      ),
    );
  }
}

*/




