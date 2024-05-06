import 'package:flutter/material.dart';
class DogCard extends StatelessWidget {
  final Function()? onTap;
  final String imageAsset;
  final String title;
  final String assetImagePath;
  final double genislik;
  final double yukseklik;

  const DogCard({
    required this.imageAsset,
    required this.title,
    required this.assetImagePath,
    required this.onTap,
    required this.genislik,
    required this.yukseklik,

  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: genislik*0.4,
        height: yukseklik*0.15,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          boxShadow: [BoxShadow(
            color: Colors.white.withOpacity(0.9),
            spreadRadius: 1,
            blurRadius: 2,
            offset: Offset(0,0),
          ),
          ],
        ),
        child: Card(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          color: Colors.white,
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      assetImagePath,
                      width: genislik*0.5,
                      height: yukseklik*0.06,

                    ),
                    SizedBox(height: yukseklik*0.01,),
                    Text(
                      title,
                      style: TextStyle(
                        fontFamily: 'Playfair Display',
                        fontSize: genislik*0.04,
                      ),
                    ),
                  ],
                ),
              ),
              Opacity(
                opacity: 0.25,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    imageAsset,
                    width: genislik*0.5,
                    height: yukseklik*0.2,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}