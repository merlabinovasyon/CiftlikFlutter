import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'AnimalController.dart';
import 'FilterableTabBar.dart';

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
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: 'Küpe No, Hayvan Adı, Kemer No',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            const SizedBox(height: 8.0),
            Expanded(
              child: Obx(
                    () => ListView.builder(
                  itemCount: controller.animals.length,
                  itemBuilder: (context, index) {
                    final animal = controller.animals[index];
                    return AnimalCard(animal: animal);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AnimalCard extends StatefulWidget {
  final Animal animal;

  const AnimalCard({Key? key, required this.animal}) : super(key: key);

  @override
  _AnimalCardState createState() => _AnimalCardState();
}

class _AnimalCardState extends State<AnimalCard> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 4.0,
      shadowColor: Colors.cyan,
      margin: const EdgeInsets.only(bottom: 10.0),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          onExpansionChanged: (bool expanding) => setState(() => isExpanded = expanding),
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(15.0),
            child: Image.asset(
              widget.animal.image,
              height: 50,
              width: 50,
              fit: BoxFit.cover,
            ),
          ),
          title: isExpanded
              ? const Text('Detaylar')
              : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Küpe No: ${widget.animal.kupeNo}'),
              Text('Hayvan Adı: ${widget.animal.hayvanAdi}'),
            ],
          ),
          tilePadding: const EdgeInsets.symmetric(horizontal: 16.0),
          childrenPadding: const EdgeInsets.all(8.0),
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: Image.asset(
                widget.animal.image,
                height: 100,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 8.0),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Kuzunun Koyunu: ${widget.animal.koyun}'),
                      Text('Kuzunun Koçu: ${widget.animal.koc}'),
                      Text('Doğum Saati: ${widget.animal.dogumSaati}'),
                      Text('Doğum Tarihi: ${widget.animal.dogumTarihi}'),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Küpe No: ${widget.animal.kupeNo}'),
                      Text('Devlet Küpe No: ${widget.animal.devletKupeNo}'),
                      Text('Hayvan Adı: ${widget.animal.hayvanAdi}'),
                      Text('Cinsiyet: ${widget.animal.cinsiyet}'),
                      Text('Kuzu Tipi: ${widget.animal.kuzuTipi}'),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
