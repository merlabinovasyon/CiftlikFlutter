import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'AnimalController.dart';
import 'FilterableTabBar.dart';
import 'AnimalCard.dart';

class AnimalPage extends StatefulWidget {
  final String searchQuery;

  AnimalPage({super.key, required this.searchQuery});

  @override
  _AnimalPageState createState() => _AnimalPageState();
}

class _AnimalPageState extends State<AnimalPage> with TickerProviderStateMixin {
  late final TabController _tabController;
  final AnimalController controller = Get.put(AnimalController());
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 8, vsync: this);
    searchController.text = widget.searchQuery;
    controller.fetchAnimals(getTableName()); // Default fetch on first tab
    _filterAnimals(widget.searchQuery);

    // Tab değiştiğinde hayvanları yeniden yükle
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        controller.fetchAnimals(getTableName());
        _filterAnimals(searchController.text);
      }
    });
  }

  void _filterAnimals(String query) {
    controller.searchQuery.value = query;
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  String getTableName() {
    switch (_tabController.index) {
      case 0:
        return 'lambTable';
      case 1:
        return 'buzagiTable';
      case 2:
        return 'koyunTable';
      case 3:
        return 'kocTable';
      case 4:
        return 'inekTable';
      case 5:
        return 'bogaTable';
      case 6:
        return 'weanedKuzuTable';
      case 7:
        return 'weanedBuzagiTable';
      default:
        return 'lambTable';
    }
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
            Get.back(result: true); // Geri dönerken sonucu ilet
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
              controller: searchController,
              onChanged: (value) {
                _filterAnimals(value);
              },
              cursorColor: Colors.black54,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: 'Küpe No, Hayvan Adı, Kemer No',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(color: Colors.black),
                ),
              ),
            ),
            const SizedBox(height: 8.0),
            Expanded(
              child: Obx(
                    () {
                  if (controller.isLoading.value) {
                    return Center(child: CircularProgressIndicator(color: Colors.black));
                  } else if (controller.filteredAnimals.isEmpty) {
                    return Center(child: Text('Hayvan bulunamadı'));
                  } else {
                    return ListView.builder(
                      itemCount: controller.filteredAnimals.length,
                      itemBuilder: (context, index) {
                        final animal = controller.filteredAnimals[index];
                        return AnimalCard(animal: animal, tableName: getTableName());
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
