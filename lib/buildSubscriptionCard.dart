// lib/widgets/subscription_card.dart
import 'package:flutter/material.dart';

Widget buildSubscriptionCard(String title, String price, int color) {
  return Container(
    width: 200,
    child: Padding(
      padding: const EdgeInsets.only(right: 4.0, left: 4, top: 8),
      child: Card(
        color: Colors.transparent,
        elevation: 0,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Color(color).withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 8.0),
                Text(price, style: TextStyle(color: Colors.blue)),
                SizedBox(height: 8.0),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Color(color)),
                  onPressed: () {},
                  child: Text('Abone Ol', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}