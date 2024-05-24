// lib/widgets/custom_button_card.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomButtonCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  CustomButtonCard({required this.icon, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        shadowColor: Colors.cyan,
        elevation: 4.0,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: ListTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          tileColor: Colors.white,
          leading: Icon(icon),
          title: Text(
            title,
            style: GoogleFonts.roboto(
              textStyle: TextStyle(color: Colors.cyan, fontWeight: FontWeight.bold),
            ),
          ),
          onTap: onTap,
        ),
      ),
    );
  }
}
