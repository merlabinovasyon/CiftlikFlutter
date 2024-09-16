import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:merlabciftlikyonetim/A%C4%9F%C4%B1rl%C4%B1kRaporuSayfasi/WeightReportPage.dart';
import 'package:merlabciftlikyonetim/AnaSayfa/BuildSubscriptionSection.dart';
import 'package:merlabciftlikyonetim/AsiSayfasi/VaccinePage.dart';
import 'package:merlabciftlikyonetim/AsiTakvimi/AsiPage.dart';
import 'package:merlabciftlikyonetim/BildirimSayfasi/NotificationPage.dart';
import 'package:merlabciftlikyonetim/DenemeSayfasi/DenemePage.dart';
import 'package:merlabciftlikyonetim/EklemeSayfalari/KocKatim/KocKatimPage.dart';
import 'package:merlabciftlikyonetim/GelirGiderHesaplama/FinancePage.dart';
import 'package:merlabciftlikyonetim/GraphicPage.dart';
import 'package:merlabciftlikyonetim/HastalikSayfalari/DiseasePage.dart';
import 'package:merlabciftlikyonetim/Hayvanlar/AnimalPage.dart';
import 'package:merlabciftlikyonetim/Hayvanlar/S%C3%BCttenKesilmisHayvanlar/WeanedAnimalPage.dart';
import 'package:merlabciftlikyonetim/KonumYonetimi/KonumYonetimiPage.dart';
import 'package:merlabciftlikyonetim/MuayeneSayfasi/ExaminationPage.dart';
import 'package:merlabciftlikyonetim/RasyonHesaplama/RationWizardMainPage.dart';
import 'package:merlabciftlikyonetim/SutOlcumGosterimiSayfasi/SutOlcumPage.dart';
import 'package:merlabciftlikyonetim/YemYonetimi/FeedStockPage.dart';
import '../Drawer/DrawerMenu.dart';
import '../gebelik_kontrol_page.dart';
import '../pedometer_page.dart';
import '../tohumlanmaya_hazir_page.dart';
import 'BuildIconButton.dart';
import 'BuildActionCardRow.dart';
import 'ExpandingFab.dart';
import 'HomeController.dart';

class HomePage extends StatelessWidget {
  final HomeController controller = Get.put(HomeController());
  final TextEditingController searchController = TextEditingController();
  final FocusNode searchFocusNode = FocusNode();

  HomePage({super.key});

  void navigateToAnimalPage(String query) async {
    final result = await Get.to(() => AnimalPage(searchQuery: query), duration: Duration(milliseconds: 650));
    if (result == true) {
      searchController.clear(); // Geri dönüldüğünde arama alanını temizle
      controller.isSearching.value = false; // Arama durumunu sıfırla
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false; // Geri tuşuna basıldığında hiçbir şey yapılmamasını sağlar
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          scrolledUnderElevation: 0.0,
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
                Obx(() {
                  return TextField(
                    focusNode: searchFocusNode,
                    controller: searchController,
                    cursorColor: Colors.black54,
                    decoration: InputDecoration(
                      prefixIcon: controller.isSearching.value
                          ? null
                          : const Icon(Icons.search),
                      hintText: 'Küpe No, Hayvan Adı',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      suffixIcon: controller.isSearching.value
                          ? IconButton(
                        icon: const Icon(Icons.search),
                        onPressed: () {
                          navigateToAnimalPage(searchController.text);
                        },
                      )
                          : IconButton(
                        icon: const Icon(Icons.qr_code_scanner),
                        onPressed: () {
                          Get.snackbar('Uyarı', 'Kulak küpesini okutun');
                        },
                      ),
                    ),
                    onChanged: (value) {
                      controller.isSearching.value = value.isNotEmpty;
                    },
                    onTapOutside: (event) {
                      searchFocusNode.unfocus(); // Dışarı tıklanırsa klavyeyi kapat ve imleci gizle
                    },
                  );
                }),
                const SizedBox(height: 16.0),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      BuildIconButton(
                        assetPath: 'resimler/hayvanlarim.png',
                        label: 'Tüm Hayvanlar',
                        onTap: () => Get.to(AnimalPage(searchQuery: ''), duration: Duration(milliseconds: 650)),
                      ),
                      BuildIconButton(
                        assetPath: 'resimler/kuzu_2.png',
                        label: 'Sütten Kesilmiş',
                        onTap: () => Get.to(WeanedAnimalPage(searchQuery: ''), duration: Duration(milliseconds: 650)),
                      ),
                      BuildIconButton(
                        assetPath: 'resimler/koc_katim_1.png',
                        label: 'Koç Katım',
                        onTap: () => Get.to(KocKatimPage(), duration: Duration(milliseconds: 650)),
                      ),
                      BuildIconButton(
                        assetPath: 'resimler/süt_olcum.png',
                        label: 'Süt Ölçümleri',
                        onTap: () => Get.to(SutOlcumPage(), duration: Duration(milliseconds: 650)),
                      ),
                      BuildIconButton(
                        assetPath: 'resimler/kuzu_1.png',
                        label: 'Gebelik Kontrol',
                        onTap: () => Get.to(GebelikKontrolPage(), duration: Duration(milliseconds: 650)),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 25.0),
                BuildSubscriptionSection(),
                const SizedBox(height: 25.0),
                BuildActionCardRow(
                  title1: 'Gelir/Gider',
                  iconAsset1: 'icons/calculator_icon_black.png',
                  onTap1: () {
                    Get.to(() => FinancePage(), duration: Duration(milliseconds: 650));
                  },
                  title2: 'Muayene',
                  iconAsset2: 'icons/stethoscope_icon_black.png',
                  onTap2: () {
                    Get.to(() => ExaminationPage(), duration: Duration(milliseconds: 650));

                  },
                ),
                const SizedBox(height: 10.0),
                BuildActionCardRow(
                  title1: 'Sürü Takip',
                  iconAsset1: 'icons/flock_with_analysis_icon_black.png',
                  onTap1: () {
                    Get.to(() => GraphicPage(), duration: Duration(milliseconds: 650));
                  },
                  title2: 'Aşılama',
                  iconAsset2: 'icons/vaccine_syringe_icon_black.png',
                  onTap2: () {
                    Get.to(() => VaccinePage(), duration: Duration(milliseconds: 650));
                  },
                ),
                const SizedBox(height: 10.0),
                BuildActionCardRow(
                  title1: 'Konum Yönetimi',
                  iconAsset1: 'icons/barn_with_location_icon_black.png',
                  onTap1: () {
                    Get.to(() => KonumYonetimiPage(), duration: Duration(milliseconds: 650));
                  },
                  title2: 'Yem Yönetimi',
                  iconAsset2: 'icons/corn_icon_black.png',
                  onTap2: () {
                    Get.to(() => FeedStockPage(), duration: Duration(milliseconds: 650));
                  },
                ),
                const SizedBox(height: 10.0),
                BuildActionCardRow(
                  title1: 'Aşı Takvimi',
                  iconAsset1: 'icons/calendar_with_vaccine_icon_black.png',
                  onTap1: () {
                    Get.to(() => AsiPage(), duration: Duration(milliseconds: 650));
                  },
                  title2: 'Hastalık Takibi',
                  iconAsset2: 'icons/sheep_with_illness_icon_black.png',
                  onTap2: () {
                    Get.to(() => DiseasePage(), duration: Duration(milliseconds: 650));
                  },
                ),
                const SizedBox(height: 10.0),
                BuildActionCardRow(
                  title1: 'Raporlar',
                  iconAsset1: 'icons/report_icon.png',
                  onTap1: () {
                    Get.to(() => WeightReportPage(tagNo: ''), duration: Duration(milliseconds: 650));

                  },
                  title2: 'Rasyon',
                  iconAsset2: 'icons/magic_wand_with_sparkles_icon.png',
                  onTap2: () {
                    Get.to(() => RationWizardMainPage(), duration: Duration(milliseconds: 650));
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
