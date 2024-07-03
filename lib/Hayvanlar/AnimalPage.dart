import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'AnimalController.dart';
import 'FilterableTabBar.dart';
import 'AnimalCard.dart'; // Yeni dosyayı içe aktarın

class AnimalPage extends StatefulWidget {
  AnimalPage({super.key});

  @override
  _AnimalPageState createState() => _AnimalPageState();
}

class _AnimalPageState extends State<AnimalPage> with TickerProviderStateMixin {
  late final TabController _tabController;
  final AnimalController controller = Get.put(AnimalController());

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 8, vsync: this);
    controller.fetchAnimals('lambTable'); // Default fetch on first tab
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Get.back();
          },
        ),
        title: Center(
          child: Padding(
            padding: const EdgeInsets.only(right: 60.0),
            child: Container(
              height: 40,
              width: 130,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('resimler/logo_v2.png'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            FilterableTabBar(tabController: _tabController),
            const SizedBox(height: 8.0),
            TextField(
              cursorColor: Colors.black54,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: 'Küpe No, Hayvan Adı, Kemer No',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(color: Colors.black), // Odaklanıldığında border rengi
                ),
              ),
            ),
            const SizedBox(height: 8.0),
            Expanded(
              child: Obx(
                    () {
                  if (controller.isLoading.value) {
                    return Center(child: CircularProgressIndicator(color: Colors.black,));
                  } else if (controller.animals.isEmpty) {
                    return Center(child: Text('Hayvan bulunamadı'));
                  } else {
                    return ListView.builder(
                      itemCount: controller.animals.length,
                      itemBuilder: (context, index) {
                        final animal = controller.animals[index];
                        return AnimalCard(animal: animal, tableName: _tabController.index == 6 || _tabController.index == 7 ? 'weaned' : '');
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
