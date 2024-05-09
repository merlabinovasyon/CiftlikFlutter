import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:merlabciftlikyonetim/services/DatabaseService.dart';
import 'AuthService.dart';

class SyncService {
  final AuthService authService = AuthService();
  final DatabaseService databaseService = DatabaseService();
  final String baseUrl = 'http://146.190.54.51/api/Users';
  final String postUrl = "http://146.190.54.51/api/Users";
  final String getAnimal = "http://146.190.54.51/api/AnimalType";
  final String postAnimal = "http://146.190.54.51/api/AnimalType";



  // HTTP Basic Authentication credentials
  final String username = 'MerlabUser';
  final String password = 'kWz*7jq8[;71';

  Future<void> syncUsers() async {
    await authService.initDb(); // Ensure the database is initialized

    final users = await authService.getAllUsers(); // Get users from the SQLite database

    for (var user in users) {
      final jsonUser = jsonEncode({
        'email': user['email'],
        'password': user['password'],
        'username': user['username'],
      });

      final response = await http.post(
        Uri.parse('$baseUrl/login'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Basic ${base64Encode(utf8.encode("$username:$password"))}', // Update Basic Auth header
        },
        body: jsonUser,
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        print('Successfully synced user ${user['email']}');
      } else {
        print('Failed to sync user ${user['email']}: ${response.body}, ${response.statusCode}');
      }
    }
  }

  Future<void> syncUsersPost() async {
    final jsonUser = jsonEncode({
      'username': 'bbb',
      'password': '123456',
      'email': 'b@gmail.com',
      'usertypeid': 0 // Ensure it's an integer
    });

    final response = await http.post(
      Uri.parse(postUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Basic ${base64Encode(utf8.encode("$username:$password"))}', // Update Basic Auth header
      },
      body: jsonUser,
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      print('Successfully synced user');
    } else {
      print('Failed to sync user: ${response.body}, ${response.statusCode}');
    }
  }

  Future<void> syncUsersFromApiToDatabase() async {
    try {
      final List<Map<String, dynamic>> users = await getUsers();
      await authService.initDb(); // Ensure the database is initialized

      for (var user in users) {
        // Ensure the data is compatible with SQLite
        final dbUser = {
          'id': user['id'],
          'username': user['username'],
          'password': user['password'],
          'email': user['email'],
          'isactive': user['isactive'],
          'userTypeId': user['userTypeId'],
          // Convert lists/maps to strings
          // 'companyUserMappings': jsonEncode(user['companyUserMappings']),
        };
        await authService.addUser(dbUser); // Add each user to SQLite
      }

      print('Successfully synced users from API to SQLite');
    } catch (e) {
      print('Failed to sync users from API to SQLite: $e');
    }
  }

  Future<List<Map<String, dynamic>>> getUsers() async {
    final response = await http.get(Uri.parse(baseUrl), headers: {
      'Authorization': 'Basic ${base64Encode(utf8.encode("$username:$password"))}', // Update Basic Auth header
    });
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return List<Map<String, dynamic>>.from(data);
    } else {
      throw Exception('Failed to load users');
    }
  }
  Future<void> syncAnimalTypes(BuildContext context) async {
    try {
      final animalTypes = await getAnimalTypesFromApi();
      await databaseService.initializeDatabase();  // Ensure the database is initialized

      for (var animal in animalTypes) {
        final dbAnimal = {
          'id': animal['id'],
          'animaltype': animal['animaltype'],
          'typedesc': animal['typedesc'],
          'logo': animal['logo'],
          'isactive': animal['isactive'],
          'userid': animal['userid'],
         // 'animalSubTypes': jsonEncode(animal['animalSubTypes']),  // Convert list of subtypes to a JSON string
        };
        await databaseService.addAnimalType(dbAnimal,context);  // Add each animal type to SQLite
      }

      print('Successfully synced animal types from API to SQLite');
    } catch (e) {
      print('Failed to sync animal types from API to SQLite: $e');
    }
  }

  Future<List<Map<String, dynamic>>> getAnimalTypesFromApi() async {
    final response = await http.get(Uri.parse(getAnimal), headers: {
      'Authorization': 'Basic ${base64Encode(utf8.encode("$username:$password"))}',
    });

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return List<Map<String, dynamic>>.from(data);
    } else {
      throw Exception('Failed to load animal types');
    }
  }
  Future<void> syncAnimalTypesToMySQL(BuildContext context) async {
    try {
      final animalTypes = await databaseService.getAnimalTypesFromSQLite();
      for (var animal in animalTypes) {
        final response = await http.post(
          Uri.parse(postAnimal),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Basic ${base64Encode(utf8.encode("$username:$password"))}',
          },
          body: jsonEncode({
            'id': 3,
            'animaltype': 'küçük',
            'typedesc': 'küçüktür',
            'logo': '',
            'isactive': -1,
            'userid': -1,
            // 'animalSubTypes': jsonEncode(animal['animalSubTypes']),
          }),
        );

        if (response.statusCode == 201 || response.statusCode == 200) {
          print('Successfully synced animal type ${animal['animaltype']} to MySQL');
        } else {
          print('Failed to sync animal type ${animal['animaltype']} to MySQL: ${response.body}, ${response.statusCode}');
        }
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('All animal types synced successfully to MySQL.'),
          duration: Duration(seconds: 2),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to sync animal types to MySQL: $e'),
          duration: Duration(seconds: 2),
        ),
      );
      print('Failed to sync animal types to MySQL: $e');
    }
  }
}

