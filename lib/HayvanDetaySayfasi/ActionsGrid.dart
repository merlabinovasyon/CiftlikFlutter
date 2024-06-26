import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:merlabciftlikyonetim/HayvanAsiSayfasi/AnimalVaccinePage.dart';
import 'package:merlabciftlikyonetim/HayvanGebelikKontrolSayfasi/PregnancyCheckPage.dart';
import 'package:merlabciftlikyonetim/HayvanGrupSayfasi/AnimalGroupPage.dart';
import 'package:merlabciftlikyonetim/HayvanKonumSayfasi/AnimalLocationPage.dart';
import 'package:merlabciftlikyonetim/HayvanMuayeneSayfasi/AnimalExaminationPage.dart';
import 'package:merlabciftlikyonetim/HayvanNotSayfasi/AnimalNotePage.dart';
import 'ActionCard.dart';

class ActionsGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      crossAxisCount: 3,
      childAspectRatio: 2 / 2.5,
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      children: [
        ActionCard(
          title: 'Laktasyon',
          assetPath: 'resimler/icons/sheep_with_vaccine_icon_black.png',
          subtitle: 'Lak.no: 1\nGün: 0',
          onTap: () {
            print('Laktasyon tapped');
          },
        ),
        ActionCard(
          title: 'Tohumlama',
          assetPath: 'resimler/icons/sheep_with_vaccine_icon_black.png',
          onTap: () {
            print('Tohumlama tapped');
          },
        ),
        ActionCard(
          title: 'Gebelik Kontrolü',
          assetPath: 'resimler/icons/cow_with_magnifying_glass_icon.png',
          onTap: () {
            Get.to(() => PregnancyCheckPage(),duration: Duration(milliseconds: 650));
          },
        ),
        ActionCard(
          title: 'Canlı Ağırlık: 57',
          assetPath: 'resimler/icons/scale_icon_black.png',
          onTap: () {
            print('Canlı Ağırlık tapped');
          },
        ),
        ActionCard(
          title: 'VKS',
          assetPath: 'resimler/icons/sheep_with_vaccine_icon_black.png',
          onTap: () {
            print('VKS tapped');
          },
        ),
        ActionCard(
          title: 'Kuruda',
          assetPath: 'resimler/icons/sheep_with_vaccine_icon_black.png',
          onTap: () {
            print('Kuruda tapped');
          },
        ),
        ActionCard(
          title: 'Muayene',
          assetPath: 'resimler/icons/stethoscope_icon_black.png',
          onTap: () {
            Get.to(() => AnimalExaminationPage(),duration: Duration(milliseconds: 650));
          },
        ),
        ActionCard(
          title: 'Aşılama',
          assetPath: 'resimler/icons/vaccine_syringe_icon_black.png',
          onTap: () {
            Get.to(() => AnimalVaccinePage(),duration: Duration(milliseconds: 650));
          },
        ),
        ActionCard(
          title: 'Doğum Ekle',
          assetPath: 'resimler/icons/sheep_with_lamb_and_plus_icon_black.png',
          onTap: () {
            print('Doğum Ekle tapped');
          },
        ),
        ActionCard(
          title: 'Lokasyon',
          assetPath: 'resimler/icons/barn_with_location_icon_black.png',
          onTap: () {
            Get.to(() => AnimalLocationPage(),duration: Duration(milliseconds: 650));
          },
        ),
        ActionCard(
          title: 'Grup',
          assetPath: 'resimler/icons/sheep_and_cow_side_by_side_icon.png',
          onTap: () {
            Get.to(() => AnimalGroupPage(),duration: Duration(milliseconds: 650));
          },
        ),
        ActionCard(
          title: 'Notlar',
          assetPath: 'resimler/icons/notes_icon_black.png',
          onTap: () {
            Get.to(() => AnimalNotePage(),duration: Duration(milliseconds: 650));
          },
        ),
      ],
    );
  }
}
