import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'AddUserPage.dart';
import 'UserCard.dart';

class UsersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Get.back();
          },
        ),
        title: Center(
          child: Container(
            height: 40,
            width: 130,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('resimler/logo_v2.png'),
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.add, size: 30,),
            onPressed: () {
              Get.dialog(AddUserPage());
            },
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          UserCard(
            email: 'ardaaltun200298@gmail.com',
            name: 'Çiftlik Sahibi',
            phone: '+905555555555',
            status: 'Aktif',
          ),
        ],
      ),
    );
  }
}
