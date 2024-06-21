import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'AddVaccinePage.dart';
import 'VaccineCard.dart';
import 'VaccineController.dart';

class VaccinePage extends StatefulWidget {
  VaccinePage({super.key});

  @override
  _VaccinePageState createState() => _VaccinePageState();
}

class _VaccinePageState extends State<VaccinePage> {
  final VaccineController controller = Get.put(VaccineController());

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
            TextField(
              cursorColor: Colors.black54,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: 'Aşı Adı',
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
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    // Aşı ekleme işlemi burada yapılabilir
                    Get.to(() => AddVaccinePage(),duration: Duration(milliseconds: 650));
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.white,
                  ),
                  child: Row(
                    children: [
                      Text('Aşı Ekle', style: TextStyle(color: Colors.black)),
                      Icon(Icons.add, color: Colors.black),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            Expanded(
              child: Obx(
                    () => ListView.builder(
                  itemCount: controller.vaccines.length,
                  itemBuilder: (context, index) {
                    final vaccine = controller.vaccines[index];
                    return VaccineCard(vaccine: vaccine);
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
