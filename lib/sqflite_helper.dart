import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

const databaseFileName = "hocus_focus.db";

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), databaseFileName);

    // Uncomment the next line only if you want the _onCreate function to be called on every app start
    //await deleteDatabase(path);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute(
      'CREATE TABLE task(id INTEGER PRIMARY KEY AUTOINCREMENT, description TEXT, completed INTEGER)',
    );

    await db.execute(
      'CREATE TABLE item(name TEXT PRIMARY KEY, asset TEXT, type TEXT, cost INTEGER, bought INTEGER DEFAULT 0)',
    );

    await db.execute(
        'CREATE TABLE profile(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, exp INTEGER, coins INTEGER, cloak TEXT DEFAULT "cloak", hat TEXT DEFAULT "", wand TEXT DEFAULT "", total_tasks INTEGER DEFAULT 0, total_events INTEGER DEFAULT 0, total_coins INTEGER DEFAULT 0, total_hours INTEGER DEFAULT 0)');

    await db.execute(
        'CREATE TABLE event(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, description TEXT, start_date TEXT, end_date TEXT, difficulty INTEGER)');

    await db.execute(
        'CREATE TABLE stats_date(date TEXT PRIMARY KEY, counter INTEGER DEFAULT 0)');

    await db.execute(
        'CREATE TABLE spell(name TEXT PRIMARY KEY, asset TEXT, description TEXT, requiredLevel INTEGER, unlocked INTEGER DEFAULT 0)');

    // populate with items
    await db.insert('item', {
      'name': 'purple_hat',
      'asset': 'assets/images/items/purple_hat.svg',
      'type': 'hat',
      'cost': 100
    });
    await db.insert('item', {
      'name': 'red_hat',
      'asset': 'assets/images/items/red_hat.svg',
      'type': 'hat',
      'cost': 100
    });
    await db.insert('item', {
      'name': 'green_hat',
      'asset': 'assets/images/items/green_hat.svg',
      'type': 'hat',
      'cost': 100
    });
    await db.insert('item', {
      'name': 'purple_cloak',
      'asset': 'assets/images/items/purple_cloak.svg',
      'type': 'cloak',
      'cost': 150
    });
    await db.insert('item', {
      'name': 'red_cloak',
      'asset': 'assets/images/items/red_cloak.svg',
      'type': 'cloak',
      'cost': 150
    });
    await db.insert('item', {
      'name': 'green_cloak',
      'asset': 'assets/images/items/green_cloak.svg',
      'type': 'cloak',
      'cost': 150
    });
    await db.insert('item', {
      'name': 'yellow_wand',
      'asset': 'assets/images/items/yellow_wand.svg',
      'type': 'wand',
      'cost': 200
    });
    await db.insert('item', {
      'name': 'blue_wand',
      'asset': 'assets/images/items/blue_wand.svg',
      'type': 'wand',
      'cost': 200
    });
    await db.insert('item', {
      'name': 'red_wand',
      'asset': 'assets/images/items/red_wand.svg',
      'type': 'wand',
      'cost': 200
    });

    // Populate spells table
    await db.insert('spell', {
      'name': 'fireball_spell',
      'asset': 'assets/images/spells/fireball_spell.svg',
      'description': 'A true classic. The mighty fireball spell.',
      'requiredLevel': 1
    });

    await db.insert('spell', {
      'name': 'strength_spell',
      'asset': 'assets/images/spells/strength_spell.svg',
      'description': 'A spell that increases your strength.',
      'requiredLevel': 5
    });

    await db.insert('spell', {
      'name': 'swiftness_spell',
      'asset': 'assets/images/spells/swiftness_spell.svg',
      'description': 'A spell that increases your speed.',
      'requiredLevel': 10
    });
  }

  // function to check if the profile table is empty
  Future<bool> isDatabaseCreated() async {
    final db = await database;
    final List<Map<String, dynamic>> request = await db.query('profile');
    return request.isNotEmpty;
  }

  Future<void> insertTask(String description, bool completed) async {
    //db is the instance of the database that we get from the openMyDatabase function.
    final db = await database;
    //We use ConflictAlgorithm.replace to replace the task if it already exists.
    //here we don't need to insert the id column because it is set to autoincrement.
    db.insert(
        'task',
        {
          'description': description,
          'completed': completed ? 1 : 0,
        },
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  // function to get uncompleted tasks from table task
  Future<List<Map<String, dynamic>>> getUncompletedTasks() async {
    final db = await database;
    return await db.query('task', where: 'completed = ?', whereArgs: [0]);
  }

  Future<void> createNewProfile(String name) async {
    final db = await database;
    db.insert('profile', {'name': name, 'exp': 0, 'coins': 0},
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> createNewEvent(String name, String description, String startDate,
      String endDate, int difficulty) async {
    final db = await database;
    db.insert(
        'event',
        {
          'name': name,
          'description': description,
          'start_date': startDate,
          'end_date': endDate,
          'difficulty': difficulty
        },
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> deleteEvent(int id) async {
    final db = await database;
    db.delete('event', where: 'id = ?', whereArgs: [id]);
  }

  Future<String> getProfileName() async {
    final db = await database;
    final List<Map<String, dynamic>> request = await db.query('profile');
    return request[0]['name'];
  }

  Future<int> getProfileExp() async {
    final db = await database;
    final List<Map<String, dynamic>> request = await db.query('profile');
    return request[0]['exp'];
  }

  Future<int> getProfileCoins() async {
    final db = await database;
    final List<Map<String, dynamic>> request = await db.query('profile');
    return request[0]['coins'];
  }

  Future<String> getSelectedCloakPath() async {
    final db = await database;
    final List<Map<String, dynamic>> request = await db.query('profile');
    return "assets/images/wizard/${request[0]['cloak']}.svg";
  }

  Future<String> getSelectedHatPath() async {
    final db = await database;
    final List<Map<String, dynamic>> request = await db.query('profile');
    return "assets/images/wizard/${request[0]['hat']}.svg";
  }

  Future<String> getSelectedWandPath() async {
    final db = await database;
    final List<Map<String, dynamic>> request = await db.query('profile');
    print("Wand where are you? ${request[0]}");
    return "assets/images/wizard/${request[0]['wand']}.svg";
  }

  Future<void> insertItem(
      String name, String asset, String type, int cost) async {
    final db = await database;
    db.insert(
        'item',
        {
          'name': name,
          'asset': asset,
          'type': type,
          'cost': cost,
        },
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> deleteTask(int id) async {
    final db = await database;
    //delete method takes two arguments: the name of the table and the where clause.
    //we are using unique id for each task as the where clause to delete the task with the given id.
    db.delete('task', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> updateTask(int id, bool completed) async {
    final db = await database;
    db.update(
        'task',
        {
          'completed': completed ? 1 : 0,
        },
        where: 'id = ?',
        whereArgs: [id]);
  }

  Future<void> updateItemBought(String name) async {
    final db = await database;
    db.update('item', {'bought': 1}, where: 'name = ?', whereArgs: [name]);
  }

  Future<void> selectItem(String item, String type) async {
    final db = await database;
    print("selecting $item of type $type");
    db.update('profile', {type: item}, where: 'id = ?', whereArgs: [1]);
  }

  Future<void> addProfileExp(int exp) async {
    final db = await database;
    final List<Map<String, dynamic>> request = await db.query('profile');
    db.update('profile', {'exp': request[0]['exp'] + exp},
        where: 'id = ?', whereArgs: [1]);
  }

  Future<void> addProfileCoins(int coins) async {
    final db = await database;
    final List<Map<String, dynamic>> request = await db.query('profile');
    db.update('profile', {'coins': request[0]['coins'] + coins},
        where: 'id = ?', whereArgs: [1]);
  }

  Future<List<Map<String, dynamic>>> getTasks() async {
    final db = await database;
    //returns a list of maps where each map represents a task.
    //like [{id: 1, title: 'Task 1', status: 1}, {id: 2, title: 'Task 2', status: 0}]
    return await db.query('task');
  }

  // function to get all events from database
  Future<List<Map<String, dynamic>>> getEvents() async {
    final db = await database;
    return await db.query('event');
  }

  Future<List<Map<String, dynamic>>> getItems() async {
    final db = await database;
    return await db.query('item');
  }

  Future<List<Map<String, dynamic>>> getProfiles() async {
    final db = await database;
    return await db.query('profile');
  }

  Future<List<String>> getItemAssetsOfType(String type) async {
    final db = await database;
    final List<Map<String, dynamic>> maps =
        await db.query('item', where: 'type = ?', whereArgs: [type]);
    return List.generate(maps.length, (i) {
      return maps[i]['asset'];
    });
  }

  Future<List<String>> getWizardAssetsOfType(String type) async {
    final db = await database;
    final List<Map<String, dynamic>> maps =
        await db.query('item', where: 'type = ?', whereArgs: [type]);
    return List.generate(maps.length, (i) {
      return maps[i]['asset']
          .replaceAll('assets/images/items/', 'assets/images/wizard/');
    });
  }

  // function to get all 'total_*' values from profile
  Future<Map<String, int>> getProfileTotals() async {
    final db = await database;
    final List<Map<String, dynamic>> request = await db.query('profile');
    return {
      "total_tasks": request[0]['total_tasks'],
      "total_events": request[0]['total_events'],
      "total_coins": request[0]['total_coins'],
      "total_hours": request[0]['total_hours']
    };
  }

  // function to increate total_tasks in profile
  Future<void> increaseTotalTasks() async {
    final db = await database;
    final List<Map<String, dynamic>> request = await db.query('profile');
    db.update('profile', {'total_tasks': request[0]['total_tasks'] + 1},
        where: 'id = ?', whereArgs: [1]);
  }

  // function to decrease total_tasks in profile
  Future<void> decreaseTotalTasks() async {
    final db = await database;
    final List<Map<String, dynamic>> request = await db.query('profile');
    db.update('profile', {'total_tasks': request[0]['total_tasks'] - 1},
        where: 'id = ?', whereArgs: [1]);
  }

  // function to increase total_events in profile
  Future<void> increaseTotalEvents() async {
    final db = await database;
    final List<Map<String, dynamic>> request = await db.query('profile');
    db.update('profile', {'total_events': request[0]['total_events'] + 1},
        where: 'id = ?', whereArgs: [1]);
  }

  // function to add total_coins in profile
  Future<void> addTotalCoins(int coins) async {
    final db = await database;
    final List<Map<String, dynamic>> request = await db.query('profile');
    db.update('profile', {'total_coins': request[0]['total_coins'] + coins},
        where: 'id = ?', whereArgs: [1]);
  }

  // function to add total_hours in profile
  Future<void> addTotalHours(int hours) async {
    final db = await database;
    final List<Map<String, dynamic>> request = await db.query('profile');
    db.update('profile', {'total_hours': request[0]['total_hours'] + hours},
        where: 'id = ?', whereArgs: [1]);
  }

  // function to add a new date to stats_date
  Future<void> addDateToStats(String date) async {
    final db = await database;
    db.insert('stats_date', {'date': date, 'counter': 0},
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  // function to add today's date to stats_date
  Future<void> addTodayToStats() async {
    final db = await database;
    final now = DateTime.now();
    final date = "${now.year}-${now.month}-${now.day}";
    db.insert('stats_date', {'date': date, 'counter': 0},
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  // function to increase counter for a date in stats_date
  Future<void> increaseDateCounter(String date) async {
    final db = await database;
    final List<Map<String, dynamic>> request =
        await db.query('stats_date', where: 'date = ?', whereArgs: [date]);
    db.update('stats_date', {'counter': request[0]['counter'] + 1},
        where: 'date = ?', whereArgs: [date]);
  }

  // function to add today to stats_date if it doesn't exist or increase counter if it does
  Future<void> increaseTodayOrAdd() async {
    final db = await database;
    final now = DateTime.now();
    final date = "${now.year}-${now.month}-${now.day}";
    final List<Map<String, dynamic>> request =
        await db.query('stats_date', where: 'date = ?', whereArgs: [date]);
    if (request.isEmpty) {
      db.insert('stats_date', {'date': date, 'counter': 1},
          conflictAlgorithm: ConflictAlgorithm.replace);
    } else {
      db.update('stats_date', {'counter': request[0]['counter'] + 1},
          where: 'date = ?', whereArgs: [date]);
    }
  }

  // function to increase counter for today in stats_date
  Future<void> increaseTodayCounter() async {
    final db = await database;
    final now = DateTime.now();
    final date = "${now.year}-${now.month}-${now.day}";
    final List<Map<String, dynamic>> request =
        await db.query('stats_date', where: 'date = ?', whereArgs: [date]);
    db.update('stats_date', {'counter': request[0]['counter'] + 1},
        where: 'date = ?', whereArgs: [date]);
  }

  // function to decrease counter for a date in stats_date
  Future<void> decreaseDateCounter(String date) async {
    final db = await database;
    final List<Map<String, dynamic>> request =
        await db.query('stats_date', where: 'date = ?', whereArgs: [date]);
    db.update('stats_date', {'counter': request[0]['counter'] - 1},
        where: 'date = ?', whereArgs: [date]);
  }

  // function to decrease counter for today in stats_date
  Future<void> decreaseTodayCounter() async {
    final db = await database;
    final now = DateTime.now();
    final date = "${now.year}-${now.month}-${now.day}";
    final List<Map<String, dynamic>> request =
        await db.query('stats_date', where: 'date = ?', whereArgs: [date]);
    db.update('stats_date', {'counter': request[0]['counter'] - 1},
        where: 'date = ?', whereArgs: [date]);
  }

  // function to add today to stats_date if it doesn't exist or decrease counter if it does
  Future<void> decreaseTodayOrAdd() async {
    final db = await database;
    final now = DateTime.now();
    final date = "${now.year}-${now.month}-${now.day}";
    final List<Map<String, dynamic>> request =
        await db.query('stats_date', where: 'date = ?', whereArgs: [date]);
    if (request.isEmpty) {
      db.insert('stats_date', {'date': date, 'counter': 0},
          conflictAlgorithm: ConflictAlgorithm.replace);
    } else {
      db.update('stats_date', {'counter': request[0]['counter'] - 1},
          where: 'date = ?', whereArgs: [date]);
    }
  }

  // function to get the counter of a specific date from stats_date or return 0 if it doesn't exist
  Future<int> getDateCounter(String date) async {
    final db = await database;
    final List<Map<String, dynamic>> request =
        await db.query('stats_date', where: 'date = ?', whereArgs: [date]);
    if (request.isEmpty) {
      return 0;
    } else {
      return request[0]['counter'];
    }
  }

  // function to get all stats_date
  Future<List<Map<String, dynamic>>> getStatsDates() async {
    final db = await database;
    return await db.query('stats_date');
  }

  ///***** Item and Spell functions *****///

  // function to get all spells from database
  Future<List<Map<String, dynamic>>> getSpells() async {
    final db = await database;
    final List<Map<String, dynamic>> spells = await db.query('spell');
    spells.forEach((spell) {
      print('Spell: ${spell['name']}, Required Level: ${spell['requiredLevel']}');
    });
    return spells;
  }

  // function to unlock a spell
  Future<void> unlockSpell(String name) async {
    final db = await database;
    db.update('spell', {'unlocked': 1}, where: 'name = ?', whereArgs: [name]);
  }

  // function to check if spell is unlocked
  Future<bool> isSpellUnlocked(String name) async {
    final db = await database;
    final List<Map<String, dynamic>> request =
        await db.query('spell', where: 'name = ?', whereArgs: [name]);
    return request[0]['unlocked'] == 1;
  }

  // function to check if item is bought
  Future<bool> isItemBought(String name) async {
    final db = await database;
    final List<Map<String, dynamic>> request =
        await db.query('item', where: 'name = ?', whereArgs: [name]);
    return request[0]['bought'] == 1;
  }

  // function set item as bought
  Future<void> setItemBought(String name) async {
    final db = await database;
    db.update('item', {'bought': 1}, where: 'name = ?', whereArgs: [name]);
  }

  // function to get the cost of an item
  Future<int> getItemCost(String name) async {
    final db = await database;
    final List<Map<String, dynamic>> request =
        await db.query('item', where: 'name = ?', whereArgs: [name]);
    return request[0]['cost'];
  }

  // function to get all items of a specific type
  Future<List<Map<String, dynamic>>> getItemsOfType(String type) async {
    final db = await database;
    return await db.query('item', where: 'type = ?', whereArgs: [type]);
  }

}
