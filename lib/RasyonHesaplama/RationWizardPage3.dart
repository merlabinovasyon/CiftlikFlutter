import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'RationWizardController.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class RationWizardPage3 extends StatelessWidget {
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
                    currentStep: 3,
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
            Text('Çözümler', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            // Başlık satırı
            Container(
              color: Colors.grey.shade200,
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Expanded(child: Text('HP (g)', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold))),
                  Expanded(child: Text('MF (kcal)', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold))),
                  Expanded(child: Text('KM (kg)', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold))),
                  Expanded(child: Text('Fiyat', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold))),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: Obx(() => ListView.builder(
                itemCount: controller.solutions.length,
                itemBuilder: (context, index) {
                  var solution = controller.solutions[index];
                  return Card(
                    color: Colors.white,
                    shadowColor: Colors.cyan,
                    elevation: 2,
                    child: ListTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              solution['HP (g)'].toString(),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              solution['MF (kcal)'].toString(),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              solution['KM (kg)'].toString(),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              solution['Fiyat'].toString(),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                      onTap: () {
                        controller.selectSolution(index);
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
