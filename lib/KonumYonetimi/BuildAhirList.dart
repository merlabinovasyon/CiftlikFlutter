import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'KonumController.dart';

class BuildAhirList extends StatelessWidget {
  final KonumController controller;
  final TextEditingController ahirController;
  final _formKey = GlobalKey<FormState>();
  final FocusNode searchFocusNodeAdd = FocusNode();
  final FocusNode searchFocusNodeUpdate = FocusNode();

  BuildAhirList({
    required this.controller,
    required this.ahirController,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Ahır Listesi', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  Get.dialog(
                    AlertDialog(
                      backgroundColor: Colors.white,
                      title: Text('Ahır Ekle'),
                      content: TextField(
                        focusNode: searchFocusNodeAdd,
                        cursorColor: Colors.black54,
                        controller: ahirController,
                        decoration: InputDecoration(
                          hintText: 'Ahır adı giriniz',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide(color: Colors.black), // Odaklanıldığında border rengi
                          ),
                        ),
                        onTapOutside: (event) {
                          searchFocusNodeAdd.unfocus(); // Dışarı tıklanırsa klavyeyi kapat ve imleci gizle
                        },
                      ),
                      actions: [
                        TextButton(
                          onPressed: () async {
                            if (ahirController.text.isNotEmpty &&
                                !controller.ahirList.any((ahir) => ahir['name'] == ahirController.text)) {
                              int newAhirId = await controller.addAhir(ahirController.text);
                              controller.selectAhir(newAhirId); // Yeni eklenen ahır seçili kalır
                              ahirController.clear();
                              Get.back();
                            } else if (controller.ahirList.any((ahir) => ahir['name'] == ahirController.text)) {
                              Get.snackbar('Hata', 'Aynı adda ahır mevcut', backgroundColor: Colors.white, colorText: Colors.black);
                            }
                          },
                          child: Text('Ekle', style: TextStyle(color: Colors.black)),
                        ),
                        TextButton(
                          onPressed: () {
                            ahirController.clear();
                            Get.back();
                          },
                          child: Text('İptal', style: TextStyle(color: Colors.black)),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Obx(() {
                if (controller.ahirList.isEmpty) {
                  return Center(child: Text('Lütfen bir ahır ekleyin'));
                }
                return ListView.builder(
                  itemCount: controller.ahirList.length,
                  itemBuilder: (context, index) {
                    return Card(
                      color: Colors.white,
                      elevation: 2,
                      shadowColor: Colors.cyan,
                      child: ListTile(
                        leading: IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            ahirController.text = controller.ahirList[index]['name'];
                            Get.dialog(
                              AlertDialog(
                                backgroundColor: Colors.white,
                                title: Text('Ahır Adını Güncelle'),
                                content: Form(
                                  key: _formKey,
                                  child: TextFormField(
                                    focusNode: searchFocusNodeUpdate,
                                    cursorColor: Colors.black54,
                                    controller: ahirController,
                                    decoration: InputDecoration(
                                      hintText: 'Yeni ahır adı giriniz',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8.0),
                                        borderSide: BorderSide(color: Colors.black), // Odaklanıldığında border rengi
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Lütfen ahır adı giriniz';
                                      } else if (controller.ahirList.any((ahir) => ahir['name'] == value)) {
                                        return 'Aynı adda ahır mevcut';
                                      }
                                      return null;
                                    },
                                    onTapOutside: (event) {
                                      searchFocusNodeUpdate.unfocus(); // Dışarı tıklanırsa klavyeyi kapat ve imleci gizle
                                    },
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        controller.updateAhir(index, ahirController.text);
                                        ahirController.clear();
                                        Get.back();
                                      }
                                    },
                                    child: Text('Güncelle', style: TextStyle(color: Colors.black)),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      ahirController.clear();
                                      Get.back();
                                    },
                                    child: Text('İptal', style: TextStyle(color: Colors.black)),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                        title: Text(controller.ahirList[index]['name']),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            controller.removeAhir(index);
                          },
                        ),
                        onTap: () {
                          controller.selectAhir(controller.ahirList[index]['id']);
                        },
                      ),
                    );
                  },
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
