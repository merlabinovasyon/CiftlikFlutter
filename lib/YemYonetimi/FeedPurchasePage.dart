import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:merlabciftlikyonetim/FormFields/FormButton.dart';
import 'FeedPurchaseController.dart';

class FeedPurchasePage extends StatelessWidget {
  final FeedPurchaseController controller = Get.put(FeedPurchaseController());
  final _formKey = GlobalKey<FormState>();
  final _quantityController = TextEditingController();
  final _totalCostController = TextEditingController();
  final _notesController = TextEditingController();
  final _dateController = TextEditingController();

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
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              SizedBox(height: 10),
              TextFormField(
                controller: _quantityController,
                cursorColor: Colors.black54,
                decoration: InputDecoration(
                  labelText: 'Miktar (kg) *',
                  labelStyle: TextStyle(color: Colors.black), // Label rengi
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(color: Colors.black), // Odaklanıldığında border rengi
                  ),
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) => controller.quantity.value = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Lütfen miktar giriniz';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _totalCostController,
                cursorColor: Colors.black54,
                decoration: InputDecoration(
                  labelText: 'Toplam Bedel*',
                  labelStyle: TextStyle(color: Colors.black), // Label rengi
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(color: Colors.black), // Odaklanıldığında border rengi
                  ),
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) => controller.totalCost.value = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Lütfen toplam bedel giriniz';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _notesController,
                cursorColor: Colors.black54,
                decoration: InputDecoration(
                  labelText: 'Notlar',
                  labelStyle: TextStyle(color: Colors.black), // Label rengi
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(color: Colors.black), // Odaklanıldığında border rengi
                  ),
                ),
                onChanged: (value) => controller.notes.value = value,
              ),
              SizedBox(height: 16),
              Obx(
                    () => TextFormField(
                  controller: TextEditingController(text: controller.date.value),
                  decoration: InputDecoration(
                    labelText: 'Tarih*',
                    labelStyle: TextStyle(color: Colors.black), // Label rengi
                    suffixIcon: Icon(Icons.calendar_today),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide(color: Colors.black), // Odaklanıldığında border rengi
                    ),
                  ),
                  readOnly: true,
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    );
                    if (pickedDate != null) {
                      controller.date.value = pickedDate.toLocal().toString().split(' ')[0];
                    }
                  },
                ),
              ),
              SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0, right: 8, left: 8),
                child: FormButton(
                  title: 'Kaydet',
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      controller.addFeedPurchase();
                      Future.delayed(const Duration(milliseconds: 600), () {
                        Get.back();
                        Get.snackbar('Başarılı', 'Yem Alışı Kaydedildi');
                      });
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
