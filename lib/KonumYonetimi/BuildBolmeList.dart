import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'KonumController.dart';
import 'BuildBolmeSelectionField.dart';

class BuildBolmeList extends StatelessWidget {
  final KonumController controller;
  final TextEditingController bolmeController;
  final FocusNode searchFocusNode = FocusNode();

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
                    Get.snackbar('Uyarı', 'Lütfen önce ahır ekleyin');
                    return;
                  }
                  Get.dialog(
                    AlertDialog(
                      backgroundColor: Colors.white,
                      title: Text('Bölme Ekle'),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          BuildBolmeSelectionField(
                            label: 'Ahır seçiniz',
                            value: controller.selectedAhirId,
                            options: controller.ahirList,
                            onSelected: (value) {
                              controller.selectAhir(value);
                            },
                          ),
                          SizedBox(height: 10,),
                          TextField(
                            focusNode: searchFocusNode,
                            cursorColor: Colors.black54,
                            controller: bolmeController,
                            decoration: InputDecoration(
                              hintText: 'Bölme adı giriniz',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                                borderSide: BorderSide(color: Colors.black), // Odaklanıldığında border rengi
                              ),
                            ),
                            onTapOutside: (event) {
                              searchFocusNode.unfocus(); // Dışarı tıklanırsa klavyeyi kapat ve imleci gizle
                            },
                          ),
                        ],
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            if (controller.selectedAhirId.value != null &&
                                bolmeController.text.isNotEmpty) {
                              controller.addBolme(controller.selectedAhirId.value!, bolmeController.text);
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
                  return Center(child: Text('Ahır ekledikten sonra lütfen bölme ekleyin'));
                }
                if (controller.selectedAhirId.value == null) {
                  return Center(child: Text('Lütfen ahır seçiniz'));
                }
                final filteredBolmeList = controller.bolmeList.where((bolme) {
                  return bolme['ahirId'] == controller.selectedAhirId.value;
                }).toList();
                if (filteredBolmeList.isEmpty) {
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
                        title: Text(filteredBolmeList[index]['name']),
                        subtitle: Text('Ahır: ${controller.ahirList.firstWhere((ahir) => ahir['id'] == filteredBolmeList[index]['ahirId'])['name']}'),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            controller.removeBolme(filteredBolmeList[index]['id']);
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
