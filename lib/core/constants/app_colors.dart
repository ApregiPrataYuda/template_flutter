import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Brand
  static const Color primary = Color(0xFF4E8F2A);
  static const Color primarySoft = Color(0xFFEAF4E2); // indikator menu, ikon tile
  static const Color accent = Color(0xFFFDF291);      // kuning
  static const Color gradientTop = Color(0xFFDCEFCB); // atas latar gradasi
  // Status
  static const Color success = primary;
  static const Color warning = Color(0xFFF28C28);     // oranye, badge
  static const Color error = Color(0xFFE95F5F);

  // Netral
  static const Color background = Color(0xFFF2F6EE);
  static const Color surface = Colors.white;
  static const Color neutralLight = Color(0xFFF4F4F4);
  static const Color border = Color(0xFFDDE6D5);      // turunan dari palet, untuk garis tipis
  static const Color textPrimary = Color(0xFF1A2414);
  static const Color textSecondary = Color(0xFF97A392);


    // Status
  static const Color successDark = Color(0xFF3F7A20); // bg toast, kontras ±5.2:1
  static const Color errorDark = Color(0xFFC53030);   // bg toast, kontras ±5.5:1
  
}