import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseInekHelper {
  static final DatabaseInekHelper instance = DatabaseInekHelper._instance();
  static Database? _db;

  DatabaseInekHelper._instance();

  String inekTable = 'inekTable';
  String colId = 'id';
  String colWeight = 'weight';
  String colTagNo = 'tagNo';
  String colGovTagNo = 'govTagNo';
  String colInekSpecies = 'inekSpecies';
  String colName = 'name';
  String colInekType = 'inekType';
  String colDob = 'dob';
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
      'CREATE TABLE IF NOT EXISTS $inekTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colWeight REAL, $colTagNo TEXT, $colGovTagNo TEXT, $colInekSpecies TEXT, $colName TEXT, $colInekType TEXT, $colDob TEXT, $colTime TEXT)',
    );
  }

  Future<int> insertInek(Map<String, dynamic> inek) async {
    Database? db = await this.db;
    final int result = await db!.insert(inekTable, inek);
    return result;
  }
}
