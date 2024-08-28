import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'FeedConsumptionController.dart';
import '../FormFields/FormButton.dart';

class FeedConsumptionPage extends StatelessWidget {
  final int feedId; // feedId parametresi eklendi

  FeedConsumptionPage({required this.feedId});

  final FeedConsumptionController controller = Get.put(FeedConsumptionController());
  final _formKey = GlobalKey<FormState>();
  final _quantityController = TextEditingController();
  final _totalCostController = TextEditingController();
  final _notesController = TextEditingController();
  final _dateController = TextEditingController();
  final FocusNode searchFocusNodeAmount = FocusNode();
  final FocusNode searchFocusNodeTotal = FocusNode();
  final FocusNode searchFocusNodeNotes = FocusNode();
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
                focusNode: searchFocusNodeAmount,
                controller: _quantityController,
                cursorColor: Colors.black54,
                decoration: InputDecoration(
                  labelText: 'Miktar (kg) *',
                  labelStyle: TextStyle(color: Colors.black),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(color: Colors.black),
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
                onTapOutside: (event) {
                  searchFocusNodeAmount.unfocus(); // Dışarı tıklanırsa klavyeyi kapat ve imleci gizle
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                focusNode: searchFocusNodeTotal,
                controller: _totalCostController,
                cursorColor: Colors.black54,
                decoration: InputDecoration(
                  labelText: 'Toplam Bedel*',
                  labelStyle: TextStyle(color: Colors.black),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(color: Colors.black),
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
                onTapOutside: (event) {
                  searchFocusNodeTotal.unfocus(); // Dışarı tıklanırsa klavyeyi kapat ve imleci gizle
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                focusNode: searchFocusNodeNotes,
                controller: _notesController,
                cursorColor: Colors.black54,
                decoration: InputDecoration(
                  labelText: 'Notlar',
                  labelStyle: TextStyle(color: Colors.black),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
                onChanged: (value) => controller.notes.value = value,
                onTapOutside: (event) {
                  searchFocusNodeNotes.unfocus(); // Dışarı tıklanırsa klavyeyi kapat ve imleci gizle
                },
              ),
              SizedBox(height: 16),
              Obx(() => InkWell(
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                    locale: const Locale('tr', 'TR'),
                    builder: (context, child) {
                      return Theme(
                        data: ThemeData.dark().copyWith(
                          colorScheme: ColorScheme.dark(
                            primary: Colors.cyan.withOpacity(0.5),
                            onPrimary: Colors.white,
                            surface: Colors.black,
                            onSurface: Colors.white,
                          ),
                          dialogBackgroundColor: Colors.blueGrey[800],
                        ),
                        child: child!,
                      );
                    },
                  );
                  if (pickedDate != null) {
                    controller.date.value = DateFormat('d MMMM y', 'tr').format(pickedDate);
                  }
                },
                child: IgnorePointer(
                  child: TextFormField(
                    controller: TextEditingController(text: controller.date.value),
                    decoration: InputDecoration(
                      labelText: 'Tarih*',
                      labelStyle: TextStyle(color: Colors.black),
                      suffixIcon: Icon(Icons.calendar_today),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide(color: Colors.black),
                      ),
                    ),
                  ),
                ),
              )),
              SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0, right: 8, left: 8),
                child: FormButton(
                  title: 'Kaydet',
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      controller.addFeedConsumption(feedId); // feedId eklenerek tüketim kaydediliyor
                      Future.delayed(const Duration(milliseconds: 600), () {
                        Get.back();
                        Get.snackbar('Başarılı', 'Yem Tüketimi Kaydedildi');
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
