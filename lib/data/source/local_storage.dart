import 'package:get_storage/get_storage.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../../domain/entities/game_state.dart';
import '../../domain/entities/region.dart';

class LocalDatabase {
  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'database.db');
    // deleteDatabase(path);
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE players (
        id TEXT PRIMARY KEY,
        name TEXT,
        gender TEXT,
        age INTEGER
      );
    ''');
    await db.execute('''
      CREATE TABLE parties (
        id INTEGER PRIMARY KEY,
        name TEXT,
        description TEXT,
        startTime TEXT,
        endTime TEXT,
        totalScore INTEGER,
        duration TEXT,
        finalScore INTEGER,
        status TEXT
      );
    ''');
    await db.execute('''
  CREATE TABLE stats (
    id INTEGER PRIMARY KEY,
    player_id TEXT DEFAULT '1',
    score INTEGER DEFAULT 0,
    level INTEGER DEFAULT 0,
    FOREIGN KEY (player_id) REFERENCES players(id) ON DELETE CASCADE
  );
''');

    await db.execute('''
      CREATE TABLE regions (
        id INTEGER PRIMARY KEY,
        name TEXT,
        description TEXT,
        party_id INTEGER,
        offset_dx REAL,
        offset_dy REAL,
        route TEXT,
        FOREIGN KEY (party_id) REFERENCES parties(id) ON DELETE CASCADE
      );
    ''');
  }
}

class LocalStorage {
  final LocalDatabase db = LocalDatabase();

  final GetStorage storage = GetStorage();

  Future<void> insertData(String table, Map<String, dynamic> data) async {
    final dbClient = await db.database;
    await dbClient.insert(
      table,
      data,
    );
  }

  Future<List<Map<String, dynamic>>> getData(String table) async {
    final dbClient = await db.database;
    return await dbClient.query(table);
  }

  Future rawQuery(String query) async {
    final dbClient = await db.database;
    return await dbClient.rawQuery(query);
  }

  Future updateData(String table, Map<String, dynamic> data) async {
    try {
      final dbClient = await db.database;
      await dbClient.update(
        table,
        data,
        where: 'id = ?',
        whereArgs: [
          data['id'],
        ],
      );
    } catch (e) {
      print(e);
    }
  }

  Future<void> deleteData(String table, int id) async {
    final dbClient = await db.database;
    await dbClient.delete(
      table,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> deleteAllData(String table) async {
    final dbClient = await db.database;
    await dbClient.delete(table);
  }

  isUserLoggedIn() async {
    return await storage.read('isUserLoggedIn') ?? false;
  }

  Future<void> setUserLoggedIn(bool value) async {
    await storage.write('isUserLoggedIn', value);
  }
}
