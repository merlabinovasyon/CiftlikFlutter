import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:merlabciftlikyonetim/EklemeSayfalari/OlcumEkleme/OlcumPage.dart';
import 'package:merlabciftlikyonetim/HayvanAsiSayfasi/AnimalVaccinePage.dart';
import 'package:merlabciftlikyonetim/HayvanMuayeneSayfasi/AnimalExaminationPage.dart';
import 'package:merlabciftlikyonetim/KonumYonetimi/KonumYonetimiPage.dart';
import 'package:merlabciftlikyonetim/RasyonHesaplama/RationWizardMainPage.dart';
import 'package:merlabciftlikyonetim/YemYonetimi/FeedStockPage.dart';
import '../GelirGiderHesaplama/FinancePage.dart';
import '../HayvanDetaySayfasi/AnimalDetailPage.dart';
import 'DrawerController.dart';

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final DrawerMenuController drawerController = Get.put(DrawerMenuController());

    return Drawer(
      backgroundColor: Colors.white,
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
                    title: const Text('Profil'),
                    onExpansionChanged: (bool expanded) {
                      drawerController.toggleExpanded();
                    },
                    children: [
                      ListTile(
                        title: const Text('Profil'),
                        onTap: () {
                          drawerController.navigateTo('/profil');
                        },
                      ),
                    ],
                  )),
                ),
                ListTile(
                  leading: const Icon(Icons.event_note, color: Colors.black,),
                  title: const Text('Ajanda'),
                  onTap: () {
                    drawerController.navigateTo('/calendar');
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.contact_support, color: Colors.black,),
                  title: const Text('Bize Ulaşın'),
                  onTap: () {
                    drawerController.navigateTo('/iletisim');
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.contact_support, color: Colors.black,),
                  title: const Text('Test'),
                  onTap: () {
                    Get.to(() => RationWizardMainPage()) ;              },
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text('Çıkış Yap'),
            onTap: () {
              drawerController.logout();
            },
          ),
        ],
      ),
    );
  }
}
