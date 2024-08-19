import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseExaminationHelper {
  static final DatabaseExaminationHelper instance = DatabaseExaminationHelper._instance();
  static Database? _db;

  DatabaseExaminationHelper._instance();

  String examinationTable = 'examinationTable';
  String colId = 'id';
  String colExaminationName = 'examinationName';
  String colExaminationDescription = 'examinationDescription';

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
      'CREATE TABLE IF NOT EXISTS $examinationTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colExaminationName TEXT, $colExaminationDescription TEXT)',
    );
  }

  Future<int> insertExamination(Map<String, dynamic> examination) async {
    Database? db = await this.db;
    final int result = await db!.insert(examinationTable, examination);
    return result;
  }

  Future<List<Map<String, dynamic>>> getExaminations() async {
    Database? db = await this.db;
    final List<Map<String, dynamic>> result = await db!.query(examinationTable);
    return result;
  }

  Future<int> deleteExamination(int id) async {
    Database? db = await this.db;
    final int result = await db!.delete(examinationTable, where: '$colId = ?', whereArgs: [id]);
    return result;
  }
}
