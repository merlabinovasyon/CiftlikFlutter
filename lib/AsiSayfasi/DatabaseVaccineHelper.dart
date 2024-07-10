import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseVaccineHelper {
  static final DatabaseVaccineHelper instance = DatabaseVaccineHelper._instance();
  static Database? _db;

  DatabaseVaccineHelper._instance();

  String vaccineTable = 'vaccineTable';
  String colId = 'id';
  String colVaccineName = 'vaccineName';
  String colVaccineDescription = 'vaccineDescription';

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
      'CREATE TABLE IF NOT EXISTS $vaccineTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colVaccineName TEXT, $colVaccineDescription TEXT)',
    );
  }

  Future<int> insertVaccine(Map<String, dynamic> vaccine) async {
    Database? db = await this.db;
    final int result = await db!.insert(vaccineTable, vaccine);
    return result;
  }

  Future<List<Map<String, dynamic>>> getVaccines() async {
    Database? db = await this.db;
    final List<Map<String, dynamic>> result = await db!.query(vaccineTable);
    return result;
  }

  Future<int> deleteVaccine(int id) async {
    Database? db = await this.db;
    final int result = await db!.delete(vaccineTable, where: '$colId = ?', whereArgs: [id]);
    return result;
  }
}
