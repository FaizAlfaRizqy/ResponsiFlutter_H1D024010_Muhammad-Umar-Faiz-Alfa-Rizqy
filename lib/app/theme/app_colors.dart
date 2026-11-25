import 'package:flutter/material.dart';

/// Atmos Design System Colors
class AppColors {
  AppColors._();

  // Core Brand Accents
  static const Color skyAccent = Color(0xFF0EA5E9);
  static const Color cyanAccent = Color(0xFF06B6D4);
  static const Color navyDeep = Color(0xFF0F2942);
  static const Color navyMid = Color(0xFF17426B);
  static const Color skyGlow = Color(0xFF38BDF8);
  static const Color warningSun = Color(0xFFF59E0B);

  // Light Palette
  static const Color primary = Color(0xFF0F2942);
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color primaryContainer = Color(0xFFD1E4FF);
  static const Color onPrimaryContainer = Color(0xFF001D35);

  static const Color secondary = Color(0xFF006591);
  static const Color onSecondary = Color(0xFFFFFFFF);
  static const Color secondaryContainer = Color(0xFFE5F2FF);
  static const Color onSecondaryContainer = Color(0xFF00344D);

  static const Color tertiary = Color(0xFF00687A);
  static const Color onTertiary = Color(0xFFFFFFFF);
  static const Color tertiaryContainer = Color(0xFFD8F6FF);
  static const Color onTertiaryContainer = Color(0xFF001F26);

  static const Color error = Color(0xFFBA1A1A);
  static const Color onError = Color(0xFFFFFFFF);
  static const Color errorContainer = Color(0xFFFFDAD6);
  static const Color onErrorContainer = Color(0xFF410002);

  static const Color background = Color(0xFFF7FAFD);
  static const Color onBackground = Color(0xFF181C1E);

  static const Color surface = Color(0xFFF7FAFD);
  static const Color surfaceDim = Color(0xFFD7DADD);
  static const Color surfaceBright = Color(0xFFFFFFFF);
  static const Color surfaceContainerLowest = Color(0xFFFFFFFF);
  static const Color surfaceContainerLow = Color(0xFFF1F4F7);
  static const Color surfaceContainer = Color(0xFFEBEEF1);
  static const Color surfaceContainerHigh = Color(0xFFE5E8EB);
  static const Color surfaceContainerHighest = Color(0xFFE0E3E6);

  static const Color onSurface = Color(0xFF181C1E);
  static const Color onSurfaceVariant = Color(0xFF43474D);
  static const Color outline = Color(0xFF74777E);
  static const Color outlineVariant = Color(0xFFC3C6CE);

  // Gradients
  static const List<Color> heroGradient = [
    navyDeep,
    navyMid,
    skyAccent,
  ];
}
