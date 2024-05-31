import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../EklemeSayfalari/BogaEkleme/AddBogaPage.dart';
import '../EklemeSayfalari/InekEkleme/AddInekPage.dart';

class SelectTypeBuyukPage extends StatelessWidget {
  const SelectTypeBuyukPage({super.key});

  @override
  Widget build(BuildContext context) {
    final double yukseklik = MediaQuery.of(context).size.height;
    final double genislik = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Get.back();
          },
        ),
        backgroundColor: Colors.white,
        title: Center(
          child: Padding(
            padding: const EdgeInsets.only(right: 60.0),
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
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: yukseklik / 10), // Üstten boşluk
          const Text(
            'Ekleyeceğiniz Büyükbaş Hayvanın Türünü Seçiniz',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: yukseklik / 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  Get.to(() => AddBogaPage());
                },
                child: Column(
                  children: [
                    Card(
                      child: Container(
                        width: genislik / 2.5,
                        height: yukseklik / 4,
                        decoration: BoxDecoration(
                          color: Colors.white, // Kart rengini beyaz yapın
                          boxShadow: [
                            BoxShadow(
                              color: Colors.cyan.withOpacity(0.5), // Gölge rengini ayarlayın ve saydamlık verin
                              spreadRadius: 2, // Gölgenin yayılma yarıçapını ayarlayın
                              blurRadius: 4, // Gölgenin bulanıklık yarıçapını ayarlayın
                              offset: const Offset(0, 2), // Gölgenin konumunu ayarlayın
                            ),
                          ],
                          borderRadius: BorderRadius.circular(15.0), // Köşeleri yuvarlayın
                          image: const DecorationImage(
                            image: AssetImage('resimler/selecttypeboga.webp'), // Birinci resim dosyasının yolu
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: yukseklik / 100), // Resim ile metin arasındaki boşluk
                    Card(
                      color: Colors.cyan,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Boğa',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: yukseklik / 30),
              GestureDetector(
                onTap: () {
                  Get.to(() => AddInekPage());
                },
                child: Column(
                  children: [
                    Card(
                      child: Container(
                        width: genislik / 2.5,
                        height: yukseklik / 4,
                        decoration: BoxDecoration(
                          color: Colors.white, // Kart rengini beyaz yapın
                          boxShadow: [
                            BoxShadow(
                              color: Colors.cyan.withOpacity(0.5), // Gölge rengini ayarlayın ve saydamlık verin
                              spreadRadius: 2, // Gölgenin yayılma yarıçapını ayarlayın
                              blurRadius: 4, // Gölgenin bulanıklık yarıçapını ayarlayın
                              offset: const Offset(0, 2), // Gölgenin konumunu ayarlayın
                            ),
                          ],
                          borderRadius: BorderRadius.circular(15.0), // Köşeleri yuvarlayın
                          image: const DecorationImage(
                            image: AssetImage('resimler/selecttypeinek.webp'), // İkinci resim dosyasının yolu
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: yukseklik / 100), // Resim ile metin arasındaki boşluk
                    Card(
                      color: Colors.cyan,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'İnek',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}