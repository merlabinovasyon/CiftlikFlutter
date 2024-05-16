import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:merlabciftlikyonetim/TestPage.dart';
import 'package:merlabciftlikyonetim/profilPage.dart';

import 'CalendarPage.dart';
import 'LoginPage.dart';
import 'iletisimPage.dart';
import 'main.dart';
=======


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
        ),        actions: [
          Stack(
            alignment: Alignment.topRight,
            children: [
              IconButton(
                icon: Icon(Icons.notifications,size: 35,),
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
                    _buildIconButton(context, 'resimler/hayvanlarim.png', 'Tüm Hayvanlar', profilPage()),
                    _buildIconButton(context, 'resimler/koc_1.png', 'Tohumlanmaya Hazır', TohumlanmayaHazirPage()),
                    _buildIconButton(context, 'resimler/koc_katim_1.png', 'MastiPro', MastiProPage()),
                    _buildIconButton(context, 'resimler/süt_olcum.png', 'Pedometre', PedometerPage()),
                    _buildIconButton(context, 'resimler/kuzu_1.png', 'Gebelik Kontrol', GebelikKontrolPage()),
                  ],
                ),
              ),
              SizedBox(height: 25.0),
        Card(
          elevation: 0, // Kartın kendi gölgesini kaldırın
          color: Colors.transparent, // Kartın arka planını şeffaf yapın
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white, // Kart rengini beyaz yapın
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5), // Gölge rengini ayarlayın ve saydamlık verin
                  spreadRadius: 2, // Gölgenin yayılma yarıçapını ayarlayın
                  blurRadius: 4, // Gölgenin bulanıklık yarıçapını ayarlayın
                  offset: Offset(0, 2), // Gölgenin konumunu ayarlayın
                ),
              ],
              borderRadius: BorderRadius.circular(15.0), // Köşeleri yuvarlayın
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
                        _buildSubscriptionCard(
                            'Süt Başlangıç Paketi', '£149,99 (Ay)',0xFFFFD600),
                        _buildSubscriptionCard(
                            'Süt Altın Paketi', '£199,99 (Ay)',0xFF26A69A),
                        _buildSubscriptionCard(
                            'Süt Platinum Paketi', '£249,99 (Ay)',0xFF8BC34A),
                        _buildSubscriptionCard(
                            'Süt Diamond Paketi', '£299,99 (Ay)',0xFF8BC34A),
                        _buildSubscriptionCard(
                            'Süt Ultimate Paketi', '£349,99 (Ay)',0xFF8BC34A),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                        onPressed: () {},
                        child: Text('Gizlilik Politikası',style: TextStyle(color: Colors.black),),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text('Kullanım Koşulları (EULA)',style: TextStyle(color: Colors.black)),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0,bottom: 8),
                    child: Text(
                        '* Uygulama İçi Satın Alım Gerektirir. Otomatik Yenilenir.',textAlign: TextAlign.center,style: TextStyle(fontSize: 12),),
                  ),

                ],
              ),
            ),
          ),
        ),

        SizedBox(height: 25.0),
              Row(
                children: [
                  Expanded(
                    child: Card(
                      shadowColor: Colors.cyan, // Gölge rengini ayarlayın
                      elevation: 4.0, // Gölgenin kalınlığını ayarlayın
                      color: Colors.white, // Kart rengini beyaz yapın
                      shape: RoundedRectangleBorder( // Köşeleri yuvarlatın
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: ListTile(
                        shape: RoundedRectangleBorder( // Köşeleri yuvarlatın
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        tileColor: Colors.white,
                        leading: Icon(Icons.account_balance),
                        title: Text('Gelir/Gider',style: GoogleFonts.roboto( textStyle: TextStyle(color: Colors.cyan,fontWeight: FontWeight.bold),),),
                        onTap: () {},
                      ),
                    ),
                  ),
                  Expanded(
                    child: Card(
                      shadowColor: Colors.cyan, // Gölge rengini ayarlayın
                      elevation: 4.0, // Gölgenin kalınlığını ayarlayın
                      color: Colors.white, // Kart rengini beyaz yapın
                      shape: RoundedRectangleBorder( // Köşeleri yuvarlatın
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: ListTile(
                        shape: RoundedRectangleBorder( // Köşeleri yuvarlatın
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        tileColor: Colors.white,
                        leading: Icon(Icons.sync),
                        title: Text('Sync.',style: GoogleFonts.roboto( textStyle: TextStyle(color: Colors.cyan,fontWeight: FontWeight.bold),),),
                        onTap: () {},
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.0),
              Row(
                children: [
                  Expanded(
                    child: Card(
                      shadowColor: Colors.cyan, // Gölge rengini ayarlayın
                      elevation: 4.0, // Gölgenin kalınlığını ayarlayın
                      color: Colors.white, // Kart rengini beyaz yapın
                      shape: RoundedRectangleBorder( // Köşeleri yuvarlatın
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: ListTile(
                        shape: RoundedRectangleBorder( // Köşeleri yuvarlatın
                          borderRadius: BorderRadius.circular(15.0),
                        ),tileColor: Colors.white,
                        leading: Icon(Icons.pie_chart),
                        title: Text('Sürüye Bakış',style: GoogleFonts.roboto( textStyle: TextStyle(color: Colors.cyan,fontWeight: FontWeight.bold),),),
                        onTap: () {},
                      ),
                    ),
                  ),
                  Expanded(
                    child: Card(
                      shadowColor: Colors.cyan, // Gölge rengini ayarlayın
                      elevation: 4.0, // Gölgenin kalınlığını ayarlayın
                      color: Colors.white, // Kart rengini beyaz yapın
                      shape: RoundedRectangleBorder( // Köşeleri yuvarlatın
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: ListTile(
                        shape: RoundedRectangleBorder( // Köşeleri yuvarlatın
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        tileColor: Colors.white,
                        leading: Icon(Icons.info),
                        title: Text('Süt Bilgileri',style: GoogleFonts.roboto( textStyle: TextStyle(color: Colors.cyan,fontWeight: FontWeight.bold),),),
                        onTap: () {},
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.0),
              Row(
                children: [
                  Expanded(
                    child: Card(
                      shadowColor: Colors.cyan, // Gölge rengini ayarlayın
                      elevation: 4.0, // Gölgenin kalınlığını ayarlayın
                      color: Colors.white, // Kart rengini beyaz yapın
                      shape: RoundedRectangleBorder( // Köşeleri yuvarlatın
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: ListTile(
                        shape: RoundedRectangleBorder( // Köşeleri yuvarlatın
                          borderRadius: BorderRadius.circular(15.0),
                        ),tileColor: Colors.white,
                        leading: Icon(Icons.account_balance),
                        title: Text('Gelir/Gider',style: GoogleFonts.roboto( textStyle: TextStyle(color: Colors.cyan,fontWeight: FontWeight.bold),),),
                        onTap: () {},
                      ),
                    ),
                  ),
                  Expanded(
                    child: Card(
                      elevation: 4.0, // Gölgenin kalınlığını ayarlayın
                      shadowColor: Colors.cyan, // Varsayılan gölge rengi
                      color: Colors.white, // Kart rengini beyaz yapın
                      shape: RoundedRectangleBorder( // Köşeleri yuvarlatın
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: ListTile(
                        shape: RoundedRectangleBorder( // Köşeleri yuvarlatın
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        tileColor: Colors.white,
                        leading: Icon(Icons.info),
                        title: Text('Süt Bilgileri',style: GoogleFonts.roboto( textStyle: TextStyle(color: Colors.cyan,fontWeight: FontWeight.bold),),),
                        onTap: () {},
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.0),
              Row(
                children: [
                  Expanded(
                    child: Card(
                      shadowColor: Colors.cyan, // Gölge rengini ayarlayın
                      elevation: 4.0, // Gölgenin kalınlığını ayarlayın
                      color: Colors.white, // Kart rengini beyaz yapın
                      shape: RoundedRectangleBorder( // Köşeleri yuvarlatın
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: ListTile(
                        shape: RoundedRectangleBorder( // Köşeleri yuvarlatın
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        tileColor: Colors.white,
                        leading: Icon(Icons.account_balance),
                        title: Text('Gelir/Gider',style: GoogleFonts.roboto( textStyle: TextStyle(color: Colors.cyan,fontWeight: FontWeight.bold),),),
                          onTap: () {},
                      ),
                    ),
                  ),
                  Expanded(
                    child: Card(
                      elevation: 4.0, // Gölgenin kalınlığını ayarlayın
                      shadowColor: Colors.cyan, // Varsayılan gölge rengi
                      color: Colors.white, // Kart rengini beyaz yapın
                      shape: RoundedRectangleBorder( // Köşeleri yuvarlatın
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: ListTile(
                        shape: RoundedRectangleBorder( // Köşeleri yuvarlatın
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        tileColor: Colors.white,
                        leading: Icon(Icons.info),
                        title: Text('Süt Bilgileri',style: GoogleFonts.roboto( textStyle: TextStyle(color: Colors.cyan,fontWeight: FontWeight.bold),),),
                        onTap: () {},
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIconButton(BuildContext context, String assetPath, String label, Widget page) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => page));
            },
            child: Image.asset(assetPath, width: 40.0, height: 40.0),
          ),
          SizedBox(height: 4.0),
          Text(label, textAlign: TextAlign.center),
        ],
      ),
    );
  }

  Widget _buildSubscriptionCard(String title, String price,int color_a) {
    return Container(
      width: 200, // Kartın genişliğini belirler
      child: Padding(
        padding: const EdgeInsets.only(right: 4.0,left: 4,top: 8),
        child: Card(
          color: Colors.transparent, // Arka plan rengini beyaz yapar
          elevation: 0, // Gölgeyi kaldırır
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white, // Kart rengini beyaz yapın
              boxShadow: [
                BoxShadow(
                  color: Color(color_a).withOpacity(0.5), // Gölge rengini ayarlayın ve saydamlık verin
                  spreadRadius: 2, // Gölgenin yayılma yarıçapını ayarlayın
                  blurRadius: 4, // Gölgenin bulanıklık yarıçapını ayarlayın
                  offset: Offset(0, 2), // Gölgenin konumunu ayarlayın
                ),
              ],
              borderRadius: BorderRadius.circular(15.0), // Köşeleri yuvarlayın
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 8.0),
                  Text(price, style: TextStyle(color: Colors.blue)),
                  SizedBox(height: 8.0),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Color(color_a)),
                    onPressed: () {},
                    child: Text('Abone Ol',style: TextStyle(color: Colors.white),),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  Widget _buildMenuButton(IconData icon, String label) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4.0),
      child: OutlinedButton(
        onPressed: () {},
        child: Row(
          children: [
            Icon(icon, size: 40.0),
            SizedBox(width: 8.0),
            Text(label, textAlign: TextAlign.center),
          ],
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
                      MaterialPageRoute(builder: (context) => CalendarPage()),
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

// Placeholder pages for navigation
class TumHayvanlarPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tüm Hayvanlar'),
      ),
      body: Center(
        child: Text('Tüm Hayvanlar Sayfası'),
      ),
    );
  }
}

class TohumlanmayaHazirPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tohumlanmaya Hazır'),
      ),
      body: Center(
        child: Text('Tohumlanmaya Hazır Sayfası'),
      ),
    );
  }
}

class MastiProPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MastiPro'),
      ),
      body: Center(
        child: Text('MastiPro Sayfası'),
      ),
    );
  }
}

class PedometerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pedometre'),
      ),
      body: Center(
        child: Text('Pedometre Sayfası'),
      ),
    );
  }
}

class GebelikKontrolPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gebelik Kontrol'),
      ),
      body: Center(
        child: Text('Gebelik Kontrol Sayfası'),
      ),
    );
  }
}