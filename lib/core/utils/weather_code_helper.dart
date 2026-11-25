import 'package:flutter/material.dart';
import '../../app/theme/app_colors.dart';

class WeatherCodeInfo {
  final String description;
  final IconData icon;
  final Color iconColor;
  final String note;

  const WeatherCodeInfo({
    required this.description,
    required this.icon,
    required this.iconColor,
    required this.note,
  });
}

class WeatherCodeHelper {
  WeatherCodeHelper._();

  static WeatherCodeInfo getInfo(int? code, {double? windSpeed, double? precipitation}) {
    if (code == null) {
      return const WeatherCodeInfo(
        description: 'Clear',
        icon: Icons.wb_sunny_rounded,
        iconColor: AppColors.warningSun,
        note: 'Calm conditions throughout the day',
      );
    }

    switch (code) {
      case 0:
        return const WeatherCodeInfo(
          description: 'Clear Sky',
          icon: Icons.wb_sunny_rounded,
          iconColor: AppColors.warningSun,
          note: 'Clear skies with pleasant sunshine',
        );
      case 1:
        return const WeatherCodeInfo(
          description: 'Mainly Clear',
          icon: Icons.wb_sunny_rounded,
          iconColor: AppColors.warningSun,
          note: 'Mostly sunny with light passing clouds',
        );
      case 2:
        return const WeatherCodeInfo(
          description: 'Partly Cloudy',
          icon: Icons.cloud_outlined,
          iconColor: AppColors.secondary,
          note: 'Partly cloudy with gentle breeze',
        );
      case 3:
        return const WeatherCodeInfo(
          description: 'Overcast',
          icon: Icons.cloud_rounded,
          iconColor: AppColors.secondary,
          note: 'Overcast skies with steady cloud cover',
        );
      case 45:
      case 48:
        return const WeatherCodeInfo(
          description: 'Foggy',
          icon: Icons.foggy,
          iconColor: AppColors.secondary,
          note: 'Reduced visibility due to dense fog',
        );
      case 51:
      case 53:
      case 55:
        return const WeatherCodeInfo(
          description: 'Drizzle',
          icon: Icons.water_drop_outlined,
          iconColor: AppColors.tertiary,
          note: 'Light misty drizzle expected',
        );
      case 56:
      case 57:
        return const WeatherCodeInfo(
          description: 'Freezing Drizzle',
          icon: Icons.ac_unit_rounded,
          iconColor: AppColors.cyanAccent,
          note: 'Icy conditions and freezing drizzle',
        );
      case 61:
        return const WeatherCodeInfo(
          description: 'Light Rain',
          icon: Icons.grain_rounded,
          iconColor: AppColors.tertiary,
          note: 'Intermittent light rain showers',
        );
      case 63:
        return const WeatherCodeInfo(
          description: 'Moderate Rain',
          icon: Icons.water_drop_rounded,
          iconColor: AppColors.tertiary,
          note: 'Steady rainfall across the area',
        );
      case 65:
        return const WeatherCodeInfo(
          description: 'Heavy Rain',
          icon: Icons.thunderstorm_outlined,
          iconColor: AppColors.tertiary,
          note: 'Heavy persistent downpours',
        );
      case 66:
      case 67:
        return const WeatherCodeInfo(
          description: 'Freezing Rain',
          icon: Icons.ac_unit_rounded,
          iconColor: AppColors.cyanAccent,
          note: 'Freezing rain creating slick conditions',
        );
      case 71:
      case 73:
      case 75:
        return const WeatherCodeInfo(
          description: 'Snow Fall',
          icon: Icons.ac_unit_rounded,
          iconColor: AppColors.skyGlow,
          note: 'Snowfall accumulating throughout the day',
        );
      case 77:
        return const WeatherCodeInfo(
          description: 'Snow Grains',
          icon: Icons.ac_unit_rounded,
          iconColor: AppColors.skyGlow,
          note: 'Crisp air with light snow flurries',
        );
      case 80:
      case 81:
      case 82:
        return const WeatherCodeInfo(
          description: 'Rain Showers',
          icon: Icons.water_drop_rounded,
          iconColor: AppColors.tertiary,
          note: 'Scattered rain showers expected',
        );
      case 85:
      case 86:
        return const WeatherCodeInfo(
          description: 'Snow Showers',
          icon: Icons.ac_unit_rounded,
          iconColor: AppColors.skyGlow,
          note: 'Cold wind with passing snow showers',
        );
      case 95:
        return const WeatherCodeInfo(
          description: 'Thunderstorm',
          icon: Icons.thunderstorm_rounded,
          iconColor: AppColors.warningSun,
          note: 'Thunderstorms with gusty wind activity',
        );
      case 96:
      case 99:
        return const WeatherCodeInfo(
          description: 'Thunderstorm & Hail',
          icon: Icons.thunderstorm_rounded,
          iconColor: AppColors.warningSun,
          note: 'Severe thunderstorm with hail',
        );
      default:
        return const WeatherCodeInfo(
          description: 'Clear',
          icon: Icons.wb_sunny_rounded,
          iconColor: AppColors.warningSun,
          note: 'Mild atmospheric conditions',
        );
    }
  }
}
