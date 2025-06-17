import 'package:flutter/material.dart';

class RecommendedItemModel {
  final String imagePath;
  final String title;
  final VoidCallback onTap;

  const RecommendedItemModel(
      {required this.imagePath, required this.title, required this.onTap});
}
