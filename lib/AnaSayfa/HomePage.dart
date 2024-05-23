import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Drawer/drawer_menu.dart';
import '../Profil/ProfilPage.dart';
import '../gebelik_kontrol_page.dart';
import '../masti_pro_page.dart';
import '../pedometer_page.dart';
import '../tohumlanmaya_hazir_page.dart';
import 'BuildIconButton.dart';
import 'BuildActionCardRow.dart';
import 'BuildSubscriptionCard.dart';
import 'ExpandingFab.dart';
import 'home_controller.dart';

class HomePage extends StatelessWidget {
  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
            decoration: BoxDecoration(
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
                icon: Icon(Icons.notifications, size: 35),
                onPressed: () {},
              ),
              Positioned(
                right: 11,
                top: 11,
                child: Container(
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  constraints: BoxConstraints(
                    minWidth: 18,
                    minHeight: 18,
                  ),
                  child: Text(
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
      drawer: DrawerMenu(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  hintText: 'Küpe No, Hayvan Adı, Kemer No',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    BuildIconButton(assetPath:'resimler/hayvanlarim.png',label:'Tüm Hayvanlar', page:ProfilPage()),
                    BuildIconButton(assetPath:'resimler/koc_1.png',label: 'Tohumlanmaya Hazır', page:TohumlanmayaHazirPage()),
                    BuildIconButton(assetPath:'resimler/koc_katim_1.png', label:'MastiPro', page:MastiProPage()),
                    BuildIconButton(assetPath:'resimler/süt_olcum.png', label:'Pedometre',page:PedometerPage()),
                    BuildIconButton(assetPath: 'resimler/kuzu_1.png',label:'Gebelik Kontrol',page:GebelikKontrolPage()),
                  ],
                ),
              ),
              SizedBox(height: 25.0),
              _buildSubscriptionSection(),
              SizedBox(height: 25.0),
              BuildActionCardRow(),
              SizedBox(height: 10.0),
              BuildActionCardRow(),
              SizedBox(height: 10.0),
              BuildActionCardRow(),
            ],
          ),
        ),
      ),
      floatingActionButton: ExpandingFab(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Widget _buildSubscriptionSection() {
    return Card(
      elevation: 0,
      color: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(
                'Ücretli Pakete Geç',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.cyan,
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    BuildSubscriptionCard(title: 'Süt Başlangıç Paketi', price: '£149,99 (Ay)',color_a: 0xFFFFD600),
                    BuildSubscriptionCard(title:'Süt Altın Paketi', price: '£199,99 (Ay)', color_a:0xFF26A69A),
                    BuildSubscriptionCard(title: 'Süt Platinum Paketi', price: '£249,99 (Ay)',color_a: 0xFFFF8F00),
                    BuildSubscriptionCard(title: 'Süt Diamond Paketi', price: '£299,99 (Ay)',color_a: 0xFF8BC34A),
                    BuildSubscriptionCard(title: 'Süt Ultimate Paketi', price: '£349,99 (Ay)',color_a: 0xFF8BC34A),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'Gizlilik Politikası',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'Kullanım Koşulları (EULA)',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4.0, bottom: 8),
                child: Text(
                  '* Uygulama İçi Satın Alım Gerektirir. Otomatik Yenilenir.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
