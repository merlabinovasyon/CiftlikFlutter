import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BuildActionCardRow extends StatelessWidget {
  const BuildActionCardRow({super.key});

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
              leading: Icon(Icons.account_balance),
              title: Text(
                'Gelir/Gider',
                style: GoogleFonts.roboto(
                  textStyle: TextStyle(color: Colors.cyan, fontWeight: FontWeight.bold),
                ),
              ),
              onTap: () {},
            ),
          ),
        ),
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
              leading: Icon(Icons.sync),
              title: Text(
                'Sync.',
                style: GoogleFonts.roboto(
                  textStyle: TextStyle(color: Colors.cyan, fontWeight: FontWeight.bold),
                ),
              ),
              onTap: () {},
            ),
          ),
        ),
      ],
    );  }
}
