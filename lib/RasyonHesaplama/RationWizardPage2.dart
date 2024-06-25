import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'RationWizardController.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class RationWizardPage2 extends StatelessWidget {
  final RationWizardController controller = Get.find<RationWizardController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                  iconSize: 22,
                  icon: Icon(Icons.arrow_circle_left_outlined),
                  onPressed: () {
                    // Geri gitme işlemi
                    // Bir önceki sayfaya gitmek için yazılması gereken kod
                  },
                ),
                SizedBox(width: 5,),
                Container(
                  height: 18,  // Daha yüksek yaparak dikey hizalamayı iyileştirin
                  child: VerticalDivider(
                    color: Colors.grey,
                    thickness: 2,  // Kalınlığı artırarak daha belirgin yapın
                  ),
                ),
                Expanded(
                  child: StepProgressIndicator(
                    totalSteps: 4,
                    currentStep: 2,
                    selectedColor: Colors.cyan.shade600,
                    unselectedColor: Colors.grey,
                  ),
                ),
                Container(
                  height: 18,  // Daha yüksek yaparak dikey hizalamayı iyileştirin
                  child: VerticalDivider(
                    color: Colors.grey,
                    thickness: 2,  // Kalınlığı artırarak daha belirgin yapın
                  ),
                ),
                SizedBox(width: 5,),
                IconButton(
                  iconSize: 22,
                  icon: Icon(Icons.arrow_circle_right_outlined),
                  onPressed: () {
                    // İleri gitme işlemi
                    // Bir sonraki sayfaya gitmek için yazılması gereken kod
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text('Yemler', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            TextField(
              cursorColor: Colors.black54,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: 'Yem Adı',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(color: Colors.black), // Odaklanıldığında border rengi
                ),
              ),
              onChanged: (value) {
                // Arama işlevi burada olacak
              },
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Obx(() => ListView.builder(
                itemCount: controller.feeds.length,
                itemBuilder: (context, index) {
                  var feed = controller.feeds[index];
                  return Card(
                    color: Colors.white,
                    shadowColor: Colors.cyan,
                    elevation: 2,
                    child: CheckboxListTile(
                      activeColor: Colors.cyan.shade600,
                      title: Text(feed['Ad'] as String),
                      subtitle: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Alt Limit: ${feed['Alt Limit (kg)']} kg'),
                          Text('Üst Limit: ${feed['Üst Limit (kg)']} kg'),
                        ],
                      ),
                      value: feed['selected'] as bool,
                      onChanged: (value) {
                        controller.selectFeed(index, value);
                      },
                    ),
                  );
                },
              )),
            ),
          ],
        ),
      ),
    );
  }
}
