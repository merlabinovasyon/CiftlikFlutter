import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/widgets.dart';

import '../services/DatabaseService.dart';

class IletisimController extends GetxController with WidgetsBindingObserver {
  var animalList = <Map<String, dynamic>>[].obs;
  final String _databaseName = 'merlab.db';
  final String _tableName = 'AnimalType';
  final DatabaseService _databaseService = Get.find();

  @override
  void onInit() {
    super.onInit();
    _databaseService.initializeDatabase();
    WidgetsBinding.instance.addObserver(this);
    _getAnimalList();
  }

  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this);
    super.onClose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _getAnimalList();
    }
  }

  Future<void> _getAnimalList() async {
    final database = openDatabase(
      join(await getDatabasesPath(), _databaseName),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE IF NOT EXISTS $_tableName(id INTEGER PRIMARY KEY, animaltype TEXT, typedesc TEXT)',
        );
      },
      version: 1,
    );

    final Database db = await database;
    final List<Map<String, dynamic>> animals = await db.query(_tableName);
    animalList.assignAll(animals);
  }

  Future<void> refreshAnimalList() async {
    await _getAnimalList();
  }

  Future<void> deleteAnimal(int id) async {
    final database = openDatabase(
      join(await getDatabasesPath(), _databaseName),
      version: 1,
    );

    final db = await database;
    await db.delete(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
    // Veritabanını güncelle
    _getAnimalList();
  }
}
