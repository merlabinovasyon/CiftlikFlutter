import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseAddAnimalLocationHelper {
  static final DatabaseAddAnimalLocationHelper instance = DatabaseAddAnimalLocationHelper._instance();
  static Database? _db;

  DatabaseAddAnimalLocationHelper._instance();

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
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE IF NOT EXISTS animalLocationDetail (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            tagNo TEXT,
            date TEXT,
            locationName TEXT
          )
        ''');
      },
    );
    return merlabDb;
  }

  Future<int> addLocation(Map<String, dynamic> locationDetails) async {
    Database? db = await this.db;
    return await db!.insert('animalLocationDetail', locationDetails);
  }

  Future<List<Map<String, dynamic>>> getLocationsByTagNo(String tagNo) async {
    Database? db = await this.db;
    return await db!.query(
      'animalLocationDetail',
      where: 'tagNo = ?',
      whereArgs: [tagNo],
    );
  }

  Future<int> deleteLocation(int id) async {
    Database? db = await this.db;
    return await db!.delete(
      'animalLocationDetail',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
