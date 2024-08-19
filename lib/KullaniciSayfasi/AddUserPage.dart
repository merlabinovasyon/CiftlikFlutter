import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../FormFields/BuildSelectionField.dart';
import '../FormFields/FormButton.dart';
import '../Register/BuildTelephoneSelectionField.dart';
import 'AddUserController.dart';

class AddUserPage extends StatelessWidget {
  final AddUserController controller = Get.put(AddUserController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        controller.resetForm();
        return true;
      },
      child: Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: controller.formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Kullanıcı Ekle', style: TextStyle(fontSize: 18)),
                      IconButton(
                        icon: Icon(Icons.close),
                        onPressed: () {
                          controller.resetForm();
                          Get.back();
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: '* İsim',
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
                      controller.name.value = value;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: '* Email Adresi',
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
                      controller.email.value = value;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: '* Şifreniz',
                      suffixIcon: Icon(Icons.visibility_off),
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
                      controller.password.value = value;
                    },
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Flexible(
                        flex: 4,
                        child: BuildTelephoneSelectionField(
                          label: 'Ülke Kodu',
                          value: controller.selectedCountryCode,
                          options: controller.countryCodes,
                          onSelected: (value) {
                            controller.selectedCountryCode.value = value;
                          },
                        ),
                      ),
                      SizedBox(width: 7),
                      Expanded(
                        flex: 8,
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: '* Telefon Numarası',
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
                            controller.phoneNumber.value = value;
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  BuildSelectionField(
                    label: '*Tür',
                    value: controller.userType,
                    options: ['Veteriner Hekim', 'Çiftlik Sahibi'], // Adjust with real options
                    onSelected: (value) {
                      controller.userType.value = value;
                    },
                  ),
                  const SizedBox(height: 16),
                  BuildSelectionField(
                    label: 'Ben bir veterinerim',
                    value: controller.isVet,
                    options: ['Evet', 'Hayır'], // Adjust with real options
                    onSelected: (value) {
                      controller.isVet.value = value;
                    },
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0, left: 8),
                    child: FormButton(
                      title: 'Kaydet',
                      onPressed: () {
                        if (controller.formKey.currentState!.validate()) {
                          controller.addUser();
                          controller.resetForm();
                          Get.back();
                          Get.snackbar('Başarılı', 'Kullanıcı Kaydedildi');
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}