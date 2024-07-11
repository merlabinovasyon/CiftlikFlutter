import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BuildIconButton extends StatelessWidget {
  final String assetPath;
  final String label;
  final VoidCallback onTap; // onTap için parametre ekliyoruz

  const BuildIconButton({
    super.key,
    required this.assetPath,
    required this.label,
    required this.onTap, // onTap parametresini zorunlu hale getiriyoruz
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8),
      child: Column(
        children: [
          GestureDetector(
            onTap: onTap, // onTap'i burada kullanıyoruz
            child: Image.asset(assetPath, width: 40.0, height: 40.0),
          ),
          const SizedBox(height: 4.0),
          Text(label, textAlign: TextAlign.center),
        ],
      ),
    );
  }
}
