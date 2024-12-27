import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hocus_focus/styles/colors.dart';
import 'package:hocus_focus/styles/styles.dart';
import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hocus_focus/sqflite_helper.dart';
import 'package:hocus_focus/cache.dart';



class ShopWidgets extends StatefulWidget {
  @override
  _ShopPageWidgetsState createState() => _ShopPageWidgetsState();
}

class _ShopPageWidgetsState extends State<ShopWidgets> {
  String selectedCategory = "Wand";
  List<Map<String, dynamic>> items = [];

  @override
  void initState() {
    super.initState();
    fetchItems();
  }

  Future<void> fetchItems() async {
    String type = selectedCategory.toLowerCase();
    DatabaseHelper dbHelper = DatabaseHelper();
    final fetchedItems = await dbHelper.getItemsOfType(type);
    setState(() {
      items = fetchedItems;
    });
  }

  String formatItemName(String name) {
    return name
        .replaceAll('_', ' ')
        .split(' ')
        .map((word) => word[0].toUpperCase() + word.substring(1))
        .join(' ');
  }

  void showItemPopup(Map<String, dynamic> item) async {
    DatabaseHelper dbHelper = DatabaseHelper();
    bool isBought = await dbHelper.isItemBought(item['name']);

    showDialog(
      context: this.context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: MyColors.background, // Custom background color
          title: Text(
            formatItemName(item['name']),
            style: MyStyles.magic24,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                item['asset'],
                width: 150,
                height: 150,
              ),
              SizedBox(height: 16),
              Text(
                "Cost: ${item['cost']} coins",
                style: MyStyles.magic24,
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: isBought
                        ? null
                        : () async {
                            buyItem(item['name']);
                            isBought = await dbHelper.isItemBought(item['name']);
                            setState(() {});
                            Navigator.pop(context);
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          isBought ? Colors.grey : MyColors.secondary,
                    ),
                    child: Text("Buy", style: MyStyles.magic14),
                  ),
                  ElevatedButton(
                    onPressed: isBought
                        ? () async {
                            await dbHelper.selectItem(
                                item['name'], selectedCategory.toLowerCase());
                            Navigator.pop(context);
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          isBought ? MyColors.secondary : Colors.grey,
                    ),
                    child: Text("Select", style: MyStyles.magic14),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
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
                  label: 'Wand',
                  isSelected: selectedCategory == "Wand",
                  onTap: () {
                    setState(() {
                      selectedCategory = "Wand";
                    });
                    fetchItems();
                  },
                ),
                CategoryButton(
                  label: 'Cloak',
                  isSelected: selectedCategory == "Cloak",
                  onTap: () {
                    setState(() {
                      selectedCategory = "Cloak";
                    });
                    fetchItems();
                  },
                ),
                CategoryButton(
                  label: 'Hat',
                  isSelected: selectedCategory == "Hat",
                  onTap: () {
                    setState(() {
                      selectedCategory = "Hat";
                    });
                    fetchItems();
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
                itemCount: items.length + 12, // Added 4 more rows (3 items/row)
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                ),
                itemBuilder: (context, index) {
                  if (index < items.length) {
                    // Render existing items
                    final item = items[index];
                    return GestureDetector(
                      onTap: () => showItemPopup(item),
                      child: Container(
                        decoration: BoxDecoration(
                          color: MyColors.primary,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: SvgPicture.asset(
                            item['asset'],
                            width: 150,
                            height: 150,
                          ),
                        ),
                      ),
                    );
                  } else {
                    // Render placeholders for future items
                    return Container(
                      decoration: BoxDecoration(
                        color: MyColors.secondary,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Icon(
                          Icons.add,
                          color: MyColors.primary,
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}




/*
class _ShopPageWidgetsState extends State<ShopWidgets> {
  String selectedCategory = "Wand";
  List<Map<String, dynamic>> items = [];

  @override
  void initState() {
    super.initState();
    fetchItems();
  }

  Future<void> fetchItems() async {
    String type = selectedCategory.toLowerCase();
    DatabaseHelper dbHelper = DatabaseHelper();
    final fetchedItems = await dbHelper.getItemsOfType(type);
    setState(() {
      items = fetchedItems;
    });
  }

  void showItemPopup(Map<String, dynamic> item) async {
    DatabaseHelper dbHelper = DatabaseHelper();
    bool isBought = await dbHelper.isItemBought(item['name']);

    showDialog(
      context: this.context,
      builder: (context) {
        return AlertDialog(
          title: Text(item['name'], style: MyStyles.magic24),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                item['asset'],
                width: 150,
                height: 150,
              ),
              SizedBox(height: 16),
              Text(
                "Cost: ${item['cost']} coins",
                style: MyStyles.magic24,
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: isBought
                        ? null // Disable button if item is bought
                        : () async {
                            buyItem(item['name']);
                            isBought = await dbHelper.isItemBought(item['name']);
                            setState(() {}); // Refresh UI
                            Navigator.pop(context); // Close the dialog
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          isBought ? Colors.grey : MyColors.secondary, // Grey if bought
                    ),
                    child: Text("Buy", style: MyStyles.magic14),
                  ),
                  ElevatedButton(
                    onPressed: isBought
                        ? () async {
                            await dbHelper.selectItem(
                                item['name'], selectedCategory.toLowerCase());
                            Navigator.pop(context); // Close the dialog
                          }
                        : null, // Disable button if item is not bought
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          isBought ? MyColors.secondary : Colors.grey, // Grey if not bought
                    ),
                    child: Text("Select", style: MyStyles.magic14),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
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
                  label: 'Wand',
                  isSelected: selectedCategory == "Wand",
                  onTap: () {
                    setState(() {
                      selectedCategory = "Wand";
                    });
                    fetchItems();
                  },
                ),
                CategoryButton(
                  label: 'Cloak',
                  isSelected: selectedCategory == "Cloak",
                  onTap: () {
                    setState(() {
                      selectedCategory = "Cloak";
                    });
                    fetchItems();
                  },
                ),
                CategoryButton(
                  label: 'Hat',
                  isSelected: selectedCategory == "Hat",
                  onTap: () {
                    setState(() {
                      selectedCategory = "Hat";
                    });
                    fetchItems();
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
              child: items.isEmpty
                  ? Center(child: Text('No items found'))
                  : GridView.builder(
                      itemCount: items.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 10.0,
                        mainAxisSpacing: 10.0,
                      ),
                      itemBuilder: (context, index) {
                        final item = items[index];
                        return GestureDetector(
                          onTap: () => showItemPopup(item), // Show popup on tap
                          child: Container(
                            decoration: BoxDecoration(
                              color: MyColors.primary,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: SvgPicture.asset(
                                item['asset'],
                                width: 50,
                                height: 50,
                              ),
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

*/



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
          style: TextStyle(
            color: isSelected ? Color(0xff000000) : Colors.grey,
            fontFamily: 'AvolisseDEMO',
            fontSize: 14,
            letterSpacing: 0,
            fontWeight: FontWeight.normal,
            height: 1,
          ),
        ),
      ),
    );
  }
}




/*
class ShopWidgets extends StatefulWidget {
  @override
  _ShopPageWidgetsState createState() => _ShopPageWidgetsState();
}

class _ShopPageWidgetsState extends State<ShopWidgets> {
  // List of items for each category
  List<String> wands = List.generate(12, (index)=> "Wand ${index + 1}");
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
*/
