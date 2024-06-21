import 'package:flutter/material.dart';
import 'DiseaseController.dart';

class DiseaseCard extends StatefulWidget {
  final Disease disease;

  const DiseaseCard({Key? key, required this.disease}) : super(key: key);

  @override
  _DiseaseCardState createState() => _DiseaseCardState();
}

class _DiseaseCardState extends State<DiseaseCard> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 4.0,
      shadowColor: Colors.cyan,
      margin: const EdgeInsets.only(bottom: 10.0),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          onExpansionChanged: (bool expanding) => setState(() => isExpanded = expanding),
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(15.0),
            child: Image.asset(
              widget.disease.image,
              height: 50,
              width: 50,
              fit: BoxFit.cover,
            ),
          ),
          title: Text(widget.disease.diseaseName),
          tilePadding: const EdgeInsets.symmetric(horizontal: 16.0),
          childrenPadding: const EdgeInsets.all(8.0),
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: Image.asset(
                widget.disease.image,
                height: 100,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(widget.disease.diseaseDescription),
          ],
        ),
      ),
    );
  }
}
