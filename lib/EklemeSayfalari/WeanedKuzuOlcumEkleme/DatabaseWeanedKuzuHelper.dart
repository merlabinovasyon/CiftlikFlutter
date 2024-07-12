import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseWeanedKuzuHelper {
  static final DatabaseWeanedKuzuHelper instance = DatabaseWeanedKuzuHelper._instance();
  static Database? _db;

  DatabaseWeanedKuzuHelper._instance();

  String weanedKuzuTable = 'weanedKuzuTable';
  String colId = 'id';
  String colWeight = 'weight';
  String colTagNo = 'tagNo';
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
      'CREATE TABLE IF NOT EXISTS $weanedKuzuTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colWeight REAL, $colTagNo TEXT, $colDate TEXT, $colTime TEXT)',
    );
  }

  Future<int> insertWeanedKuzu(Map<String, dynamic> weanedKuzu) async {
    Database? db = await this.db;
    final int result = await db!.insert(weanedKuzuTable, weanedKuzu);
    return result;
  }
}
