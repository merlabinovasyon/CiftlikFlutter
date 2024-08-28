import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../FormFields/BuildNumberField.dart';
import '../FormFields/BuildSelectionField.dart';
import '../FormFields/BuildTextField.dart';
import '../FormFields/FormButton.dart';
import 'BuildTextFeedField.dart';
import 'FeedController.dart';
import 'FeedDetailEditController.dart';

class FeedDetailEditPage extends StatelessWidget {
  final FeedDetailEditController controller = Get.put(FeedDetailEditController());
  final int feedId;
  final FeedController feedController = Get.find(); // FeedController'ı bulun

  FeedDetailEditPage({required this.feedId}) {
    controller.loadFeedDetails(feedId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Get.back();
          },
        ),
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
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: controller.formKey,
          child: ListView(
            children: [
              SizedBox(height: 16),
              BuildTextFeedField(
                label: 'Yem Adı',
                controller: controller.yemAdiController,
                hint: '',
              ),
              SizedBox(height: 16),
              BuildNumberField(
                label: 'Kuru Madde (%)',
                controller: controller.kuruMaddeController, hint: '',
              ),
              SizedBox(height: 16),
              BuildNumberField(
                label: 'UFL (kg başına)',
                controller: controller.uflController, hint: '',
              ),
              SizedBox(height: 16),
              BuildNumberField(
                label: 'Metabolizable Enerji, ME (kcal/kg)',
                controller: controller.meController, hint: '',
              ),
              SizedBox(height: 16),
              BuildNumberField(
                label: 'PDI (g/kg)',
                controller: controller.pdiController, hint: '',
              ),
              SizedBox(height: 16),
              BuildNumberField(
                label: 'Ham Protein CP (%)',
                controller: controller.hamProteinController, hint: '',
              ),
              SizedBox(height: 16),
              BuildNumberField(
                label: 'Lizin (%/PDI)',
                controller: controller.lizinController, hint: '',
              ),
              SizedBox(height: 16),
              BuildNumberField(
                label: 'Metionin (%/PDI)',
                controller: controller.metioninController, hint: '',
              ),
              SizedBox(height: 16),
              BuildNumberField(
                label: 'Kalsiyum abs (g/kg)',
                controller: controller.kalsiyumController, hint: '',
              ),
              SizedBox(height: 16),
              BuildNumberField(
                label: 'Fosfor abs (g/kg)',
                controller: controller.fosforController, hint: '',
              ),
              SizedBox(height: 16),
              BuildNumberField(
                label: 'Alt Limit (kg)',
                controller: controller.altLimitController, hint: '',
              ),
              SizedBox(height: 16),
              BuildNumberField(
                label: 'Üst Limit (kg)',
                controller: controller.ustLimitController, hint: '',
              ),
              SizedBox(height: 16),
              BuildTextFeedField(
                label: 'Notlar',
                controller: controller.notlarController,
                hint: '',
              ),
              SizedBox(height: 16),
              BuildSelectionField(
                label: 'Tür',
                value: controller.selectedTur,
                options: ['Kaba Yem', 'Konsantre Yem', 'Diğer'], // Gerçek seçeneklerle güncelleyin
                onSelected: (value) {
                  controller.selectedTur.value = value;
                },
              ),
              SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0, right: 8, left: 8),
                child: FormButton(
                  title: 'Güncelle',
                  onPressed: () async {
                    if (controller.formKey.currentState!.validate()) {
                      controller.updateFeedDetails(feedId);
                      feedController.fetchFeedStocks(); // Feed listesi güncelleniyor
                      Get.back(result: true);
                      Get.snackbar('Başarılı', 'Yem Stoğu Güncellendi', duration: Duration(milliseconds: 1800));
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
