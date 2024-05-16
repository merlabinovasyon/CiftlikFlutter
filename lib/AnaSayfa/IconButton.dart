// lib/widgets/icon_button.dart
import 'package:flutter/material.dart';

Widget buildIconButton(BuildContext context, String assetPath, String label, Widget page) {
  return Padding(
    padding: const EdgeInsets.only(left: 8.0, right: 8),
    child: Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => page));
          },
          child: Image.asset(assetPath, width: 40.0, height: 40.0),
        ),
        SizedBox(height: 4.0),
        Text(label, textAlign: TextAlign.center),
      ],
    ),
  );
}
