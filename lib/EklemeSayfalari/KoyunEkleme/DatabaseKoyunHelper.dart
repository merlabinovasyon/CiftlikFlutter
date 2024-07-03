import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseKoyunHelper {
  static final DatabaseKoyunHelper instance = DatabaseKoyunHelper._instance();
  static Database? _db;

  DatabaseKoyunHelper._instance();

  String koyunTable = 'koyunTable';
  String colId = 'id';
  String colWeight = 'weight';
  String colTagNo = 'tagNo';
  String colGovTagNo = 'govTagNo';
  String colBreedSpecies = 'breedSpecies';
  String colName = 'name';
  String colKoyunType = 'koyunType';
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
      'CREATE TABLE IF NOT EXISTS $koyunTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colWeight REAL, $colTagNo TEXT, $colGovTagNo TEXT, $colBreedSpecies TEXT, $colName TEXT, $colKoyunType TEXT, $colDob TEXT, $colTime TEXT)',
    );
  }

  Future<int> insertKoyun(Map<String, dynamic> koyun) async {
    Database? db = await this.db;
    final int result = await db!.insert(koyunTable, koyun);
    return result;
  }
}
