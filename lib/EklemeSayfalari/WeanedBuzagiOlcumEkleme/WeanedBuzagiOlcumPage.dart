import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:merlabciftlikyonetim/FormUtils/FormUtils.dart';
import '../../FormFields/BuildSelectionField.dart';
import '../../FormFields/FormButton.dart';
import '../../FormFields/WeightField.dart';
import 'WeanedBuzagiOlcumController.dart';

class WeanedBuzagiOlcumPage extends StatelessWidget {
  final WeanedBuzagiOlcumController controller = Get.put(WeanedBuzagiOlcumController());
  final FormUtils utils = FormUtils();

  WeanedBuzagiOlcumPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            controller.resetForm();
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
              const SizedBox(height: 10),
              const Text(
                'Sütten kesilmiş ölçümü yapılan buzağınızı seçiniz.',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),
              WeightField(),
              const SizedBox(height: 25),
              BuildSelectionField(
                label: 'Buzağınız *',
                value: controller.selectedType,
                options: controller.types,
                onSelected: (value) {
                  controller.selectedType.value = value;
                },
              ),
              SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0, right: 8, left: 8),
                child: FormButton(
                  title: 'Kaydet',
                  onPressed: () {
                    if (controller.formKey.currentState!.validate()) {
                      String? selectedType = controller.selectedType.value;
                      if (selectedType != null) {
                        if (selectedType.startsWith('Buzağı')) {
                          Get.snackbar(
                            'Başarılı',
                            'Kayıt başarılı',
                          );
                          Future.delayed(const Duration(seconds: 1), () {
                            Get.offAllNamed('/bottomNavigation');
                          });
                        }
                      }
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
