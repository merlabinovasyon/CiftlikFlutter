import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../SecimSayfalari/SelectBirthTypePage.dart';
import '../SecimSayfalari/SelectTypePage.dart';



class ExpandingFab extends StatelessWidget {
  const ExpandingFab({super.key});

  @override
  Widget build(BuildContext context) {
    final isOpen = false.obs;
    final animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: Scaffold.of(context),
    );

    final fabAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: const Offset(0, 0),
    ).animate(animationController);

    return Obx(() => Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if (isOpen.value)
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
            child: Container(
              color: Colors.black.withOpacity(0.5),
            ),
          ),
        if (isOpen.value) ...[
          SlideTransition(
            position: fabAnimation,
            child: _buildFabWithText(
              text: 'Yeni Doğan Ekle',
              icon: Icons.add,
              onPressed: () {
                Get.to(() => const SelectBirthTypePage());
              },
              herotag: 'kuzu',
            ),
          ),
          const SizedBox(height: 10),
          SlideTransition(
            position: fabAnimation,
            child: _buildFabWithText(
              text: 'Hayvan Ekle',
              icon: Icons.add,
              onPressed: () {
                Get.to(() => const SelectTypePage());
              },
              herotag: 'genel',
            ),
          ),
          const SizedBox(height: 10),
        ],
        FloatingActionButton(
          onPressed: () {
            isOpen.value = !isOpen.value;
            if (isOpen.value) {
              animationController.forward();
            } else {
              animationController.reverse();
            }
          },
          backgroundColor: Colors.white,
          child: AnimatedBuilder(
            animation: animationController,
            builder: (context, child) {
              return Transform.rotate(
                angle: animationController.value * 3.14,
                child: Icon(
                  isOpen.value ? Icons.close : Icons.add,
                  color: Colors.black,
                ),
              );
            },
          ),
        ),
      ],
    ));
  }

  Widget _buildFabWithText({
    required String text,
    required IconData icon,
    required VoidCallback onPressed,
    required String herotag,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: onPressed,
          child: Container(
            width: 145,
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            decoration: BoxDecoration(
              color: Colors.cyan,
              borderRadius: BorderRadius.circular(8.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  blurRadius: 8.0,
                  offset: const Offset(2, 2),
                ),
              ],
            ),
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(width: 8.0),
        FloatingActionButton(
          mini: true,
          heroTag: herotag,
          onPressed: onPressed,
          backgroundColor: Colors.white,
          child: Icon(icon, color: Colors.black),
        ),
      ],
    );
  }
}
