import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:merlabciftlikyonetim/FormFields/BuildNumberField.dart';
import 'package:merlabciftlikyonetim/YemYonetimi/BuildTextFeedField.dart';
import '../FormFields/FormButton.dart';
import '../FormFields/BuildSelectionField.dart';
import 'AddFeedController.dart';
import 'FeedController.dart';

class AddFeedPage extends StatelessWidget {
  final AddFeedController controller = Get.put(AddFeedController());
  final FeedController feedController = Get.find(); // FeedController'ı bul

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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 16),
                BuildTextFeedField(
                  label: 'Yeni Yem Adı *',
                  hint: '',
                  controller: controller.yemAdiController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Bu alan boş bırakılamaz';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                BuildNumberField(
                  label: 'Kuru Madde (%) *',
                  hint: '',
                  controller: controller.kuruMaddeController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Bu alan boş bırakılamaz';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                BuildNumberField(
                  label: 'UFL (kg başına) *',
                  hint: '',
                  controller: controller.uflController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Bu alan boş bırakılamaz';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                BuildNumberField(
                  label: 'Metabolizable Enerji, ME (kcal/kg) *',
                  hint: '',
                  controller: controller.meController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Bu alan boş bırakılamaz';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                BuildNumberField(
                  label: 'PDI (g/kg) *',
                  hint: '',
                  controller: controller.pdiController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Bu alan boş bırakılamaz';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                BuildNumberField(
                  label: 'Ham Protein CP (%) *',
                  hint: '',
                  controller: controller.hamProteinController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Bu alan boş bırakılamaz';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                BuildNumberField(
                  label: 'Lizin (%/PDI) *',
                  hint: '',
                  controller: controller.lizinController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Bu alan boş bırakılamaz';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                BuildNumberField(
                  label: 'Metionin (%/PDI) *',
                  hint: '',
                  controller: controller.metioninController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Bu alan boş bırakılamaz';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                BuildNumberField(
                  label: 'Kalsiyum abs (g/kg) *',
                  hint: '',
                  controller: controller.kalsiyumController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Bu alan boş bırakılamaz';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                BuildNumberField(
                  label: 'Fosfor abs (g/kg) *',
                  hint: '',
                  controller: controller.fosforController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Bu alan boş bırakılamaz';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                BuildNumberField(
                  label: 'Alt Limit (kg) *',
                  hint: '',
                  controller: controller.altLimitController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Bu alan boş bırakılamaz';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                BuildNumberField(
                  label: 'Üst Limit (kg) *',
                  hint: '',
                  controller: controller.ustLimitController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Bu alan boş bırakılamaz';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                BuildTextFeedField(
                  label: 'Notlar',
                  hint: '',
                  controller: controller.notlarController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Bu alan boş bırakılamaz';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                BuildSelectionField(
                  label: 'Tür',
                  value: controller.selectedTur,
                  options: ['Kaba Yem', 'Konsantre Yem','Diğer'], // Adjust this list accordingly
                  onSelected: (value) {
                    controller.selectedTur.value = value;
                  },
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: SizedBox(
                    width: double.infinity, // FormButton'un genişliğini tam olarak ayarlar
                    child: FormButton(
                      title: 'Ekle',
                      onPressed: () {
                        if (controller.formKey.currentState!.validate()) {
                          controller.saveFeedStock();
                          feedController.fetchFeedStocks(); // Veriler çekilip UI güncelleniyor
                          Get.back();
                          Get.snackbar('Başarılı', 'Yem Stoğu Eklendi');
                        } else {
                          Get.snackbar(
                            'Hata',
                            'Lütfen tüm alanları doldurunuz',
                            colorText: Colors.black,
                          );
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
