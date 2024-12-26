import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hocus_focus/styles/colors.dart';
import 'package:hocus_focus/styles/styles.dart';
import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hocus_focus/sqflite_helper.dart';


class ShopWidgets extends StatefulWidget {
  @override
  _ShopPageWidgetsState createState() => _ShopPageWidgetsState();
}

class _ShopPageWidgetsState extends State<ShopWidgets> {
  // List of items for each category
  List<String> wands = [];
  final List<String> cloaks = List.generate(12, (index) => "Cloak ${index + 1}");
  final List<String> hats = List.generate(12, (index) => "Hat ${index + 1}");

  @override
  void initState() {
    super.initState();
    _loadWands();
  }

  Future<void> _loadWands() async {
    final dbHelper = DatabaseHelper();
    wands = (await dbHelper.getWands()).map((wand) => wand['name'] as String).toList();
    setState(() {});
  }

  String selectedCategory = "Wands";

  @override
  Widget build(BuildContext context) {
    List<String> items;
    if (selectedCategory == "Wands") {
      items = wands;
    } else if (selectedCategory == "Cloaks") {
      items = cloaks;
    } else {
      items = hats;
    }

    return Scaffold(
      body: Column(
        children: [
          // Category Buttons
          Container(
            color: MyColors.background,
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CategoryButton(
                  label: 'Wands',
                  isSelected: selectedCategory == "Wands",
                  onTap: () {
                    setState(() {
                      selectedCategory = "Wands";
                    });
                  },
                ),
                CategoryButton(
                  label: 'Cloaks',
                  isSelected: selectedCategory == "Cloaks",
                  onTap: () {
                    setState(() {
                      selectedCategory = "Cloaks";
                    });
                  },
                ),
                CategoryButton(
                  label: 'Hats',
                  isSelected: selectedCategory == "Hats",
                  onTap: () {
                    setState(() {
                      selectedCategory = "Hats";
                    });
                  },
                ),
              ],
            ),
          ),
          // Items Grid
          Expanded(
            child: Container(
              color: MyColors.details,
              padding: EdgeInsets.all(8.0),
              child: GridView.builder(
                itemCount: items.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                ),
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      color: MyColors.primary,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        items[index],
                        textAlign: TextAlign.center,
                        style: MyStyles.magic14
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CategoryButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  CategoryButton({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: isSelected ? MyColors.secondary : MyColors.primary,
          borderRadius: MyStyles.roundBox8,
          border: Border.all(color: Colors.black),
        ),
        child: Text(
          label,
          style:TextStyle(
            color: isSelected ? Color(0xff000000) : Colors.grey,
            fontFamily: 'AvolisseDEMO',
            fontSize: 14,
            letterSpacing: 0,
            fontWeight: FontWeight.normal,
            height: 1),
        ),
      ),
    );
  }
}

