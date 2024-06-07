import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:merlabciftlikyonetim/AnaSayfa/BuildSubscriptionSection.dart';
import 'package:merlabciftlikyonetim/AsiTakvimi/AsiPage.dart';
import 'package:merlabciftlikyonetim/EklemeSayfalari/KocKatim/KocKatimPage.dart';
import 'package:merlabciftlikyonetim/GraphicPage.dart';
import 'package:merlabciftlikyonetim/Hayvanlar/AnimalPage.dart';
import '../Drawer/DrawerMenu.dart';
import '../Profil/ProfilPage.dart';
import '../gebelik_kontrol_page.dart';
import '../pedometer_page.dart';
import '../tohumlanmaya_hazir_page.dart';
import 'BuildIconButton.dart';
import 'BuildActionCardRow.dart';
import 'ExpandingFab.dart';
import 'HomeController.dart';

class HomePage extends StatelessWidget {
  final HomeController controller = Get.put(HomeController());

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false; // Geri tuşuna basıldığında hiçbir şey yapılmamasını sağlar
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            ),
          ),
          title: Center(
            child: Container(
              height: 40,
              width: 130,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('resimler/logo_v2.png'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          actions: [
            Stack(
              alignment: Alignment.topRight,
              children: [
                IconButton(
                  icon: const Icon(Icons.notifications, size: 35),
                  onPressed: () {},
                ),
                Positioned(
                  right: 11,
                  top: 11,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 18,
                      minHeight: 18,
                    ),
                    child: const Text(
                      '20',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        drawer: const DrawerMenu(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search),
                    hintText: 'Küpe No, Hayvan Adı, Kemer No',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      BuildIconButton(assetPath: 'resimler/hayvanlarim.png', label: 'Tüm Hayvanlar', page: AnimalPage()),
                      BuildIconButton(assetPath: 'resimler/koc_1.png', label: 'Tohumlanmaya Hazır', page: TohumlanmayaHazirPage()),
                      BuildIconButton(assetPath: 'resimler/koc_katim_1.png', label: 'Koç Katım', page: KocKatimPage()),
                      BuildIconButton(assetPath: 'resimler/süt_olcum.png', label: 'Pedometre', page: PedometerPage()),
                      BuildIconButton(assetPath: 'resimler/kuzu_1.png', label: 'Gebelik Kontrol', page: GebelikKontrolPage()),
                    ],
                  ),
                ),
                const SizedBox(height: 25.0),
                BuildSubscriptionSection(),
                const SizedBox(height: 25.0),
                BuildActionCardRow(
                  title1: 'Gelir/Gider',
                  icon1: Icons.account_balance,
                  onTap1: () {
                    // Handle tap for Gelir/Gider
                  },
                  title2: 'Sync',
                  icon2: Icons.sync,
                  onTap2: () {
                    // Handle tap for Sync
                  },
                ),
                const SizedBox(height: 10.0),
                BuildActionCardRow(
                  title1: 'Sürü Takip',
                  icon1: Icons.pie_chart,
                  onTap1: () {
                    // Handle tap for Sürüye Bakış
                    Get.to(() => GraphicPage());
                  },
                  title2: 'Analiz',
                  icon2: Icons.analytics,
                  onTap2: () {
                    // Handle tap for Analiz
                  },
                ),
                const SizedBox(height: 10.0),
                BuildActionCardRow(
                  title1: 'Hayvan Detayı',
                  icon1: Icons.details,
                  onTap1: () {
                    // Handle tap for Hayvan Detayı
                  },
                  title2: 'Yem Yönetimi',
                  icon2: Icons.food_bank,
                  onTap2: () {
                    // Handle tap for Yem Yönetimi
                  },
                ),
                const SizedBox(height: 10.0),
                BuildActionCardRow(
                  title1: 'Aşı Takvimi',
                  icon1: Icons.event_note,
                  onTap1: () {
                    // Handle tap for Aşı Takvimi
                    Get.to(() => AsiPage());

                  },
                  title2: 'Hastalık Takibi',
                  icon2: Icons.local_hospital,
                  onTap2: () {
                    // Handle tap for Hastalık Takibi
                  },
                ),
                const SizedBox(height: 10.0),
                BuildActionCardRow(
                  title1: 'Raporlar',
                  icon1: Icons.report,
                  onTap1: () {
                    // Handle tap for Raporlar
                  },
                  title2: 'Kayıtlar',
                  icon2: Icons.book,
                  onTap2: () {
                    // Handle tap for Kayıtlar
                  },
                ),
                SizedBox(height: 30.0),
              ],
            ),
          ),
        ),
        floatingActionButton: ExpandingFab(),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      ),
    );
  }
}
