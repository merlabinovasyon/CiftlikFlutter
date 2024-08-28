import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:merlabciftlikyonetim/FormFields/FormButton.dart';
import 'AddExaminationController.dart';

class AddExaminationPage extends StatelessWidget {
  final AddExaminationController controller = Get.put(AddExaminationController());
  final FocusNode searchFocusNodeExam = FocusNode();
  final FocusNode searchFocusNodeExamDesc = FocusNode();

  AddExaminationPage({super.key});

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
            Get.back(result: false);
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
                'Muayene Adı ve Açıklamasını giriniz.',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),
              TextFormField(
                focusNode: searchFocusNodeExam,
                cursorColor: Colors.black54,
                decoration: InputDecoration(
                  labelText: 'Muayene Adı *',
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
                  controller.examinationName.value = value;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Muayene Adı boş bırakılamaz';
                  }
                  return null;
                },
                onTapOutside: (event) {
                  searchFocusNodeExam.unfocus(); // Dışarı tıklanırsa klavyeyi kapat ve imleci gizle
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                focusNode: searchFocusNodeExamDesc,
                cursorColor: Colors.black54,
                decoration: InputDecoration(
                  labelText: 'Muayene Açıklaması *',
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
                  controller.examinationDescription.value = value;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Muayene Açıklaması boş bırakılamaz';
                  }
                  return null;
                },
                onTapOutside: (event) {
                  searchFocusNodeExamDesc.unfocus(); // Dışarı tıklanırsa klavyeyi kapat ve imleci gizle
                },
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0, right: 8, left: 8),
                child: FormButton(
                  title: 'Kaydet',
                  onPressed: controller.saveExaminationData,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
