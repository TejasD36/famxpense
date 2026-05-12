import 'package:flutter/material.dart';

class AppColor {
  static const Color primary = Color(0xFF2563EB);
  static const Color primaryDark = Color(0xFF1D4ED8);
  static const Color primaryLight = Color(0xFF60A5FA);
  static const Color highLight = Color(0xFF93C5FD);

  static const Color gradientStart = Color(0xFF2563EB);
  static const Color gradientEnd = Color(0xFF60A5FA);

  static const Color black = Color(0xFF000000);
  static const Color white = Color(0xFFFFFFFF);

  static const Color lightSurface = Color(0xFFF5F7FA);
  static const Color darkSurface = Color(0xFF111827);

  static const Color lightCard = Color(0xFFFFFFFF);
  static const Color darkCard = Color(0xFF1F2937);

  static const Color darkSecondarySurface = Color(0xFF374151);

  static const Color darkText = Color(0xFF1F2937);
  static const Color lightText = Color(0xFFF9FAFB);

  static const Color grey = Color(0xFF6B7280);
  static const Color lightGrey = Color(0xFFD1D5DB);
  static const Color darkGrey = Color(0xFF374151);

  static const Color red = Color(0xFFDC2626);
  static const Color green = Color(0xFF16A34A);
  static const Color orangeAccent = Color(0xFFF59E0B);

  static const Color blue = Color(0xFF3B82F6);
  static const Color blueAccent = Color(0xFF60A5FA);

  static const Color transparent = Colors.transparent;

  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [gradientStart, gradientEnd],
  );
}
