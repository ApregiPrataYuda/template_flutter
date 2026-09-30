import 'package:flutter/material.dart';
import '../../core/theme/app_text_styles.dart';

class PlaceholderScreen extends StatelessWidget {
  final String title;

  const PlaceholderScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(title, style: AppTextStyles.h2));
  }
}