import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddFeedController extends GetxController {
  final formKey = GlobalKey<FormState>();

  final TextEditingController yemAdiController = TextEditingController();
  final TextEditingController kuruMaddeController = TextEditingController();
  final TextEditingController uflController = TextEditingController();
  final TextEditingController meController = TextEditingController();
  final TextEditingController pdiController = TextEditingController();
  final TextEditingController hamProteinController = TextEditingController();
  final TextEditingController lizinController = TextEditingController();
  final TextEditingController metioninController = TextEditingController();
  final TextEditingController kalsiyumController = TextEditingController();
  final TextEditingController fosforController = TextEditingController();
  final TextEditingController altLimitController = TextEditingController();
  final TextEditingController ustLimitController = TextEditingController();
  final TextEditingController fiyatController = TextEditingController();
  final TextEditingController notlarController = TextEditingController();

  final Rxn<String> selectedTur = Rxn<String>();

  @override
  void onClose() {
    yemAdiController.dispose();
    kuruMaddeController.dispose();
    uflController.dispose();
    meController.dispose();
    pdiController.dispose();
    hamProteinController.dispose();
    lizinController.dispose();
    metioninController.dispose();
    kalsiyumController.dispose();
    fosforController.dispose();
    altLimitController.dispose();
    ustLimitController.dispose();
    fiyatController.dispose();
    notlarController.dispose();
    super.onClose();
  }
}
