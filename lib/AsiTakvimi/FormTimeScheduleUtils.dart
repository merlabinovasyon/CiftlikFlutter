import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../FormFields/FormButton.dart';

class FormTimeScheduleUtils {
  void showTimeSchedulePicker(BuildContext context, TextEditingController controller, Rx<DateTime?> selectedDateTime) {
    DateTime initialDateTime = selectedDateTime.value ?? DateTime.now();
    controller.text = DateFormat('d MMMM y HH:mm', 'tr_TR').format(initialDateTime);

    showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      builder: (BuildContext builder) {
        return SizedBox(
          height: MediaQuery.of(context).copyWith().size.height / 3.8,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Lütfen tarih ve saat seçiniz',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              Expanded(
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.dateAndTime,
                  use24hFormat: true,
                  initialDateTime: initialDateTime,
                  onDateTimeChanged: (DateTime newDateTime) {
                    selectedDateTime.value = newDateTime;
                    controller.text = DateFormat('d MMMM y HH:mm', 'tr_TR').format(newDateTime);
                  },
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: FormButton(
                  title: 'Tamam',
                  onPressed: () {
                    Get.back();
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
