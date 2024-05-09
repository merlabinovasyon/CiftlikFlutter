import 'package:flutter/material.dart';
import 'package:merlabciftlikyonetim/services/SyncService.dart';


class TestPage extends StatefulWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  final SyncService syncService = SyncService();
  List<Map<String, dynamic>> _users = [];
  String _error = '';
  bool _isMounted = false;

  @override
  void initState() {
    super.initState();
    _isMounted = true;
    _fetchUsers();
  }

  @override
  void dispose() {
    _isMounted = false;
    super.dispose();
  }

  Future<void> _fetchUsers() async {
    try {
      final users = await syncService.getUsers();
      if (_isMounted) {
        setState(() {
          _users = users;
          _error = '';
        });
      }
    } catch (e) {
      if (_isMounted) {
        setState(() {
          _error = 'Error: $e';
        });
      }
    }
  }

  Future<void> _syncData() async {
    try {
      await syncService.syncUsersPost();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Synchronization successful')),
      );
      _fetchUsers();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Synchronization failed: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF0277BD),
        elevation: 4,
        shadowColor: Colors.black38,
        title: Text("Test Page"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _error.isNotEmpty
            ? Text(_error)
            : RefreshIndicator(
          color: Colors.black,
          onRefresh: _syncData,
          child: ListView.builder(
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
      ),
    );
  }
}

