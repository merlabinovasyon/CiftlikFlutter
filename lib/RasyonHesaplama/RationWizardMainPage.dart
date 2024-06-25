import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'RationWizardPage1.dart';
import 'RationWizardPage2.dart';
import 'RationWizardPage3.dart';
import 'RationWizardPage4.dart';

class RationWizardMainPage extends StatefulWidget {
  @override
  _RationWizardMainPageState createState() => _RationWizardMainPageState();
}

class _RationWizardMainPageState extends State<RationWizardMainPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  void _onPageChanged(int page) {
    setState(() {
      _currentPage = page;
    });
  }

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
            icon: Icon(Icons.help_outline, size: 30,),
            onPressed: () {
            },
          ),
        ],
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        children: [
          RationWizardPage1(),
          RationWizardPage2(),
          RationWizardPage3(),
          RationWizardPage4(),
        ],
      ),
    );
  }
}
