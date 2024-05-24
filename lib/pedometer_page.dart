// lib/pages/pedometer_page.dart
import 'package:flutter/material.dart';

class PedometerPage extends StatelessWidget {
  const PedometerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pedometre'),
      ),
      body: const Center(
        child: Text('Pedometre Sayfası'),
      ),
    );
  }
}
