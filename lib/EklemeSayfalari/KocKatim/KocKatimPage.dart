import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:merlabciftlikyonetim/FormUtils/FormUtils.dart';
import '../../FormFields/BuildSelectionField.dart';
import '../../FormFields/FormButton.dart';
import 'KocKatimController.dart';

class KocKatimPage extends StatelessWidget {
  final KocKatimController controller = Get.put(KocKatimController());
  final FormUtils utils = FormUtils();

  KocKatimPage({super.key});

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
                'Koyun ve koçunuzu seçerek eşleme yapınız.',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),
              BuildSelectionField(
                label: 'Koyununuz *',
                value: controller.selectedAnimal,
                options: controller.animals,
                onSelected: (value) {
                  controller.selectedAnimal.value = value;
                },
              ),
              const SizedBox(height: 16),
              BuildSelectionField(
                label: 'Koçunuz *',
                value: controller.selectedKoc,
                options: controller.koc,
                onSelected: (value) {
                  controller.selectedKoc.value = value;
                },
              ),
              SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0,right: 8,left: 8),
                child: FormButton(
                  title: 'Kaydet',
                  onPressed: () {
                    if (controller.formKey.currentState!.validate()) {
                      Get.snackbar(
                        'Başarılı',
                        'Eşleme başarılı',
                      );
                      Future.delayed(const Duration(seconds: 1), () {
                        Get.offAllNamed('/bottomNavigation');
                      });
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
