import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../FormFields/FormButton.dart';
import 'FinanceController.dart';
import 'TransactionTypeSelectionField.dart'; // Import the new TransactionTypeSelectionField

class AddTransactionPage extends StatelessWidget {
  final FinanceController controller = Get.find();
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _amountController = TextEditingController();
  final _noteController = TextEditingController();
  final _dateController = TextEditingController(text: '11/06/2024');
  final _transactionType = Rxn<TransactionType>();

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
                cursorColor: Colors.black54,
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Ad*',
                  labelStyle: TextStyle(color: Colors.black), // Label rengi
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(color: Colors.black), // Odaklanıldığında border rengi
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Lütfen ad giriniz';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                cursorColor: Colors.black54,
                controller: _amountController,
                decoration: InputDecoration(
                  labelText: 'Toplam Tutar*',
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
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Lütfen toplam tutar giriniz';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                cursorColor: Colors.black54,
                controller: _noteController,
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
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _dateController,
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
                    _dateController.text = pickedDate.toLocal().toString().split(' ')[0];
                  }
                },
              ),
              SizedBox(height: 16),
              TransactionTypeSelectionField(
                label: 'Seçiniz',
                value: _transactionType,
                options: TransactionType.values.toList(),
                onSelected: (value) {
                  _transactionType.value = value;
                },
              ),
              SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0,right: 8,left: 8),
                child: FormButton(
                  title: 'Kaydet',
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final transaction = Transaction(
                        date: _dateController.text,
                        name: _nameController.text,
                        note: _noteController.text,
                        amount: double.parse(_amountController.text) *
                            (_transactionType.value == TransactionType.Gelir ? 1 : -1),
                        type: _transactionType.value!,
                      );
                      controller.addTransaction(transaction);
                      Future.delayed(const Duration(milliseconds: 600), () {
                        Get.back();
                        Get.snackbar('Başarılı', 'İşlem Kaydedildi');
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
