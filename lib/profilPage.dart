import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:merlabciftlikyonetim/SyncService.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';

class profilPage extends StatefulWidget {
  const profilPage({Key? key}) : super(key: key);

  @override
  _profilPageState createState() => _profilPageState();
}

class _profilPageState extends State<profilPage> {
  String _imagePath = '';
  final SyncService syncService = SyncService(); // SyncService sınıfından bir nesne oluştur

  @override
  void initState() {
    super.initState();
    _getImagePathFromDatabase(); // Veritabanından fotoğraf yolunu al
  }

  @override
  Widget build(BuildContext context) {
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                _showImagePickerDialog();
              },
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  shape: BoxShape.circle,
                ),
                child: _imagePath.isNotEmpty ? _imageWidget() : _addPhotoIcon(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _syncUsersFromApiToDatabase, // Buton basıldığında fonksiyonu çalıştır
              child: Text("MySQL'den SQLite'a Kullanıcıları Senkronize Et"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _imageWidget() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(100),
      child: Image.file(
        File(_imagePath),
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

  Future<void> _showImagePickerDialog() async {
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
                _getImageFromGallery();
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.camera_alt),
              title: Text("Fotoğraf Çek"),
              onTap: () {
                _getImageFromCamera();
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _getImageFromGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final savedImage = File(pickedFile.path);
      await _savePhotoToDatabase(savedImage.path);
      setState(() {
        _imagePath = savedImage.path;
      });
    }
  }

  Future<void> _getImageFromCamera() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      final savedImage = File(pickedFile.path);
      await _savePhotoToDatabase(savedImage.path);
      setState(() {
        _imagePath = savedImage.path;
      });
    }
  }

  Future<void> _savePhotoToDatabase(String imagePath) async {
    final dbPath = await getDatabasesPath();
    final db = await openDatabase(path.join(dbPath, 'merlab.db'));
    await db.execute('''
      CREATE TABLE IF NOT EXISTS AnimalType (
        id INTEGER PRIMARY KEY,
        logo TEXT
      )
    ''');
    await db.rawInsert('''
      INSERT INTO AnimalType (logo) VALUES (?)
    ''', [imagePath]);
    await db.close();
  }

  Future<void> _getImagePathFromDatabase() async {
    final dbPath = await getDatabasesPath();
    final db = await openDatabase(path.join(dbPath, 'merlab.db'));
    final List<Map<String, dynamic>> result = await db.query('AnimalType');
    if (result.isNotEmpty) {
      setState(() {
        _imagePath = result.last['logo'];
      });
    } else {
      setState(() {
        _imagePath = '';
      });
    }
    await db.close();
  }

  Future<void> _syncUsersFromApiToDatabase() async {
    try {
      await syncService.syncUsersFromApiToDatabase(); // MySQL'den SQLite'a kullanıcıları senkronize eden metod
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Kullanıcılar başarıyla senkronize edildi."))
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Kullanıcı senkronizasyonu başarısız: $e"))
      );
    }
  }
}
