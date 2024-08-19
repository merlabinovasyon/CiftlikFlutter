import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../FormFields/FormButton.dart';
import '../FormFields/BuildTextField.dart';
import '../FormFields/BuildSelectionField.dart';
import 'AddFeedController.dart';

class AddFeedPage extends StatelessWidget {
  final AddFeedController controller = Get.put(AddFeedController());

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
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: controller.formKey,
          child: ListView(
            children: [
              const SizedBox(height: 16),
              BuildTextField(
                label: 'Yeni Yem Adı *',
                hint: '',
                controller: controller.yemAdiController,
              ),
              const SizedBox(height: 16),
              BuildTextField(
                label: 'Kuru Madde (%) *',
                hint: '',
                controller: controller.kuruMaddeController,
              ),
              const SizedBox(height: 16),
              BuildTextField(
                label: 'UFL (kg başına) *',
                hint: '',
                controller: controller.uflController,
              ),
              const SizedBox(height: 16),
              BuildTextField(
                label: 'Metabolizable Enerji, ME (kcal/kg) *',
                hint: '',
                controller: controller.meController,
              ),
              const SizedBox(height: 16),
              BuildTextField(
                label: 'PDI (g/kg) *',
                hint: '',
                controller: controller.pdiController,
              ),
              const SizedBox(height: 16),
              BuildTextField(
                label: 'Ham Protein CP (%) *',
                hint: '',
                controller: controller.hamProteinController,
              ),
              const SizedBox(height: 16),
              BuildTextField(
                label: 'Lizin (%/PDI) *',
                hint: '',
                controller: controller.lizinController,
              ),
              const SizedBox(height: 16),
              BuildTextField(
                label: 'Metionin (%/PDI) *',
                hint: '',
                controller: controller.metioninController,
              ),
              const SizedBox(height: 16),
              BuildTextField(
                label: 'Kalsiyum abs (g/kg) *',
                hint: '',
                controller: controller.kalsiyumController,
              ),
              const SizedBox(height: 16),
              BuildTextField(
                label: 'Fosfor abs (g/kg) *',
                hint: '',
                controller: controller.fosforController,
              ),
              const SizedBox(height: 16),
              BuildTextField(
                label: 'Alt Limit (kg) *',
                hint: '',
                controller: controller.altLimitController,
              ),
              const SizedBox(height: 16),
              BuildTextField(
                label: 'Üst Limit (kg) *',
                hint: '',
                controller: controller.ustLimitController,
              ),
              const SizedBox(height: 16),
              BuildTextField(
                label: 'Fiyat *',
                hint: '',
                controller: controller.fiyatController,
              ),
              const SizedBox(height: 16),
              BuildTextField(
                label: 'Notlar',
                hint: '',
                controller: controller.notlarController,
              ),
              const SizedBox(height: 16),
              BuildSelectionField(
                label: 'Tür',
                value: controller.selectedTur,
                options: ['Tür 1', 'Tür 2'], // Adjust this list accordingly
                onSelected: (value) {
                  controller.selectedTur.value = value;
                },
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0, right: 8, left: 8),
                child: FormButton(
                  title: 'Ekle',
                  onPressed: () {
                    if (controller.formKey.currentState!.validate()) {
                      // Add your save logic here
                      Get.back();
                      Get.snackbar('Başarılı', 'Yem Stoğu Eklendi');
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
