import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

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
    String path = join(await getDatabasesPath(), 'app.db');
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
      'CREATE TABLE item(name TEXT PRIMARY KEY, asset TEXT, type TEXT, cost INTEGER)',
    );

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

  Future<List<Map<String, dynamic>>> getTasks() async {
    final db = await database;
    //returns a list of maps where each map represents a task.
    //like [{id: 1, title: 'Task 1', status: 1}, {id: 2, title: 'Task 2', status: 0}]
    return await db.query('task');
  }
}
