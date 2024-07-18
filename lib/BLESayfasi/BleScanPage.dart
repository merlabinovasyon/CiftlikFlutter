import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../EklemeSayfalari/OlcumEkleme/OlcumPage.dart';
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 30),
              child: Obx(() => Container(
                width: 200,
                child: RichText(
                  text: TextSpan(
                    text: 'Bağlantı: ',
                    style: TextStyle(
                        fontSize: 20,
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
                          fontSize: 20,
                          color: bleController.isScanning.value && bleController.isBluetoothEnabled.value
                              ? const Color(0xFF12E200)
                              : const Color(0xFFFF8F9F),
                        ),
                      ),
                    ],
                  ),
                ),
              )),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Obx(() {
                if (bleController.isScanning.value) {
                  return SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return SizedBox.shrink(); // Boş alan
                }
              }),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20, top: 20), // Sağ padding ayarlandı
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
        Center(
          child: Icon(
            Icons.bluetooth,
            size: 100,
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
        Expanded(
          child: Obx(() => ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: bleController.scanResults.length,
            itemBuilder: (BuildContext context, int index) {
              var result = bleController.scanResults[index];
              return ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
                leading: Icon(
                  Icons.circle_outlined,
                  color: const Color(0xFFADB8C9),
                  size: 30,
                ),
                title: Text(
                  result.device.platformName?.isEmpty ?? true ? 'Unknown' : result.device.platformName!,
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.black,
                  ),
                ),
                onTap: () async {
                  Get.snackbar('Bağlanıyor', 'Cihaza bağlanılıyor, lütfen bekleyin...');
                  bool connected = await bleController.connect(result.device);
                  if (connected) {
                    Get.to(() => OlcumPage());
                  }
                },
              );
            },
          )),
        ),
      ],
    );
  }
}