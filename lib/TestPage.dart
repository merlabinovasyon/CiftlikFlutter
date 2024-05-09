import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class TestPage extends StatefulWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
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
          'CREATE TABLE IF NOT EXISTS AnimalSubType(id INTEGER PRIMARY KEY, animalsubtypename TEXT, animaltype TEXT)',
        );
      },
      version: 1,
    );

    // Veritabanından tüm verileri çekme
    final Database db = await database;
    return db.query('AnimalSubType');
  }

  Future<void> _deleteAnimal(int id) async {
    final database = openDatabase(
      join(await getDatabasesPath(), 'merlab.db'),
      version: 1,
    );

    final db = await database;
    await db.delete(
      'AnimalSubType',
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
                  title: Text(animal['animalsubtypename'] ?? 'Belirtilmemiş,',style: GoogleFonts.roboto(fontWeight: FontWeight.bold)),
                  subtitle: Text(animal['animaltype'] ?? 'Belirtilmemiş',style: GoogleFonts.roboto(fontWeight: FontWeight.bold)),
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

