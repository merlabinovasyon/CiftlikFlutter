import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BuildIconButton extends StatelessWidget {
  final String assetPath;
  final Widget page;
  final String label;
  const BuildIconButton({super.key,required this.assetPath,required this.page,required this.label});


  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              Get.to(page);
            },
            child: Image.asset(assetPath, width: 40.0, height: 40.0),
          ),
          SizedBox(height: 4.0),
          Text(label, textAlign: TextAlign.center),
        ],
      ),
    );
  }
}
