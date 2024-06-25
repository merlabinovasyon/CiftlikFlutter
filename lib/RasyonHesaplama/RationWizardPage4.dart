import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'RationWizardController.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class RationWizardPage4 extends StatelessWidget {
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
                    currentStep: 4,
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
                  icon: Icon(Icons.check),
                  onPressed: () {
                    // İleri gitme işlemi
                    // Bir sonraki sayfaya gitmek için yazılması gereken kod
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text('Miktar', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Expanded(
              child: Obx(() {
                var selectedSolution = controller.selectedSolution;
                if (selectedSolution.isEmpty) {
                  return Center(child: Text('Hiçbir çözüm seçilmedi.'));
                } else {
                  return ListView(
                    children: selectedSolution.entries.map((entry) {
                      return Card(
                        color: Colors.white,
                        shadowColor: Colors.cyan,
                        elevation: 2,
                        child: ListTile(
                          title: Text(entry.key),
                          trailing: Text(entry.value.toString()),
                        ),
                      );
                    }).toList(),
                  );
                }
              }),
            ),
          ],
        ),
      ),
    );
  }
}
