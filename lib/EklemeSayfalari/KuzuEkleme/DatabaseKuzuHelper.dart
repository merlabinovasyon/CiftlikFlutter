import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseKuzuHelper {
  static final DatabaseKuzuHelper instance = DatabaseKuzuHelper._instance();
  static Database? _db;

  DatabaseKuzuHelper._instance();

  String lambTable = 'lambTable';
  String colId = 'id';
  String colWeight = 'weight';
  String colAnimal = 'animal';
  String colKoc = 'koc';
  String colDob = 'dob';
  String colTime = 'time';
  String colTagNo = 'tagNo';
  String colGovTagNo = 'govTagNo';
  String colBreed = 'breed';
  String colName = 'name';
  String colGender = 'gender';
  String colLambType = 'lambType';

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
      'CREATE TABLE IF NOT EXISTS $lambTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colWeight REAL, $colAnimal TEXT, $colKoc TEXT, $colDob TEXT, $colTime TEXT, $colTagNo TEXT, $colGovTagNo TEXT, $colBreed TEXT, $colName TEXT, $colGender TEXT, $colLambType TEXT)',
    );
  }

  Future<int> insertLamb(Map<String, dynamic> lamb) async {
    Database? db = await this.db;
    final int result = await db!.insert(lambTable, lamb);
    return result;
  }
}
