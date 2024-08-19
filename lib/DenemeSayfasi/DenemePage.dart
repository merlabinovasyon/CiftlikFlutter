import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'DenemeController.dart';

class DenemePage extends StatelessWidget {
  final DenemeController controller = Get.put(DenemeController());
  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Deneme Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: textEditingController,
              decoration: InputDecoration(
                labelText: 'Yazınızı Girin',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Butona tıklandığında ID'nin oluşturulması
                controller.generateUniqueId(textEditingController.text);
                // Oluşturulan ID'nin ekrana yazdırılması
                Get.snackbar('Benzersiz ID', controller.uniqueId.value,
                    snackPosition: SnackPosition.BOTTOM);
              },
              child: Text('ID Oluştur'),
            ),
            SizedBox(height: 20),
            Obx(() => Text(
              'Oluşturulan ID: ${controller.uniqueId.value}',
              style: TextStyle(fontSize: 20),
            )),
            SizedBox(height: 20),
            Expanded(
              child: Obx(() => ListView.builder(
                itemCount: controller.generatedIds.length,
                itemBuilder: (context, index) {
                  final id = controller.generatedIds.elementAt(index);
                  return ListTile(
                    title: Text(id),
                  );
                },
              )),
            ),
          ],
        ),
      ),
    );
  }
}
