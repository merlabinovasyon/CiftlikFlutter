import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class AnimalService {
  static final AnimalService instance = AnimalService._instance();
  static Database? _db;

  AnimalService._instance();

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
      'CREATE TABLE IF NOT EXISTS koyunTable(id INTEGER PRIMARY KEY AUTOINCREMENT, tagNo TEXT, name TEXT)',
    );
    await db.execute(
      'CREATE TABLE IF NOT EXISTS kocTable(id INTEGER PRIMARY KEY AUTOINCREMENT, tagNo TEXT, name TEXT)',
    );
    await db.execute(
      'CREATE TABLE IF NOT EXISTS inekTable(id INTEGER PRIMARY KEY AUTOINCREMENT, tagNo TEXT, name TEXT)',
    );
    await db.execute(
      'CREATE TABLE IF NOT EXISTS bogaTable(id INTEGER PRIMARY KEY AUTOINCREMENT, tagNo TEXT, name TEXT)',
    );
    await db.execute(
      'CREATE TABLE IF NOT EXISTS lambTable(id INTEGER PRIMARY KEY AUTOINCREMENT, tagNo TEXT, name TEXT)',
    );
    await db.execute(
      'CREATE TABLE IF NOT EXISTS buzagiTable(id INTEGER PRIMARY KEY AUTOINCREMENT, tagNo TEXT, name TEXT)',
    );
  }

  Future<List<Map<String, dynamic>>> getKoyunList() async {
    Database? db = await this.db;
    return await db!.query('koyunTable');
  }

  Future<List<Map<String, dynamic>>> getKocList() async {
    Database? db = await this.db;
    return await db!.query('kocTable');
  }
  Future<List<Map<String, dynamic>>> getInekList() async {
    Database? db = await this.db;
    return await db!.query('inekTable');
  }
  Future<List<Map<String, dynamic>>> getBogaList() async {
    Database? db = await this.db;
    return await db!.query('bogaTable');
  }
  Future<List<Map<String, dynamic>>> getKuzuList() async {
    Database? db = await this.db;
    return await db!.query('lambTable');
  }
  Future<List<Map<String, dynamic>>> getBuzagiList() async {
    Database? db = await this.db;
    return await db!.query('buzagiTable');
  }
}
