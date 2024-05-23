import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:merlabciftlikyonetim/Profil/ProfilPage.dart';
import 'package:merlabciftlikyonetim/Callendar/CalendarPage.dart';
import 'package:merlabciftlikyonetim/Login/LoginPage.dart';
import 'package:merlabciftlikyonetim/TestPage.dart';
import 'package:merlabciftlikyonetim/iletisim/iletisimPage.dart';
import 'DrawerController.dart';

class DrawerMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final DrawerMenuController drawerController = Get.put(DrawerMenuController());

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
                  child: Obx(() => ExpansionTile(
                    leading: Icon(Icons.person, color: drawerController.isExpanded.value ? Colors.cyan : Colors.black),
                    title: Text('Profil'),
                    onExpansionChanged: (bool expanded) {
                      drawerController.toggleExpanded();
                    },
                    children: [
                      ListTile(
                        title: Text('Profil'),
                        onTap: () {
                          drawerController.navigateTo('/profil');
                        },
                      ),
                    ],
                  )),
                ),
                ListTile(
                  leading: Icon(Icons.event_note, color: Colors.black,),
                  title: Text('Ajanda'),
                  onTap: () {
                    drawerController.navigateTo('/calendar');
                  },
                ),
                ListTile(
                  leading: Icon(Icons.contact_support, color: Colors.black,),
                  title: Text('Bize Ulaşın'),
                  onTap: () {
                    drawerController.navigateTo('/iletisim');
                  },
                ),
                ListTile(
                  leading: Icon(Icons.contact_support, color: Colors.black,),
                  title: Text('Test'),
                  onTap: () {
                    drawerController.navigateTo('/test');
                  },
                ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Çıkış Yap'),
            onTap: () {
              drawerController.logout();
            },
          ),
        ],
      ),
    );
  }
}
