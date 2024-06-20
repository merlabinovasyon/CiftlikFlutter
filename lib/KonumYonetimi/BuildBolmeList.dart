import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'KonumController.dart';

class BuildBolmeList extends StatelessWidget {
  final KonumController controller;
  final TextEditingController bolmeController;

  BuildBolmeList({
    required this.controller,
    required this.bolmeController,
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
              Text('Bölme Listesi', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  if (controller.ahirList.isEmpty) {
                    Get.snackbar('Uyarı', 'Önce bir ahır ekleyin');
                    return;
                  }
                  showDialog(
                    context: Get.context!,
                    builder: (context) {
                      return AlertDialog(
                        backgroundColor: Colors.white,
                        title: Text('Bölme Ekle'),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Obx(() {
                              return DropdownButton<String>(
                                dropdownColor: Colors.white,
                                value: controller.selectedAhir.value.isEmpty
                                    ? null
                                    : controller.selectedAhir.value,
                                hint: Text('Ahır seçiniz'),
                                items: controller.ahirList.map((ahir) {
                                  return DropdownMenuItem<String>(
                                    value: ahir,
                                    child: Text(ahir),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  controller.selectedAhir.value = value!;
                                },
                              );
                            }),
                            TextField(
                              cursorColor: Colors.black54,
                              controller: bolmeController,
                              decoration: InputDecoration(
                                hintText: 'Bölme adı giriniz',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: BorderSide(color: Colors.black), // Odaklanıldığında border rengi
                                ),
                              ),
                            ),
                          ],
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              if (controller.selectedAhir.value.isNotEmpty &&
                                  bolmeController.text.isNotEmpty) {
                                controller.addBolme(controller.selectedAhir.value, bolmeController.text);
                                bolmeController.clear();
                                Get.back();
                              }
                            },
                            child: Text('Ekle', style: TextStyle(color: Colors.black)),
                          ),
                          TextButton(
                            onPressed: () {
                              bolmeController.clear();
                              Get.back();
                            },
                            child: Text('İptal', style: TextStyle(color: Colors.black)),
                          ),
                        ],
                      );
                    },
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
                  return Center(child: Text('Ahır ekledikten sonra lütfen bölme ekleyin'));
                }
                final filteredBolmeList = controller.bolmeList.where((bolme) {
                  return bolme['ahir'] == controller.selectedAhir.value;
                }).toList();
                if (controller.selectedAhir.value.isNotEmpty && filteredBolmeList.isEmpty) {
                  return Center(child: Text('Lütfen ahırınıza bölme ekleyin'));
                }
                return ListView.builder(
                  itemCount: filteredBolmeList.length,
                  itemBuilder: (context, index) {
                    return Card(
                      color: Colors.white,
                      elevation: 2,
                      shadowColor: Colors.cyan,
                      child: ListTile(
                        title: Text(filteredBolmeList[index]['bolme']!),
                        subtitle: Text('Ahır: ${filteredBolmeList[index]['ahir']}'),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            controller.removeBolme(filteredBolmeList[index]['ahir']!, filteredBolmeList[index]['bolme']!);
                          },
                        ),
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
