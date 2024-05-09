import 'package:flutter/material.dart';
import 'package:merlabciftlikyonetim/SyncService.dart';
import 'package:merlabciftlikyonetim/TestPage.dart';
import 'package:merlabciftlikyonetim/ajandaPage.dart';
import 'package:merlabciftlikyonetim/iletisimPage.dart';
import 'main.dart';
import 'profilPage.dart'; // Ekledim, varsayılan olarak adlandırdım

class AnaSayfa extends StatefulWidget {
  const AnaSayfa({Key? key}) : super(key: key);

  @override
  _AnaSayfaState createState() => _AnaSayfaState();
}

class _AnaSayfaState extends State<AnaSayfa> {
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
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        title: Text("Ana Sayfa"),
      ),
      drawer: DrawerMenu(),
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


class DrawerMenu extends StatefulWidget {
  @override
  _DrawerMenuState createState() => _DrawerMenuState();
}

class _DrawerMenuState extends State<DrawerMenu> {
  bool isExpanded = false;

  // Örnek bir çıkış yapma fonksiyonu
  void logout() async {
    // Çıkış yapma işlemleri burada yapılabilir
    Navigator.of(context).pop();  // Drawer'ı kapat
    // Gerekirse başka sayfaya yönlendirme yapabilirsiniz
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => MyHomePage(title: "")));
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            height: 200,
            color: Colors.white10,
            child: Center(
              child: Image.asset(
                'resimler/logo_v2.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                Theme(
                  data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                  child: ExpansionTile(
                    leading: Icon(Icons.person, color: isExpanded ? Color(0xFF0277BD) : Colors.black),
                    title: Text('Profil'),
                    onExpansionChanged: (bool expanded) {
                      setState(() {
                        isExpanded = expanded;
                      });
                    },
                    children: [
                      ListTile(
                        title: Text('Profil'),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => profilPage()),
                          );
                        },
                      ),
                    ],
                  ),

                ),
                ListTile(
                  leading: Icon(Icons.event_note,color: Colors.black,),
                  title: Text('Ajanda'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ajandaPage()),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.contact_support,color: Colors.black,),
                  title: Text('Bize Ulaşın'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => iletisimPage()),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.contact_support,color: Colors.black,),
                  title: Text('Test'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TestPage()),
                    );
                  },
                ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Çıkış Yap'),
            onTap: () {
              logout();
            },
          ),
        ],
      ),
    );
  }
}
