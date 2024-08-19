import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseScheduleHelper {
  static final DatabaseScheduleHelper _instance = DatabaseScheduleHelper._internal();
  factory DatabaseScheduleHelper() => _instance;
  static Database? _database;

  DatabaseScheduleHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'merlab.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute(
        '''
      CREATE TABLE vaccineScheduleTable (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        date TEXT,
        time TEXT,
        notes TEXT,
        vaccine TEXT
      )
      '''
    );
  }

  Future<int> insertEvent(DateTime date, String time, String notes, String vaccine) async {
    final db = await database;
    try {
      return await db.insert(
        'vaccineScheduleTable',
        {
          'date': DateFormat('yyyy-MM-dd').format(date) + 'T00:00:00.000Z',
          'time': time,
          'notes': notes,
          'vaccine': vaccine
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      print("Error inserting event: $e");
      return -1;
    }
  }

  Future<List<Map<String, dynamic>>> getEvents() async {
    final db = await database;
    return await db.query('vaccineScheduleTable');
  }

  Future<void> deleteEvent(int id) async {
    final db = await database;
    try {
      await db.delete(
        'vaccineScheduleTable',
        where: 'id = ?',
        whereArgs: [id],
      );
    } catch (e) {
      print("Error deleting event: $e");
    }
  }
}
