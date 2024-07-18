import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';

class BleController extends GetxController {
  var scanResults = <ScanResult>[].obs;
  var isScanning = false.obs;
  var isBluetoothEnabled = false.obs;
  var isSwitchLocked = false.obs;
  var sayac = 0.obs;
  var deviceState = BluetoothConnectionState.disconnected.obs;
  var bluetoothServices = <BluetoothService>[].obs;
  var notifyDatas = <String, List<int>>{}.obs;
  late StreamSubscription<BluetoothAdapterState> subscription;
  late StreamSubscription<BluetoothConnectionState> _stateListener;

  @override
  void onInit() {
    super.onInit();
    checkBluetoothSupportAndListenState();
  }

  Future<bool> connect(BluetoothDevice device) async {
    try {
      await device.connect(autoConnect: false).timeout(const Duration(minutes: 1));
      await device.requestMtu(260);
      discoverServices(device);
      stopScan();
      return true;
    } catch (e) {
      return false;
    }
  }

  void discoverServices(BluetoothDevice device) async {
    bluetoothServices.value = await device.discoverServices();
  }

  void startScan() {
    scanResults.clear();
    isScanning.value = true;
    FlutterBluePlus.startScan(timeout: Duration(seconds: 60));
    FlutterBluePlus.scanResults.listen((results) {
      scanResults.assignAll(results);
      sayac.value = scanResults.where((result) => result.device.platformName != null && result.device.platformName.isNotEmpty).length;
    }).onDone(() {
      isScanning.value = false;
    });
  }

  void disconnect(BluetoothDevice device) {
    try {
      device.disconnect();
    } catch (e) {
      print('Disconnect error: $e');
    }
  }

  void stopScan() {
    isScanning.value = false;
    FlutterBluePlus.stopScan();
    scanResults.clear();
    sayac.value = 0;
  }

  void checkBluetoothSupportAndListenState() async {
    if (await FlutterBluePlus.isSupported == false) {
      print("Bluetooth not supported by this device");
      return;
    }

    FlutterBluePlus.adapterState.listen((state) {
      isBluetoothEnabled.value = state == BluetoothAdapterState.on;
      if (state == BluetoothAdapterState.off) {
        Get.snackbar(
          'Bluetooth Kapalı',
          'Bluetooth açmak ister misiniz?',
          mainButton: TextButton(
            onPressed: () async {
              await FlutterBluePlus.turnOn();
            },
            child: Text('Aç'),
          ),
        );
      }
    });
  }
}