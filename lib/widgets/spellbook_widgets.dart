import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hocus_focus/styles/colors.dart';
import 'package:hocus_focus/styles/styles.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hocus_focus/sqflite_helper.dart';
import 'package:hocus_focus/cache.dart';

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
    int level = getLevel(exp);

    // Fetch spells from the database
    List<Map<String, dynamic>> fetchedSpells = await dbHelper.getSpells();

    for (var spell in fetchedSpells) {
      int requiredLevel = spell['requiredLevel'] ?? 100;
      bool isUnlocked = spell['unlocked'] == 1;

      // Check if spell needs to be unlocked
      if (level >= requiredLevel && !isUnlocked) {
        await dbHelper.unlockSpell(spell['name']);
      }
    }

    // Refresh the spell list after updating
    fetchedSpells = await dbHelper.getSpells();

    setState(() {
      playerLevel = level;
      spells = fetchedSpells;
    });
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
              crossAxisSpacing: 20.0,
            ),
            itemCount: spells.length,
            itemBuilder: (context, index) {
              final spell = spells[index];
              //bool isUnlocked = playerLevel >= (spell['requiredLevel'] ?? 0);

              return SpellslotWidget(
                spellName: spell['name']?.replaceAll('_', ' ') ??
                    'Unknown Spell', // Format the name
                assetPath: spell['asset'] ?? '', // Pass the asset path
                requiredLevel: spell['requiredLevel'] != null
                    ? int.tryParse(spell['requiredLevel'].toString()) ?? 0
                    : 0,
                playerLevel: playerLevel,
                isUnlocked: playerLevel >= (spell['requiredLevel'] ?? 100),
                description: spell['description'] ?? 'No description available',
              );
            },
          );
  }
}

class SpellslotWidget extends StatelessWidget {
  final String spellName;
  final String assetPath;
  final int requiredLevel;
  final int playerLevel;
  final bool isUnlocked;
  final String description;

  SpellslotWidget({
    required this.spellName,
    required this.assetPath,
    required this.requiredLevel,
    required this.playerLevel,
    required this.isUnlocked,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
  return GestureDetector(
    onTap: () {
      if (isUnlocked) {
        _showSpellPopup(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(
                  'You need to reach level $requiredLevel to unlock this spell!')),
        );
      }
    },
    child: Container(
      width: 170,
      height: 161,
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        boxShadow: [MyStyles.boxShadowBasic],
        color: MyColors.details,
        border: Border.all(
          color: Colors.black,
          width: 1,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 140,
            height: 115,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: MyColors.primary,
              border: Border.all(
                color: isUnlocked ? Colors.green : Colors.red.withOpacity(0.6),
                width: 2,
              ),
            ),
            child: Center(
              child: Opacity(
                opacity: isUnlocked ? 1.0 : 0.5,
                child: SvgPicture.asset(
                  assetPath,
                  width: 80,
                  height: 80,
                  placeholderBuilder: (context) => CircularProgressIndicator(),
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          Container(
            width: 140,
            height: 26,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: MyColors.primary,
              border: Border.all(color: Colors.black, width: 1),
            ),
            child: Center(
              child: Text(
                spellName,
                textAlign: TextAlign.center,
                style: MyStyles.magic14,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

  void _showSpellPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: MyColors.background, // Change background color
        title: Text(spellName, style: MyStyles.magic24),
        contentPadding: EdgeInsets.all(20), // Add padding to prevent cutoff
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(assetPath, width: 150, height: 150),
            SizedBox(height: 10),
            Text(description, style: MyStyles.magic14),
          ],
        ),
        actionsPadding:
            EdgeInsets.only(bottom: 20), // Add padding for the button
        actions: [
          Align(
            alignment: Alignment.bottomCenter, // Align button to the left
            child: ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              style: ElevatedButton.styleFrom(
                backgroundColor: MyColors.secondary, // Button color
                foregroundColor: Colors.black, // Text color
              ),
              child: Text('Close', style: MyStyles.magic14),
            ),
          ),
        ],
      ),
    );
  }
}
