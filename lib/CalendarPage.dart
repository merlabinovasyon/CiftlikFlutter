import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';

import 'drawer_menu.dart';


class CalendarPage extends StatelessWidget {
  const CalendarPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 4,
        shadowColor: Colors.black38,
        title: Row(
          children: [
            SizedBox(width: 90),
            Text("Ajanda"),
          ],
        ),
      ),
      drawer: DrawerMenu(),
      body: AjandaForm(),
    );
  }
}

class AjandaForm extends StatefulWidget {
  @override
  _AjandaFormState createState() => _AjandaFormState();
}

class _AjandaFormState extends State<AjandaForm> {
  TextEditingController animalTypeController = TextEditingController();
  TextEditingController typeDescController = TextEditingController();

  late Database _database;
  String _databaseName = 'merlab.db';
  String _tableName = 'AnimalType';

  Future<void> _initializeDatabase() async {
    String directory = await getDatabasesPath();
    String path = join(directory, _databaseName);
    print("Veritabanı yolu: $path"); // Dosya yolunu print et
    _database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
          await db.execute('''
          CREATE TABLE IF NOT EXISTS $_tableName (
            id INTEGER PRIMARY KEY,
            animaltype TEXT,
            typedesc TEXT,
            logo INTEGER,
            isactive INTEGER,
            userid INTEGER
          )
          ''');
        });
  }

  Future<void> _insertAnimal(String animalType, String typeDesc, BuildContext context) async {
    await _database.transaction((txn) async {
      await txn.rawInsert('''
      INSERT INTO $_tableName(animaltype, typedesc, logo, isactive, userid)
      VALUES('$animalType', '$typeDesc', "", 0, 0)
      ''');
    });
    // Eklenen veri için başarı mesajı göster
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Veri başarıyla eklendi.'),
        duration: Duration(seconds: 2), // SnackBar'ın görüntüleneceği süre
      ),
    );
  }


  @override
  void initState() {
    super.initState();
    _initializeDatabase();
  }

  @override
  void dispose() {
    _database.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            controller: animalTypeController,
            decoration: InputDecoration(labelText: 'Hayvan Türü'),
          ),
          SizedBox(height: 20),
          TextField(
            controller: typeDescController,
            decoration: InputDecoration(labelText: 'Tür Açıklaması'),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              String animalType = animalTypeController.text;
              String typeDesc = typeDescController.text;
              _insertAnimal(animalType, typeDesc, context); // context eklenir
              // Veri eklendikten sonra textfield'ları temizle
              animalTypeController.clear();
              typeDescController.clear();
            },
            child: Text('Kaydet'),
          ),

        ],
      ),
    );
  }
}
