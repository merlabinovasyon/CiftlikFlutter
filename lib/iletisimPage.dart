import 'package:flutter/material.dart';

class iletisimPage extends StatelessWidget {
  const iletisimPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        elevation: 4,
        shadowColor: Colors.black38,
        title: Row(
          children: [
            SizedBox(width: 90,),
            Text("Bize Ulaşın"),
          ],
        ),
      ),
    );
  }
}
