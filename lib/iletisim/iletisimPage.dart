import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Drawer/drawer_menu.dart';
import 'iletisim_controller.dart';

class iletisimPage extends StatelessWidget {
  const iletisimPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final IletisimController iletisimController = Get.put(IletisimController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        elevation: 4,
        shadowColor: Colors.black38,
        title: Text("Bize Ulaşın"),
      ),
      drawer: DrawerMenu(),
      body: Obx(() {
        if (iletisimController.animalList.isEmpty) {
          return Center(child: Text('Veri bulunamadı.'));
        } else {
          return ListView.builder(
            itemCount: iletisimController.animalList.length,
            itemBuilder: (context, index) {
              final animal = iletisimController.animalList[index];
              return ListTile(
                title: Text(animal['animaltype'] ?? 'Belirtilmemiş'),
                subtitle: Text(animal['typedesc'] ?? 'Belirtilmemiş'),
                trailing: IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Veriyi Sil'),
                        content: Text('Bu veriyi silmek istediğinizden emin misiniz?'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: Text('İptal'),
                          ),
                          TextButton(
                            onPressed: () async {
                              await iletisimController.deleteAnimal(animal['id']);
                              Navigator.of(context).pop();
                            },
                            child: Text('Sil'),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              );
            },
          );
        }
      }),
    );
  }
}
