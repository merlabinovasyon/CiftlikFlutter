import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:merlabciftlikyonetim/FormFields/FormButton.dart';
import 'AddVaccineController.dart';

class AddVaccinePage extends StatelessWidget {
  final AddVaccineController controller = Get.put(AddVaccineController());

  AddVaccinePage({super.key});

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
                'Aşı Adı ve Açıklamasını giriniz.',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),
              TextFormField(
                cursorColor: Colors.black54,
                decoration: InputDecoration(
                  labelText: 'Aşı Adı *',
                  labelStyle: TextStyle(color: Colors.black),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(color: Colors.grey, width: 1.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
                onChanged: (value) {
                  controller.vaccineName.value = value;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Aşı Adı boş bırakılamaz';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                cursorColor: Colors.black54,
                decoration: InputDecoration(
                  labelText: 'Aşı Açıklaması *',
                  labelStyle: TextStyle(color: Colors.black),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(color: Colors.grey, width: 1.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
                onChanged: (value) {
                  controller.vaccineDescription.value = value;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Aşı Açıklaması boş bırakılamaz';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0, right: 8, left: 8),
                child: FormButton(
                  title: 'Kaydet',
                  onPressed: controller.saveVaccineData,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
