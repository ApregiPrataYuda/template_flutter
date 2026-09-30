import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

/// Latar gradasi hijau muda ke putih, sesuai mockup.
class AppBackground extends StatelessWidget {
  final Widget child;

  const AppBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [AppColors.gradientTop, AppColors.surface],
          stops: [0.0, 0.55],
        ),
      ),
      child: child,
    );
  }
}