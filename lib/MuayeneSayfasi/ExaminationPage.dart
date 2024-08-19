import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'AddExaminationPage.dart';
import 'ExaminationCard.dart';
import 'ExaminationController.dart';

class ExaminationPage extends StatefulWidget {
  ExaminationPage({super.key});

  @override
  _ExaminationPageState createState() => _ExaminationPageState();
}

class _ExaminationPageState extends State<ExaminationPage> {
  final ExaminationController controller = Get.put(ExaminationController());

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
                hintText: 'Muayene Adı',
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
            ),
            const SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () async {
                    final result = await Get.to(() => AddExaminationPage(), duration: Duration(milliseconds: 650));
                    if (result == true) {
                      controller.fetchExaminations();
                    }
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.white,
                  ),
                  child: Row(
                    children: [
                      Text('Muayene Ekle', style: TextStyle(color: Colors.black)),
                      Icon(Icons.add, color: Colors.black),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            Expanded(
              child: Obx(
                    () {
                  if (controller.isLoading.value) {
                    return Center(child: CircularProgressIndicator(color: Colors.black,));
                  } else if (controller.filteredExaminations.isEmpty) {
                    return Center(child: Text(
                      'Muayene bulunamadı',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                      textAlign: TextAlign.center,
                    ),);
                  } else {
                    return ListView.builder(
                      itemCount: controller.filteredExaminations.length,
                      itemBuilder: (context, index) {
                        final examination = controller.filteredExaminations[index];
                        return ExaminationCard(examination: examination);
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
