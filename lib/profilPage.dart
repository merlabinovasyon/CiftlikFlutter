import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:merlabciftlikyonetim/services/DatabaseService.dart';
import 'package:merlabciftlikyonetim/services/SyncService.dart';
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';

class profilPage extends StatefulWidget {
  const profilPage({Key? key}) : super(key: key);

  @override
  _profilPageState createState() => _profilPageState();
}

class _profilPageState extends State<profilPage> {
  String _imagePath = ''; // Değişiklik burada
  final SyncService syncService = SyncService(); // syncService tanımı
  final DatabaseService databaseService = DatabaseService(); // syncService tanımı
  final TextEditingController emailController = TextEditingController(); // Email için controller

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
        child: GestureDetector(
          onTap: () {
            _showImagePickerDialog();
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
                    child: _imagePath.isNotEmpty ? _imageWidget() : _addPhotoIcon(), // Değişiklik burada
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0,right: 15),
                  child: TextField(
                    controller: emailController,
                    decoration: InputDecoration(labelText: 'Email'),
                    keyboardType: TextInputType.emailAddress,
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    await _syncUsersFromApiToDatabase(); // syncService kullanımı
                  },
                  child: Text("Mysql to Sqlite"),
                ),
                SizedBox(height: 10,),
                ElevatedButton(
                  onPressed: () async {
                    await _syncAnimalTypes(); // syncService kullanımı
                  },
                  child: Text("Mysql to Sqlite Animal"),
                ),
                SizedBox(height: 10,),
                ElevatedButton(
                  onPressed: () async {
                    await _syncAnimalTypesToMySQL(); // syncService kullanımı
                  },
                  child: Text("Sqlite to Mysql Animal"),
                ),
                SizedBox(height: 10,),
                ElevatedButton(
                  onPressed: () async {
                    await _syncAnimalSubtypesToMySQL(); // syncService kullanımı
                  },
                  child: Text("Sqlite to Mysql AnimalSubType"),
                ),
                SizedBox(height: 10,),
                ElevatedButton(
                  onPressed: () async {
                    await _syncAnimalSubtypes(); // syncService kullanımı
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
      await _savePhotoToDatabase(savedImage.path); // Veritabanına fotoğraf yolu kaydet
      setState(() {
        _imagePath = savedImage.path; // Yeni fotoğraf yolunu ayarla
      });
    }
  }

  Future<void> _getImageFromCamera() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      final savedImage = File(pickedFile.path);
      await _savePhotoToDatabase(savedImage.path); // Veritabanına fotoğraf yolu kaydet
      setState(() {
        _imagePath = savedImage.path; // Yeni fotoğraf yolunu ayarla
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
        _imagePath = result.last['logo']; // Kayıtlı fotoğraf yolunu al
      });
    } else {
      setState(() {
        _imagePath = ''; // Kayıtlı fotoğraf yoksa başlangıçta boş bir dize olarak ayarla
      });
    }
    await db.close();
  }

  Future<void> _syncUsersFromApiToDatabase() async {
    try {
      final email = emailController.text; // Emaili al
      await syncService.syncSpecificUserFromApiToDatabase(-1, email); // syncService kullanımı

      // Snackbar göster
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Veri başarıyla eklendi.'),
          duration: Duration(seconds: 2), // Snackbar süresi
        ),
      );
    } catch (e) {
      // Snackbar göster
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Bir hata oluştu: $e'),
          duration: Duration(seconds: 2), // Snackbar süresi
        ),
      );
    }
  }

  Future<void> _syncAnimalTypes() async {
    try {
      await syncService.syncAnimalTypes(context); // syncService kullanımı

      // Snackbar göster
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Veri başarıyla eklendi.'),
          duration: Duration(seconds: 2), // Snackbar süresi
        ),
      );
    } catch (e) {
      // Snackbar göster
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Bir hata oluştu: $e'),
          duration: Duration(seconds: 2), // Snackbar süresi
        ),
      );
    }
  }

  Future<void> _syncAnimalTypesToMySQL() async {
    try {
      await syncService.syncAnimalTypesToMySQL(context); // syncService kullanımı

      // Snackbar göster
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Veri başarıyla eklendi.'),
          duration: Duration(seconds: 2), // Snackbar süresi
        ),
      );
    } catch (e) {
      // Snackbar göster
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Bir hata oluştu: $e'),
          duration: Duration(seconds: 2), // Snackbar süresi
        ),
      );
    }
  }

  Future<void> _syncAnimalSubtypes() async {
    try {
      await syncService.syncAnimalSubtypes(context); // syncService kullanımı

      // Snackbar göster
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Veri başarıyla eklendi.'),
          duration: Duration(seconds: 2), // Snackbar süresi
        ),
      );
    } catch (e) {
      // Snackbar göster
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Bir hata oluştu: $e'),
          duration: Duration(seconds: 2), // Snackbar süresi
        ),
      );
    }
  }

  Future<void> _syncAnimalSubtypesToMySQL() async {
    try {
      await syncService.syncAnimalSubtypesToMySQL(context); // syncService kullanımı

      // Snackbar göster
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Veri başarıyla eklendi.'),
          duration: Duration(seconds: 2), // Snackbar süresi
        ),
      );
    } catch (e) {
      // Snackbar göster
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Bir hata oluştu: $e'),
          duration: Duration(seconds: 2), // Snackbar süresi
        ),
      );
    }
  }
}
