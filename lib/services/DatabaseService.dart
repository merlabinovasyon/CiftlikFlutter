import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseService {
  late Database _database;
  String _databaseName = 'merlab.db';
  String _tableName = 'AnimalType';

  Future<void> initializeDatabase() async {
    String directory = await getDatabasesPath();
    String path = join(directory, _databaseName);
    print("Veritabanı yolu: $path");
    _database = await openDatabase(path, version: 1, onCreate: (Database db, int version) async {
      await db.execute('''
        CREATE TABLE IF NOT EXISTS $_tableName (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          animaltype TEXT,
          typedesc TEXT,
          logo TEXT,
          isactive INTEGER,
          userid INTEGER
        )
      ''');
    });
  }

  Future<void> addAnimalType(Map<String, dynamic> animalData, BuildContext context) async {
    await _database.insert(_tableName, animalData);

    // Eklenen veri için başarı mesajı göster
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Veri başarıyla eklendi.'),
        duration: Duration(seconds: 2),
      ),
    );
  }
  Future<List<Map<String, dynamic>>> getAnimalTypesFromSQLite() async {
    await initializeDatabase();
    return await _database.query(_tableName);
  }
}
