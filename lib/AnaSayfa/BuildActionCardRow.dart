import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BuildActionCardRow extends StatelessWidget {
  final String title1;
  final IconData icon1;
  final VoidCallback onTap1;
  final String title2;
  final IconData icon2;
  final VoidCallback onTap2;

  const BuildActionCardRow({
    super.key,
    required this.title1,
    required this.icon1,
    required this.onTap1,
    required this.title2,
    required this.icon2,
    required this.onTap2,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
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
              leading: Icon(icon1),
              title: Text(
                title1,
                style: GoogleFonts.roboto(
                  textStyle: const TextStyle(color: Colors.cyan, fontWeight: FontWeight.bold),
                ),
              ),
              onTap: onTap1,
            ),
          ),
        ),
        const SizedBox(width: 8.0),
        Expanded(
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
              leading: Icon(icon2),
              title: Text(
                title2,
                style: GoogleFonts.roboto(
                  textStyle: const TextStyle(color: Colors.cyan, fontWeight: FontWeight.bold),
                ),
              ),
              onTap: onTap2,
            ),
          ),
        ),
      ],
    );
  }
}
