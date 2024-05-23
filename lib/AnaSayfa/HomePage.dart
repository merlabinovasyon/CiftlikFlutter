import 'package:flutter/material.dart';
import 'package:merlabciftlikyonetim/AnaSayfa/IconButton.dart';
import 'package:merlabciftlikyonetim/CustomButtonCard.dart';
import 'package:merlabciftlikyonetim/gebelik_kontrol_page.dart';
import '../Profil/ProfilPage.dart';
import '../buildSubscriptionCard.dart';
import '../Drawer/drawer_menu.dart';
import '../masti_pro_page.dart';
import '../pedometer_page.dart';
import '../tohumlanmaya_hazir_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
        title: Center(
          child: Container(
            height: 40,
            width: 130,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('resimler/logo_v2.png'),
                  fit: BoxFit.fill
              ),
            ),
          ),
        ),
        actions: [
          Stack(
            alignment: Alignment.topRight,
            children: [
              IconButton(
                icon: Icon(Icons.notifications, size: 35,),
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
              )
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
                    buildIconButton(context, 'resimler/hayvanlarim.png', 'Tüm Hayvanlar', ProfilPage()),
                    buildIconButton(context, 'resimler/koc_1.png', 'Tohumlanmaya Hazır', TohumlanmayaHazirPage()),
                    buildIconButton(context, 'resimler/koc_katim_1.png', 'MastiPro', MastiProPage()),
                    buildIconButton(context, 'resimler/süt_olcum.png', 'Pedometre', PedometerPage()),
                    buildIconButton(context, 'resimler/kuzu_1.png', 'Gebelik Kontrol', GebelikKontrolPage()),
                  ],
                ),
              ),
              SizedBox(height: 25.0),
              Card(
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
                              color: Colors.cyan
                          ),
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              buildSubscriptionCard(
                                  'Süt Başlangıç Paketi', '£149,99 (Ay)', 0xFFFFD600),
                              buildSubscriptionCard(
                                  'Süt Altın Paketi', '£199,99 (Ay)', 0xFF26A69A),
                              buildSubscriptionCard(
                                  'Süt Platinum Paketi', '£249,99 (Ay)', 0xFF8BC34A),
                              buildSubscriptionCard(
                                  'Süt Diamond Paketi', '£299,99 (Ay)', 0xFF8BC34A),
                              buildSubscriptionCard(
                                  'Süt Ultimate Paketi', '£349,99 (Ay)', 0xFF8BC34A),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            TextButton(
                              onPressed: () {},
                              child: Text('Gizlilik Politikası', style: TextStyle(color: Colors.black),),
                            ),
                            TextButton(
                              onPressed: () {},
                              child: Text('Kullanım Koşulları (EULA)', style: TextStyle(color: Colors.black)),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0, bottom: 8),
                          child: Text(
                            '* Uygulama İçi Satın Alım Gerektirir. Otomatik Yenilenir.', textAlign: TextAlign.center, style: TextStyle(fontSize: 12),),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 25.0),
              Row(
                children: [
                  CustomButtonCard(
                    icon: Icons.account_balance,
                    title: 'Gelir/Gider',
                    onTap: () {},
                  ),
                  CustomButtonCard(
                    icon: Icons.sync,
                    title: 'Sync.',
                    onTap: () {},
                  ),
                ],
              ),
              SizedBox(height: 10.0),
              Row(
                children: [
                  CustomButtonCard(
                    icon: Icons.pie_chart,
                    title: 'Sürüye Bakış',
                    onTap: () {},
                  ),
                  CustomButtonCard(
                    icon: Icons.info,
                    title: 'Süt Bilgileri',
                    onTap: () {},
                  ),
                ],
              ),
              SizedBox(height: 10.0),
              Row(
                children: [
                  CustomButtonCard(
                    icon: Icons.account_balance,
                    title: 'Gelir/Gider',
                    onTap: () {},
                  ),
                  CustomButtonCard(
                    icon: Icons.info,
                    title: 'Süt Bilgileri',
                    onTap: () {},
                  ),
                ],
              ),
              SizedBox(height: 10.0),
              Row(
                children: [
                  CustomButtonCard(
                    icon: Icons.account_balance,
                    title: 'Gelir/Gider',
                    onTap: () {},
                  ),
                  CustomButtonCard(
                    icon: Icons.info,
                    title: 'Süt Bilgileri',
                    onTap: () {},
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
