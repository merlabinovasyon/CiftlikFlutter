import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'SutOlcumController.dart';
import 'FilterableSutTabBar.dart';
import 'SutOlcumCard.dart';

class SutOlcumPage extends StatefulWidget {
  SutOlcumPage({super.key});

  @override
  _SutOlcumPageState createState() => _SutOlcumPageState();
}

class _SutOlcumPageState extends State<SutOlcumPage> with TickerProviderStateMixin {
  late final TabController _tabController;
  final SutOlcumController controller = Get.put(SutOlcumController());
  final FocusNode searchFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    controller.fetchSutOlcum('sutOlcumInekTable'); // Default fetch on first tab

    // Tab değiştiğinde verileri yeniden yükle
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        switch (_tabController.index) {
          case 0:
            controller.fetchSutOlcum('sutOlcumInekTable');
            break;
          case 1:
            controller.fetchSutOlcum('sutOlcumKoyunTable');
            break;
        }
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  String getTableName() {
    switch (_tabController.index) {
      case 0:
        return 'sutOlcumInekTable';
      case 1:
        return 'sutOlcumKoyunTable';
      default:
        return 'sutOlcumInekTable';
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
            FilterableSutTabBar(tabController: _tabController),
            const SizedBox(height: 8.0),
            TextField(
              focusNode: searchFocusNode,
              cursorColor: Colors.black54,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: 'Hayvan,Tarih',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(color: Colors.black),
                ),
              ),
              onChanged: (value) {
                controller.searchQuery.value = value;
              },
              onTapOutside: (event) {
                searchFocusNode.unfocus(); // Dışarı tıklanırsa klavyeyi kapat ve imleci gizle
              },
            ),
            const SizedBox(height: 8.0),
            Expanded(
              child: Obx(
                    () {
                  if (controller.isLoading.value) {
                    return Center(child: CircularProgressIndicator(color: Colors.black));
                  } else if (controller.filteredSutOlcumList.isEmpty) {
                    return Center(child: Text('Süt ölçüm bilgisi bulunamadı'));
                  } else {
                    return ListView.builder(
                      itemCount: controller.filteredSutOlcumList.length,
                      itemBuilder: (context, index) {
                        final sutOlcum = controller.filteredSutOlcumList[index];
                        return SutOlcumCard(sutOlcum: sutOlcum, tableName: getTableName());
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
