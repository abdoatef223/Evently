import 'package:flutter/material.dart';

class ImageTabView extends StatelessWidget {
  final String imagePath;
  const ImageTabView({super.key,required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image.asset(imagePath,fit: BoxFit.fill,));
  }
}