import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseAnimalHelper {
  static final DatabaseAnimalHelper instance = DatabaseAnimalHelper._instance();
  static Database? _db;

  DatabaseAnimalHelper._instance();

  Future<Database?> get db async {
    if (_db == null) {
      _db = await _initDb();
    }
    return _db;
  }

  Future<Database> _initDb() async {
    String path = join(await getDatabasesPath(), 'merlab.db');
    final merlabDb = await openDatabase(
      path,
      version: 1,
      onCreate: _createDb,
    );
    return merlabDb;
  }

  void _createDb(Database db, int version) async {
    await db.execute(
        'CREATE TABLE IF NOT EXISTS lambTable(id INTEGER PRIMARY KEY AUTOINCREMENT, tagNo TEXT, name TEXT, dob TEXT)');
    await db.execute(
        'CREATE TABLE IF NOT EXISTS buzagiTable(id INTEGER PRIMARY KEY AUTOINCREMENT, tagNo TEXT, name TEXT, dob TEXT)');
    await db.execute(
        'CREATE TABLE IF NOT EXISTS koyunTable(id INTEGER PRIMARY KEY AUTOINCREMENT, tagNo TEXT, name TEXT, dob TEXT)');
    await db.execute(
        'CREATE TABLE IF NOT EXISTS kocTable(id INTEGER PRIMARY KEY AUTOINCREMENT, tagNo TEXT, name TEXT, dob TEXT)');
    await db.execute(
        'CREATE TABLE IF NOT EXISTS inekTable(id INTEGER PRIMARY KEY AUTOINCREMENT, tagNo TEXT, name TEXT, dob TEXT)');
    await db.execute(
        'CREATE TABLE IF NOT EXISTS bogaTable(id INTEGER PRIMARY KEY AUTOINCREMENT, tagNo TEXT, name TEXT, dob TEXT)');
    await db.execute(
        'CREATE TABLE IF NOT EXISTS weanedKuzuTable(id INTEGER PRIMARY KEY AUTOINCREMENT, type TEXT, date TEXT)');
    await db.execute(
        'CREATE TABLE IF NOT EXISTS weanedBuzagiTable(id INTEGER PRIMARY KEY AUTOINCREMENT, type TEXT, date TEXT)');
  }

  Future<List<Map<String, dynamic>>> getAnimals(String tableName) async {
    Database? db = await this.db;
    final List<Map<String, dynamic>> result = await db!.query(tableName);
    return result;
  }

  Future<int> deleteAnimal(int id, String tableName) async {
    Database? db = await this.db;
    return await db!.delete(tableName, where: 'id = ?', whereArgs: [id]);
  }
}
