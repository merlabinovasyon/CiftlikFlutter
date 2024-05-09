import 'dart:convert';
import 'package:http/http.dart' as http;
import 'AuthService.dart';

class SyncService {
  final AuthService authService = AuthService();
  final String baseUrl = 'http://146.190.54.51/api/Users';
  final String postUrl = "http://146.190.54.51/api/Users";

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
      final List<Map<String, dynamic>> users = await getUsersFromMySQL();
      await authService.initDb(); // Ensure the database is initialized

      for (var user in users) {
        final dbUser = {
          'id': user['id'],
          'username': user['username'],
          'password': user['password'],
          'email': user['email'],
          'isactive': user['isactive'],
          'userTypeId': user['userTypeId'],
        };
        await authService.addUser(dbUser); // Add each user to SQLite
      }

      print('Successfully synced users from API to SQLite');
    } catch (e) {
      print('Failed to sync users from API to SQLite: $e');
    }
  }

  Future<List<Map<String, dynamic>>> getUsersFromMySQL() async {
    final response = await http.get(
        Uri.parse(baseUrl),
        headers: {
          'Authorization': 'Basic ${base64Encode(utf8.encode("$username:$password"))}'
        }
    );

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return List<Map<String, dynamic>>.from(data);
    } else {
      throw Exception('Failed to load users from MySQL');
    }
  }
}
