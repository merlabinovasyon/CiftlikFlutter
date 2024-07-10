import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseAddAnimalExaminationHelper {
  static final DatabaseAddAnimalExaminationHelper instance = DatabaseAddAnimalExaminationHelper._instance();
  static Database? _db;

  DatabaseAddAnimalExaminationHelper._instance();

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
          CREATE TABLE IF NOT EXISTS examinationAnimalDetail (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            tagNo TEXT,
            date TEXT,
            examName TEXT,
            notes TEXT
          )
        ''');
      },
    );
    return merlabDb;
  }

  Future<int> addExamination(Map<String, dynamic> examDetails) async {
    Database? db = await this.db;
    return await db!.insert('examinationAnimalDetail', examDetails);
  }

  Future<List<Map<String, dynamic>>> getExaminationsByTagNo(String tagNo) async {
    Database? db = await this.db;
    return await db!.query(
      'examinationAnimalDetail',
      where: 'tagNo = ?',
      whereArgs: [tagNo],
    );
  }

  Future<int> deleteExamination(int id) async {
    Database? db = await this.db;
    return await db!.delete(
      'examinationAnimalDetail',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
