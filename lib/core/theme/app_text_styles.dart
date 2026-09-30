import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/app_colors.dart';
import '../constants/app_sizes.dart';

class AppTextStyles {
  AppTextStyles._();

  static TextStyle _inter(double size, FontWeight weight, Color color) {
    return GoogleFonts.inter(fontSize: size, fontWeight: weight, color: color);
  }

  // Judul
  static TextStyle get h1 =>
      _inter(AppSizes.font32, FontWeight.w600, AppColors.textPrimary);
  static TextStyle get h2 =>
      _inter(AppSizes.font24, FontWeight.w600, AppColors.textPrimary);
  static TextStyle get h3 =>
      _inter(AppSizes.font20, FontWeight.w600, AppColors.textPrimary);

  // Isi
  static TextStyle get bodyLarge =>
      _inter(AppSizes.font16, FontWeight.w400, AppColors.textPrimary);
  static TextStyle get body =>
      _inter(AppSizes.font14, FontWeight.w400, AppColors.textPrimary);
  static TextStyle get bodyMedium =>
      _inter(AppSizes.font14, FontWeight.w500, AppColors.textPrimary);
  static TextStyle get bodySemiBold =>
      _inter(AppSizes.font14, FontWeight.w600, AppColors.textPrimary);

  // Pendukung
  static TextStyle get caption =>
      _inter(AppSizes.font12, FontWeight.w400, AppColors.textSecondary);
  static TextStyle get small =>
      _inter(AppSizes.font10, FontWeight.w400, AppColors.textSecondary);
}