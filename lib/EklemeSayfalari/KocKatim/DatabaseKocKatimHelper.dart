import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseKocKatimHelper {
  static final DatabaseKocKatimHelper instance = DatabaseKocKatimHelper._instance();
  static Database? _db;

  DatabaseKocKatimHelper._instance();

  String kocKatimTable = 'kocKatimTable';
  String colId = 'id';
  String colKoyun = 'koyun';
  String colKoc = 'koc';
  String colDate = 'date';
  String colTime = 'time';

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
      'CREATE TABLE IF NOT EXISTS $kocKatimTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colKoyun TEXT, $colKoc TEXT, $colDate TEXT, $colTime TEXT)',
    );
  }

  Future<int> insertKocKatim(Map<String, dynamic> kocKatim) async {
    Database? db = await this.db;
    final int result = await db!.insert(kocKatimTable, kocKatim);
    return result;
  }
}
