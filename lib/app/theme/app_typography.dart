import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

/// Atmos Design System Typography
class AppTypography {
  AppTypography._();

  // Display Styles (Manrope)
  static TextStyle displayLargeMobile({Color color = AppColors.onPrimary}) {
    return GoogleFonts.manrope(
      fontSize: 32,
      fontWeight: FontWeight.w700,
      height: 36 / 32,
      letterSpacing: -0.75,
      color: color,
    );
  }

  static TextStyle displayLarge({Color color = AppColors.onPrimary}) {
    return GoogleFonts.manrope(
      fontSize: 48,
      fontWeight: FontWeight.w700,
      height: 52 / 48,
      letterSpacing: -1.0,
      color: color,
    );
  }

  // Headline Styles (Manrope)
  static TextStyle headlineLargeMobile({Color color = AppColors.onSurface}) {
    return GoogleFonts.manrope(
      fontSize: 24,
      fontWeight: FontWeight.w700,
      height: 30 / 24,
      letterSpacing: -0.25,
      color: color,
    );
  }

  static TextStyle headlineMedium({Color color = AppColors.onSurface}) {
    return GoogleFonts.manrope(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      height: 26 / 20,
      letterSpacing: -0.2,
      color: color,
    );
  }

  static TextStyle titleLarge({Color color = AppColors.onSurface}) {
    return GoogleFonts.manrope(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      height: 24 / 18,
      letterSpacing: 0,
      color: color,
    );
  }

  // Title Styles (Inter)
  static TextStyle titleMedium({Color color = AppColors.onSurface}) {
    return GoogleFonts.inter(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      height: 22 / 16,
      letterSpacing: 0,
      color: color,
    );
  }

  static TextStyle titleSmall({Color color = AppColors.onSurface}) {
    return GoogleFonts.inter(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      height: 20 / 14,
      letterSpacing: 0.1,
      color: color,
    );
  }

  // Body Styles (Inter)
  static TextStyle bodyLarge({Color color = AppColors.onSurface}) {
    return GoogleFonts.inter(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      height: 24 / 16,
      letterSpacing: 0,
      color: color,
    );
  }

  static TextStyle bodyMedium({Color color = AppColors.onSurfaceVariant}) {
    return GoogleFonts.inter(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      height: 20 / 14,
      letterSpacing: 0,
      color: color,
    );
  }

  static TextStyle bodySmall({Color color = AppColors.onSurfaceVariant}) {
    return GoogleFonts.inter(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      height: 16 / 12,
      letterSpacing: 0.1,
      color: color,
    );
  }

  // Label Styles (Inter)
  static TextStyle labelLarge({Color color = AppColors.onSurface}) {
    return GoogleFonts.inter(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      height: 20 / 14,
      letterSpacing: 0.1,
      color: color,
    );
  }

  static TextStyle labelMedium({Color color = AppColors.onSurfaceVariant}) {
    return GoogleFonts.inter(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      height: 16 / 12,
      letterSpacing: 0.2,
      color: color,
    );
  }

  static TextStyle labelSmall({Color color = AppColors.onSurfaceVariant}) {
    return GoogleFonts.inter(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      height: 16 / 12,
      letterSpacing: 0.3,
      color: color,
    );
  }
}
