import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseWeanedBuzagiHelper {
  static final DatabaseWeanedBuzagiHelper instance = DatabaseWeanedBuzagiHelper._instance();
  static Database? _db;

  DatabaseWeanedBuzagiHelper._instance();

  String weanedBuzagiTable = 'weanedBuzagiTable';
  String colId = 'id';
  String colWeight = 'weight';
  String colType = 'type';
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
      'CREATE TABLE IF NOT EXISTS $weanedBuzagiTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colWeight REAL, $colType TEXT, $colDate TEXT, $colTime TEXT)',
    );
  }

  Future<int> insertWeanedBuzagi(Map<String, dynamic> weanedBuzagi) async {
    Database? db = await this.db;
    final int result = await db!.insert(weanedBuzagiTable, weanedBuzagi);
    return result;
  }
}
