import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseKonumYonetimiHelper {
  static final DatabaseKonumYonetimiHelper instance = DatabaseKonumYonetimiHelper._instance();
  static Database? _db;

  DatabaseKonumYonetimiHelper._instance();

  Future<Database?> get db async {
    if (_db == null) {
      _db = await _initDb();
    }
    return _db;
  }

  Future<Database> _initDb() async {
    String path = join(await getDatabasesPath(), 'merlab.db');
    final konumDb = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE IF NOT EXISTS ahir (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT
          )
        ''');
        await db.execute('''
          CREATE TABLE IF NOT EXISTS bolme (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            ahirId INTEGER,
            name TEXT,
            FOREIGN KEY (ahirId) REFERENCES ahir (id)
          )
        ''');
      },
    );
    return konumDb;
  }

  Future<int> addAhir(String name) async {
    Database? db = await this.db;
    return await db!.insert('ahir', {'name': name});
  }

  Future<List<Map<String, dynamic>>> getAhirList() async {
    Database? db = await this.db;
    return await db!.query('ahir');
  }

  Future<int> updateAhir(int id, String newName) async {
    Database? db = await this.db;
    return await db!.update('ahir', {'name': newName}, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> removeAhir(int id) async {
    Database? db = await this.db;
    await db!.delete('bolme', where: 'ahirId = ?', whereArgs: [id]);
    return await db.delete('ahir', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> addBolme(int ahirId, String name) async {
    Database? db = await this.db;
    return await db!.insert('bolme', {'ahirId': ahirId, 'name': name});
  }

  Future<List<Map<String, dynamic>>> getBolmeList(int ahirId) async {
    Database? db = await this.db;
    return await db!.query('bolme', where: 'ahirId = ?', whereArgs: [ahirId]);
  }

  Future<int> removeBolme(int id) async {
    Database? db = await this.db;
    return await db!.delete('bolme', where: 'id = ?', whereArgs: [id]);
  }
}
