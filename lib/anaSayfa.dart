import 'package:flutter/material.dart';
import 'package:merlabciftlikyonetim/SyncService.dart';

class AnaSayfa extends StatefulWidget {
  const AnaSayfa({super.key});

  @override
  _AnaSayfaState createState() => _AnaSayfaState();
}

class _AnaSayfaState extends State<AnaSayfa> {
  final SyncService syncService = SyncService();
  List<Map<String, dynamic>> _users = [];
  String _error = '';

  @override
  void initState() {
    super.initState();
    _fetchUsers();
  }

  Future<void> _fetchUsers() async {
    try {
      final users = await syncService.getUsers();
      setState(() {
        _users = users;
        _error = '';
      });
    } catch (e) {
      setState(() {
        _error = 'Error: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          child: Icon(Icons.sync),
          onTap: () async {
            try {
              await syncService.syncUsersPost(); // Start synchronization
              //await syncService.syncUsersFromApiToDatabase();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Synchronization successful')),
              );
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Synchronization failed: $e')),
              );
            }
          },
        ),
        backgroundColor: Colors.deepOrange,
        elevation: 4,
        shadowColor: Colors.black38,
        title: Row(
          children: [
            SizedBox(width: 90,),
            Text("Ana Sayfa"),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _error.isNotEmpty
            ? Text(_error)
            : ListView.builder(
          itemCount: _users.length,
          itemBuilder: (context, index) {
            final user = _users[index];
            return ListTile(
              title: Text(user['username'] ?? 'Unknown'),
              subtitle: Text(user['email'] ?? 'No Email'),
            );
          },
        ),
      ),
    );
  }
}
