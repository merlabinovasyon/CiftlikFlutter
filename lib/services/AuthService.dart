import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class AuthService {
  Database? _database;

  Future<void> _copyDatabaseIfNeeded(String path) async {
    if (File(path).existsSync()) {
      return;
    }

    ByteData data = await rootBundle.load('databases/merlab.db');
    List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    await File(path).writeAsBytes(bytes);
  }
  Future<void> addUser(Map<String, dynamic> user) async {
    final db = _database;

    await db?.insert(
      'User', // Your users table name
      user,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> initDb() async {
    if (_database != null) return;
    String path = join(await getDatabasesPath(), 'merlab.db');
    await _copyDatabaseIfNeeded(path);
    _database = await openDatabase(path);
  }

  Future<void> signIn(String email, String password) async {
    await initDb();

    List<Map> users = await _database!.query('User', where: 'email = ? AND password = ?', whereArgs: [email, password]);
    if (users.isEmpty) {
      throw Exception('No user found with that email and password');
    }
  }

  Future<void> registerUser(String email, String password,String username) async {
    await initDb();
    await _database!.insert(
      'User',
      {'email': email, 'password': password, 'username': username,'userTypeId':0,},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Map<String, dynamic>>> getAllUsers() async {
    await initDb();
    return await _database!.query('User');
  }
}
