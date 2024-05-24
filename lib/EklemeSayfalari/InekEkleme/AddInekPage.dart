import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:merlabciftlikyonetim/FormFields/BuildSelectionField.dart';
import 'package:merlabciftlikyonetim/FormFields/BuildDateField.dart';
import 'package:merlabciftlikyonetim/FormFields/BuildTimeField.dart';
import 'package:merlabciftlikyonetim/FormFields/BuildTextField.dart';
import 'package:merlabciftlikyonetim/FormFields/BuildCounterField.dart';
import 'package:merlabciftlikyonetim/FormUtils/FormUtils.dart';
import '../../FormFields/FormButton.dart';
import 'AddInekController.dart';

class AddInekPage extends StatelessWidget {
  final AddInekController controller = Get.put(AddInekController());
  final FormUtils utils = FormUtils();

  AddInekPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () {
                controller.resetForm();
                Get.back();
              },
            );
          },
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: controller.formKey,
          child: ListView(
            children: [
              const SizedBox(height: 10),
              const Text(
                'İneğinizin bilgilerini giriniz.',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),
              const Card(
                shadowColor: Colors.cyan,
                elevation: 4.0,
                color: Colors.white,
                margin: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'İnek ağırlık:  kg',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const BuildTextField(label: 'Küpe No *', hint: 'GEÇİCİ_NO_16032'),
              const SizedBox(height: 16),
              const BuildTextField(label: 'Devlet Küpe No *', hint: 'GEÇİCİ_NO_16032'),
              const SizedBox(height: 16),
              BuildSelectionField(
                label: 'Irk *',
                value: controller.selectedInek,
                options: controller.inek,
                onSelected: (value) {
                  controller.selectedInek.value = value;
                },
              ),
              const SizedBox(height: 16),
              const BuildTextField(label: 'Hayvan Adı', hint: ''),
              const SizedBox(height: 16),
              BuildCounterField(label: 'İnek Tipi', controller: controller.countController, title: 'inek'),
              const SizedBox(height: 16),
              BuildDateField(label: 'İneğin Kayıt Tarihi *', controller: controller.dobController),
              const SizedBox(height: 16),
              BuildTimeField(label: 'İneğin Kayıt Zamanı', controller: controller.timeController, onTap: utils.showTimePicker),
              SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0,right: 8,left: 8),
                child: FormButton(
                  onPressed: () {
                    if (controller.formKey.currentState!.validate()) {
                      Get.snackbar(
                        'Başarılı',
                        'Kayıt başarılı',
                      );
                      Future.delayed(const Duration(seconds: 1), () {
                        Get.offAllNamed('/bottomNavigation');
                      });
                    }
                  },
                ),
              ),            ],
          ),
        ),
      ),
    );
  }
}