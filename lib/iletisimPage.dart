import 'package:flutter/material.dart';
import 'package:merlabciftlikyonetim/drawer_menu.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class iletisimPage extends StatefulWidget {
  const iletisimPage({Key? key}) : super(key: key);

  @override
  _iletisimPageState createState() => _iletisimPageState();
}

class _iletisimPageState extends State<iletisimPage> {
  late Future<List<Map<String, dynamic>>> _animalListFuture;

  @override
  void initState() {
    super.initState();
    _animalListFuture = _getAnimalList();
  }

  Future<List<Map<String, dynamic>>> _getAnimalList() async {
    // Veritabanı oluşturma veya varolanı açma
    final database = openDatabase(
      join(await getDatabasesPath(), 'merlab.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE IF NOT EXISTS AnimalType(id INTEGER PRIMARY KEY, animaltype TEXT, typedesc TEXT)',
        );
      },
      version: 1,
    );

    // Veritabanından tüm verileri çekme
    final Database db = await database;
    return db.query('AnimalType');
  }

  Future<void> _deleteAnimal(int id) async {
    final database = openDatabase(
      join(await getDatabasesPath(), 'merlab.db'),
      version: 1,
    );

    final db = await database;
    await db.delete(
      'AnimalType',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        elevation: 4,
        shadowColor: Colors.black38,
        title: Text("Bize Ulaşın"),
      ),
      drawer: DrawerMenu(),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _animalListFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Hata: ${snapshot.error}'));
          } else {
            final animalList = snapshot.data!;
            return ListView.builder(
              itemCount: animalList.length,
              itemBuilder: (context, index) {
                final animal = animalList[index];
                return ListTile(
                  title: Text(animal['animaltype'] ?? 'Belirtilmemiş'),
                  subtitle: Text(animal['typedesc'] ?? 'Belirtilmemiş'),
                  trailing: IconButton(
                    icon: Icon(Icons.delete,color: Colors.red,),
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
                                await _deleteAnimal(animal['id']);
                                setState(() {
                                  _animalListFuture = _getAnimalList();
                                });
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
        },
      ),
    );
  }
}

