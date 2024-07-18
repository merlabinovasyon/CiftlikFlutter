import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../EklemeSayfalari/BuzagiEkleme/AddBirthBuzagiPage.dart';
import 'BleController.dart';

class BleScanPage extends StatelessWidget {
  final BleController bleController = Get.put(BleController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      backgroundColor: Colors.white,
      body: OrientationBuilder(
        builder: (context, orientation) {
          return dikey(context);
        },
      ),
    );
  }

  Widget dikey(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 30),
              child: Obx(() => RichText(
                text: TextSpan(
                  text: 'Bağlantı: ',
                  style: TextStyle(
                      fontSize: 24,
                      fontFamily: 'Roboto Regular',
                      color: Colors.black,
                      fontWeight: FontWeight.w700),
                  children: <TextSpan>[
                    TextSpan(
                      text: bleController.isScanning.value && bleController.isBluetoothEnabled.value
                          ? 'Aranıyor...'
                          : 'Kapalı',
                      style: TextStyle(
                        fontFamily: 'Roboto Regular',
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: bleController.isScanning.value && bleController.isBluetoothEnabled.value
                            ? const Color(0xFF12E200)
                            : const Color(0xFFFF8F9F),
                      ),
                    ),
                  ],
                ),
              )),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 50, top: 20),
              child: Obx(() => Switch(
                inactiveThumbColor: Colors.black,
                inactiveTrackColor: Colors.grey,
                activeTrackColor: const Color(0xFF12E200),
                value: bleController.isBluetoothEnabled.value && bleController.isScanning.value,
                onChanged: (bool value) async {
                  if (bleController.isSwitchLocked.value) {
                    return;
                  }
                  bleController.isSwitchLocked.value = true;

                  if (!bleController.isBluetoothEnabled.value) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Bluetooth Kapalı. Cihaz taraması yapmak için Açınız.'),
                      ),
                    );
                    bleController.isSwitchLocked.value = false;
                    return;
                  }

                  if (value && bleController.isBluetoothEnabled.value) {
                    bleController.startScan();
                  } else {
                    bleController.stopScan();
                  }

                  bleController.isScanning.value = value;
                  bleController.isSwitchLocked.value = false;
                },
              )),
            ),
          ],
        ),
        const SizedBox(height: 30),
        Padding(
          padding: const EdgeInsets.only(left: 50),
          child: Icon(
            Icons.bluetooth,
            size: 50,
            color: Colors.blueAccent,
          ),
        ),
        const SizedBox(height: 30),


        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Text(
            'Bulunan cihazlar',
            style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: 24,
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Obx(() => SizedBox(
            height: bleController.isBluetoothEnabled.value ? 0 : 60,
            width: bleController.isBluetoothEnabled.value ? 0 : 300,
            child: Visibility(
              visible: !bleController.isBluetoothEnabled.value,
              child: Text(
                'Bluetooth kapalı.\nMobil aygıtınızda Bluetooth’u açın.',
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  color: Colors.blueAccent,
                  fontSize: 24,
                ),
              ),
            ),
          )),
        ),
        Expanded(
          child: Obx(() => ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            children: [
              SizedBox(
                height: bleController.sayac.value > 5 ? 300 : (bleController.sayac.value * 60),
                child: ListView.builder(
                  itemExtent: 60.0,
                  itemCount: bleController.sayac.value,
                  itemBuilder: (BuildContext context, int index) {
                    var filteredList = bleController.scanResults.where((result) =>
                    result.device.platformName != null && result.device.platformName.isNotEmpty).toList();
                    var result = filteredList[index];
                    return ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
                      leading: Icon(
                        Icons.circle_outlined,
                        color: const Color(0xFFADB8C9),
                        size: 30,
                      ),
                      title: Text(
                        result.device.platformName!,
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.black,
                        ),
                      ),
                      onTap: () {
                        bleController.connect(result.device);
                        // Get.to(() => AddBirthBuzagiPage());
                      },
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, bottom: 60, top: 10),
                child: Obx(() => Visibility(
                  visible: bleController.isScanning.value,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 30,
                        height: 30,
                        child: const CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF4AC8FF)),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Text(
                        'Bluetooth cihazlar aranıyor...',
                        style: TextStyle(
                          fontSize: 24,
                          color: const Color(0xFF4AC8FF),
                        ),
                      ),
                    ],
                  ),
                )),
              ),
            ],
          )),
        ),
      ],
    );
  }
}