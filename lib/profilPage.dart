import 'package:flutter/material.dart';


class profilPage extends StatelessWidget {
  const profilPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        elevation: 4,
        shadowColor: Colors.black38,
        title: Row(
          children: [
            SizedBox(width: 90,),
            Text("Profil"),
          ],
        ),
      ),
    );
  }
}
