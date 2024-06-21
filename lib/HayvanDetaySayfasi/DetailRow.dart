import 'package:flutter/material.dart';

class DetailRow extends StatelessWidget {
  final String label1;
  final String value1;
  final String label2;
  final String value2;

  DetailRow({
    required this.label1,
    required this.value1,
    required this.label2,
    required this.value2,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label1,
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
              ),
              const SizedBox(height: 4.0),
              Text(value1),
            ],
          ),
        ),
        if (label2.isNotEmpty)
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label2,
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
                ),
                const SizedBox(height: 4.0),
                Text(value2),
              ],
            ),
          ),
      ],
    );
  }
}
