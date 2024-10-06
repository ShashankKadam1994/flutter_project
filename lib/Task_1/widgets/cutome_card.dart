import 'package:flutter/material.dart';

class CutomeCard extends StatelessWidget {
  final String imagePath;
  final String text;

  const CutomeCard({
    Key? key,
    required this.imagePath,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            imagePath,
            height: 150,
            width: 150,
          ),
          SizedBox(height: 8),
          Text(text),
        ],
      ),
    );
  }
}
