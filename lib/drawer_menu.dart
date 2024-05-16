// lib/widgets/drawer_menu.dart
import 'package:flutter/material.dart';
import 'package:merlabciftlikyonetim/iletisimPage.dart';
import 'package:merlabciftlikyonetim/ProfilPage.dart';

import 'CalendarPage.dart';
import 'LoginPage.dart';
import 'TestPage.dart';

class DrawerMenu extends StatefulWidget {
  @override
  _DrawerMenuState createState() => _DrawerMenuState();
}

class _DrawerMenuState extends State<DrawerMenu> {
  bool isExpanded = false;

  void logout() async {
    Navigator.of(context).pop();
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => LoginPage()));
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
                    leading: Icon(Icons.person, color: isExpanded ? Colors.cyan : Colors.black),
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
                            MaterialPageRoute(builder: (context) => ProfilPage()),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.event_note, color: Colors.black,),
                  title: Text('Ajanda'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CalendarPage()),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.contact_support, color: Colors.black,),
                  title: Text('Bize Ulaşın'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => iletisimPage()),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.contact_support, color: Colors.black,),
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
