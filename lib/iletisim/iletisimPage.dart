import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Drawer/DrawerMenu.dart';
import 'iletisim_controller.dart';

class IletisimPage extends StatelessWidget {
  const IletisimPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final IletisimController iletisimController = Get.put(IletisimController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        elevation: 4,
        shadowColor: Colors.black38,
        title: const Text("Bize Ulaşın"),
      ),
      drawer: const DrawerMenu(),
      body: Obx(() {
        if (iletisimController.animalList.isEmpty) {
          return const Center(child: Text('Veri bulunamadı.'));
        } else {
          return RefreshIndicator(
            onRefresh: iletisimController.refreshAnimalList,
            child: ListView.builder(
              itemCount: iletisimController.animalList.length,
              itemBuilder: (context, index) {
                final animal = iletisimController.animalList[index];
                return ListTile(
                  title: Text(animal['animaltype'] ?? 'Belirtilmemiş'),
                  subtitle: Text(animal['typedesc'] ?? 'Belirtilmemiş'),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Veriyi Sil'),
                          content: const Text('Bu veriyi silmek istediğinizden emin misiniz?'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: const Text('İptal'),
                            ),
                            TextButton(
                              onPressed: () async {
                                await iletisimController.deleteAnimal(animal['id']);
                                Navigator.of(context).pop();
                              },
                              child: const Text('Sil'),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          );
        }
      }),
    );
  }
}
