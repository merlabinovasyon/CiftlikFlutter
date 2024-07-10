import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseBuzagiHelper {
  static final DatabaseBuzagiHelper instance = DatabaseBuzagiHelper._instance();
  static Database? _db;

  DatabaseBuzagiHelper._instance();

  String buzagiTable = 'buzagiTable';
  String colId = 'id';
  String colWeight = 'weight';
  String colMother = 'mother';
  String colFather = 'father';
  String colDob = 'dob';
  String colTime = 'time';
  String colTagNo = 'tagNo';
  String colGovTagNo = 'govTagNo';
  String colSpecies = 'species';
  String colName = 'name';
  String colGender = 'gender';
  String colType = 'type';

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
      'CREATE TABLE IF NOT EXISTS $buzagiTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colWeight REAL, $colMother TEXT, $colFather TEXT, $colDob TEXT, $colTime TEXT, $colTagNo TEXT, $colGovTagNo TEXT, $colSpecies TEXT, $colName TEXT, $colGender TEXT, $colType TEXT)',
    );
  }

  Future<int> insertBuzagi(Map<String, dynamic> buzagi) async {
    Database? db = await this.db;
    final int result = await db!.insert(buzagiTable, buzagi);
    return result;
  }
}
