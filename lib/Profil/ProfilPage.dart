import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:merlabciftlikyonetim/Profil/profil_controller.dart';
import '../Drawer/drawer_menu.dart';

class ProfilPage extends StatelessWidget {
  const ProfilPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ProfilController profilController = Get.put(ProfilController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        elevation: 4,
        shadowColor: Colors.black38,
        title: Row(
          children: [
            SizedBox(width: 90),
            Text("Profil"),
          ],
        ),
      ),
      drawer: DrawerMenu(),
      body: Center(
        child: GestureDetector(
          onTap: () {
            _showImagePickerDialog(context, profilController);
          },
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      shape: BoxShape.circle,
                    ),
                    child: Obx(() => profilController.imagePath.value.isNotEmpty
                        ? _imageWidget(profilController.imagePath.value)
                        : _addPhotoIcon()),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0, right: 15),
                  child: TextField(
                    controller: profilController.emailController,
                    decoration: InputDecoration(labelText: 'Email'),
                    keyboardType: TextInputType.emailAddress,
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    await profilController.syncUsersFromApiToDatabase(context);
                  },
                  child: Text("Mysql to Sqlite"),
                ),
                SizedBox(height: 10,),
                ElevatedButton(
                  onPressed: () async {
                    await profilController.syncAnimalTypes(context);
                  },
                  child: Text("Mysql to Sqlite Animal"),
                ),
                SizedBox(height: 10,),
                ElevatedButton(
                  onPressed: () async {
                    await profilController.syncAnimalTypesToMySQL(context);
                  },
                  child: Text("Sqlite to Mysql Animal"),
                ),
                SizedBox(height: 10,),
                ElevatedButton(
                  onPressed: () async {
                    await profilController.syncAnimalSubtypesToMySQL(context);
                  },
                  child: Text("Sqlite to Mysql AnimalSubType"),
                ),
                SizedBox(height: 10,),
                ElevatedButton(
                  onPressed: () async {
                    await profilController.syncAnimalSubtypes(context);
                  },
                  child: Text("Mysql to Sqlite AnimalSubType"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _imageWidget(String imagePath) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(100),
      child: Image.file(
        File(imagePath),
        width: 200,
        height: 200,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _addPhotoIcon() {
    return Center(
      child: Icon(
        Icons.add_a_photo,
        size: 50,
        color: Colors.black54,
      ),
    );
  }

  Future<void> _showImagePickerDialog(BuildContext context, ProfilController profilController) async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Fotoğraf Ekle"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.photo_library),
              title: Text("Galeriden Seç"),
              onTap: () {
                profilController.getImageFromGallery();
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.camera_alt),
              title: Text("Fotoğraf Çek"),
              onTap: () {
                profilController.getImageFromCamera();
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
