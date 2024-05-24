import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseService extends GetxService {
  late Database _database;
  String _databaseName = 'merlab.db';
  String _animalTypeTableName = 'AnimalType';
  String _animalSubtypeTableName = 'AnimalSubtype';

  Future<void> initializeDatabase() async {
    String directory = await getDatabasesPath();
    String path = join(directory, _databaseName);
    print("Veritabanı yolu: $path");
    _database = await openDatabase(path, version: 1, onCreate: (Database db, int version) async {
      await db.execute('''
        CREATE TABLE IF NOT EXISTS $_animalTypeTableName (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          animaltype TEXT,
          typedesc TEXT,
          logo TEXT,
          isactive INTEGER,
          userid INTEGER
        )
      ''');
      await db.execute('''
        CREATE TABLE IF NOT EXISTS $_animalSubtypeTableName (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          subtype TEXT,
          typedesc TEXT,
          logo TEXT,
          isactive INTEGER,
          userid INTEGER
        )
      ''');
    });
  }

  Future<void> addAnimalType(Map<String, dynamic> animalData, BuildContext context) async {
    await _database.insert(_animalTypeTableName, animalData);

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
    return await _database.query(_animalTypeTableName);
  }

  Future<void> addAnimalSubtype(Map<String, dynamic> subtypeData, BuildContext context) async {
    await _database.insert(_animalSubtypeTableName, subtypeData);

    // Eklenen veri için başarı mesajı göster
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Animal subtype data added successfully.'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  Future<List<Map<String, dynamic>>> getAnimalSubtypesFromSQLite() async {
    await initializeDatabase();
    return await _database.query(_animalSubtypeTableName);
  }
}
