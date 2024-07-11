import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseAddAnimalVaccineHelper {
  static final DatabaseAddAnimalVaccineHelper instance = DatabaseAddAnimalVaccineHelper._instance();
  static Database? _db;

  DatabaseAddAnimalVaccineHelper._instance();

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
          CREATE TABLE vaccineAnimalDetail (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            tagNo TEXT,
            date TEXT,
            vaccineName TEXT,
            notes TEXT
          )
        ''');
      },
    );
    return merlabDb;
  }

  Future<int> addVaccine(Map<String, dynamic> vaccineDetails) async {
    Database? db = await this.db;
    return await db!.insert('vaccineAnimalDetail', vaccineDetails);
  }

  Future<List<Map<String, dynamic>>> getVaccinesByTagNo(String tagNo) async {
    Database? db = await this.db;
    return await db!.query(
      'vaccineAnimalDetail',
      where: 'tagNo = ?',
      whereArgs: [tagNo],
    );
  }

  Future<int> deleteVaccine(int id) async {
    Database? db = await this.db;
    return await db!.delete(
      'vaccineAnimalDetail',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
