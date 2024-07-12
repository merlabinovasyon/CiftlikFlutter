import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:merlabciftlikyonetim/HayvanAsiSayfasi/AnimalVaccinePage.dart';
import 'package:merlabciftlikyonetim/HayvanGebelikKontrolSayfasi/PregnancyCheckPage.dart';
import 'package:merlabciftlikyonetim/HayvanGrupSayfasi/AnimalGroupPage.dart';
import 'package:merlabciftlikyonetim/HayvanKonumSayfasi/AnimalLocationPage.dart';
import 'package:merlabciftlikyonetim/HayvanMuayeneSayfasi/AnimalExaminationPage.dart';
import 'package:merlabciftlikyonetim/HayvanNotSayfasi/AnimalNotePage.dart';
import 'ActionCard.dart';
import 'AnimalDetailController.dart';

class ActionsGrid extends StatelessWidget {
  final AnimalDetailController controller = Get.put(AnimalDetailController());
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
          assetPath: 'icons/sheep_with_vaccine_icon_black.png',
          subtitle: 'Lak.no: 1\nGün: 0',
          onTap: () {
            print('Laktasyon tapped');
          },
        ),
        ActionCard(
          title: 'Tohumlama',
          assetPath: 'icons/sheep_with_vaccine_icon_black.png',
          onTap: () {
            print('Tohumlama tapped');
          },
        ),
        ActionCard(
          title: 'Gebelik Kontrolü',
          assetPath: 'icons/cow_with_magnifying_glass_icon.png',
          onTap: () {
            Get.to(() => PregnancyCheckPage(tagNo: controller.animalDetails['tagNo'] ?? ''),duration: Duration(milliseconds: 650));
          },
        ),
        ActionCard(
          title: 'Canlı Ağırlık: 57',
          assetPath: 'icons/scale_icon_black.png',
          onTap: () {
            print('Canlı Ağırlık tapped');
          },
        ),
        ActionCard(
          title: 'VKS',
          assetPath: 'icons/sheep_with_vaccine_icon_black.png',
          onTap: () {
            print('VKS tapped');
          },
        ),
        ActionCard(
          title: 'Kuruda',
          assetPath: 'icons/sheep_with_vaccine_icon_black.png',
          onTap: () {
            print('Kuruda tapped');
          },
        ),
        ActionCard(
          title: 'Muayene',
          assetPath: 'icons/stethoscope_icon_black.png',
          onTap: () {
            Get.to(() => AnimalExaminationPage(tagNo: controller.animalDetails['tagNo'] ?? ''),duration: Duration(milliseconds: 650));
          },
        ),
        ActionCard(
          title: 'Aşılama',
          assetPath: 'icons/vaccine_syringe_icon_black.png',
          onTap: () {
            Get.to(() => AnimalVaccinePage(tagNo: controller.animalDetails['tagNo'] ?? ''),duration: Duration(milliseconds: 650));
          },
        ),
        ActionCard(
          title: 'Doğum Ekle',
          assetPath: 'icons/sheep_with_lamb_and_plus_icon_black.png',
          onTap: () {
            print('Doğum Ekle tapped');
          },
        ),
        ActionCard(
          title: 'Lokasyon',
          assetPath: 'icons/barn_with_location_icon_black.png',
          onTap: () {
            Get.to(() => AnimalLocationPage(tagNo: controller.animalDetails['tagNo'] ?? ''),duration: Duration(milliseconds: 650));
          },
        ),
        ActionCard(
          title: 'Grup',
          assetPath: 'icons/sheep_and_cow_side_by_side_icon.png',
          onTap: () {
            Get.to(() => AnimalGroupPage(tagNo: controller.animalDetails['tagNo'] ?? ''),duration: Duration(milliseconds: 650));
          },
        ),
        ActionCard(
          title: 'Notlar',
          assetPath: 'icons/notes_icon_black.png',
          onTap: () {
            Get.to(() => AnimalNotePage(tagNo: controller.animalDetails['tagNo'] ?? ''),duration: Duration(milliseconds: 650));
          },
        ),
      ],
    );
  }
}
