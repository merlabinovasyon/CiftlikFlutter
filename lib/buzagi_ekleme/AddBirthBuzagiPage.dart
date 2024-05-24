import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:merlabciftlikyonetim/FormFields/BuildSelectionField.dart';
import 'package:merlabciftlikyonetim/FormFields/BuildTextField.dart';
import 'package:merlabciftlikyonetim/FormFields/BuildTimeField.dart';
import '../EklemeSayfaları/AddBirthKuzuPage.dart';
import '../FormFields/BuildCounterField.dart';
import '../FormFields/BuildDateField.dart';
import 'AddBirthBuzagiController.dart';

class AddBirthBuzagiPage extends StatelessWidget {
  final AddBirthBuzagiController controller = Get.put(AddBirthBuzagiController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.pop(context);
              },
            );
          },
        ),
        title: Center(
          child: Container(
            height: 40,
            width: 130,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('resimler/logo_v2.png'),
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
        actions: [
          Stack(
            alignment: Alignment.topRight,
            children: [
              IconButton(
                icon: Icon(Icons.notifications, size: 35),
                onPressed: () {},
              ),
              Positioned(
                right: 11,
                top: 11,
                child: Container(
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  constraints: BoxConstraints(
                    minWidth: 18,
                    minHeight: 18,
                  ),
                  child: Text(
                    '20',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: controller.formKey,
          child: ListView(
            children: [
              SizedBox(height: 10),
              Text(
                'Yeni doğan buzağı/buzağılarınızın bilgilerini giriniz.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Card(
                shadowColor: Colors.cyan,
                elevation: 4.0,
                color: Colors.white,
                margin: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Buzağı ağırlık:  kg',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
              SizedBox(height: 16),
              BuildSelectionField(label: 'Doğuran Hayvan *',value:controller.selectedAnimal,options:controller.animals,onSelected:(value) {
                controller.selectedAnimal.value = value;
              }),
              SizedBox(height: 16),
              BuildSelectionField(label: 'Boğanız *', value:controller.selectedKoc,options:controller.boga, onSelected:(value) {
                controller.selectedKoc.value = value;
              }),
              SizedBox(height: 16),
              BuildDateField(label: 'Doğum Yaptığı Tarih *', controller: controller.dobController),
              SizedBox(height: 16),
              BuildTimeField(label: 'Doğum Zamanı',controller: controller.timeController,controller1:controller),
              SizedBox(height: 24),
              Text('1. Buzağı', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 16),
              BuildTextField(label: 'Küpe No *', hint:'GEÇİCİ_NO_16032'),
              SizedBox(height: 16),
              BuildTextField(label: 'Devlet Küpe No *', hint:'GEÇİCİ_NO_16032'),
              SizedBox(height: 16),
              BuildSelectionField(label: 'Irk *', value:controller.selectedBuzagi,options:controller.buzagi, onSelected:(value) {
                controller.selectedBuzagi.value = value;
              }),
              SizedBox(height: 16),
              BuildTextField(label: 'Hayvan Adı',hint: ''),
              SizedBox(height: 16),
              BuildSelectionField(label: 'Cinsiyet *', value:controller.selectedGender1, options:controller.genders, onSelected: (value) {
                controller.selectedGender1.value = value;
              }),
              SizedBox(height: 16),
              BuildCounterField(label: 'Buzağı Tipi', controller:controller.countController,title: "buzağı",),
              SizedBox(height: 24),
              Obx(() => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('İkiz', style: TextStyle(fontSize: 18)),
                  Transform.scale(
                    scale: 0.9,
                    child: CustomSwitch(
                      value: controller.isTwin.value,
                      onChanged: (value) {
                        controller.isTwin.value = value;
                        if (!value) {
                          controller.isTriplet.value = false;
                          controller.resetTwinValues();
                        }
                      },
                    ),
                  ),
                ],
              )),
              Obx(() => controller.isTwin.value ? Column(
                children: [
                  SizedBox(height: 24),
                  Text('2. Buzağı', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(height: 16),
                  BuildTextField(label: 'Küpe No *',hint: ''),
                  SizedBox(height: 16),
                  BuildTextField(label: 'Devlet Küpe No *', hint:'GEÇİCİ_NO_16032'),
                  SizedBox(height: 16),
                  BuildSelectionField(label: 'Irk *', value:controller.selected1Buzagi, options:controller.buzagi1,onSelected:(value) {
                    controller.selected1Buzagi.value = value;
                  }),
                  SizedBox(height: 16),
                  BuildTextField(label: 'Hayvan Adı',hint: ''),
                  SizedBox(height: 16),
                  BuildSelectionField(label:'Cinsiyet *', value:controller.selectedGender2, options:controller.genders, onSelected:(value) {
                    controller.selectedGender2.value = value;
                  }),
                  SizedBox(height: 16),
                  BuildCounterField(label: 'Buzağı Tipi',controller: controller.count1Controller, title: 'buzağı',),
                  SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Üçüz', style: TextStyle(fontSize: 18)),
                      Transform.scale(
                        scale: 0.9,
                        child: CustomSwitch(
                          value: controller.isTriplet.value,
                          onChanged: (value) {
                            controller.isTriplet.value = value;
                            if (!value) {
                              controller.resetTripletValues();
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ) : Container()),
              Obx(() => controller.isTriplet.value ? Column(
                children: [
                  SizedBox(height: 24),
                  Text('3. Buzağı', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(height: 16),
                  BuildTextField(label: 'Küpe No *',hint:  ''),
                  SizedBox(height: 16),
                  BuildTextField(label: 'Devlet Küpe No *',hint: 'GEÇİCİ_NO_16032'),
                  SizedBox(height: 16),
                  BuildSelectionField(label:'Irk *', value: controller.selected2Buzagi,options: controller.buzagi1, onSelected: (value) {
                    controller.selected2Buzagi.value = value;
                  }),
                  SizedBox(height: 16),
                  BuildTextField(label: 'Hayvan Adı',hint: ''),
                  SizedBox(height: 16),
                  BuildSelectionField(label:'Cinsiyet *', value:controller.selectedGender3, options:controller.genders,onSelected:(value) {
                    controller.selectedGender3.value = value;
                  }),
                  SizedBox(height: 16),
                  BuildCounterField(label: 'Buzağı Tipi', controller:controller.count2Controller, title: 'buzağı',),
                ],
              ) : Container()),
            ],
          ),
        ),
      ),
    );
  }



}
