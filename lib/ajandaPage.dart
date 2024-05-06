import 'package:flutter/material.dart';

class ajandaPage extends StatelessWidget {
  const ajandaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 4,
        shadowColor: Colors.black38,
        title: Row(
          children: [
            SizedBox(width: 90,),
            Text("Ajanda"),
          ],
        ),
      ),
    );
  }
}
